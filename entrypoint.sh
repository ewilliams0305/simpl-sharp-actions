#!/bin/sh -l

echo "Running simpl-sharp-action against project $1 $2 $3"

# EXIT IF COMMANDS FAIL
set -e

directory=$(dirname "$1")
project_name=$(basename "$1" .csproj)
assembly_name=$(basename "$1" .dll)
csproj_file_path="/github/workspace/$1"
clz_file_name="${project_name}.clz"
dll_file_name="${project_name}.dll"
clz_file_path="/github/workspace/clz/$2/$clz_file_name"
dll_file_path="/github/workspace/bin/$2/$dll_file_name"

# Query project file for required package references and determine if we should create a CPZ or CLZ
library_package=$(grep -oP '(?<=<PackageReference Include="Crestron.SimplSharp.SDK.Library").*' "$csproj_file_path")
program_package=$(grep -oP '(?<=<PackageReference Include="Crestron.SimplSharp.SDK.Program").*' "$csproj_file_path")

if [[ -n "$program_package" ]]; then
  project_type="cpz"
elif [[ -n "$library_package" && -z "$program_package" ]]; then
  project_type="clz"
else
  echo "Target project file does not reference the SIMPL Sharp Packages"
  exit 1
fi

echo "Target project should produce .$project_type"

dotnet dotnet tool install --local SimplSharp.Tool --version 0.2.0 --create-manifest-if-needed 

dotnet simplsharp targets -d /github/workspace/$directory

dotnet build "$csproj_file_path" -c "$3" -o "/github/workspace/bin/$2"

echo "Target Project: $csproj_file_path"
echo "Target Assembly: $dll_file_path"

mkdir -pv "/github/workspace/clz/$2"

dotnet simplsharp clz -p $csproj_file_path -a $dll_file_path -d /github/workspace/clz/$2

if [ ! -f $clz_file_path ]; then
  echo "Error: CLZ file not found at $clz_file_path"
  exit 1
fi

echo "Created CLZ $clz_file_path"

echo "file_output=clz/$2/$clz_file_name" >> $GITHUB_OUTPUT
echo "artifacts_path=clz/*/**.clz" >> $GITHUB_OUTPUT