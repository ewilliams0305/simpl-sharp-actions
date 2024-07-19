#!/bin/sh -l

echo "Running simpl-sharp-action against project $1 $2 $3"

# EXIT IF COMMANDS FAIL
set -e

directory=$(dirname "$1")
project_name=$(basename "$1" .csproj)
clz_file_name="${project_name}.clz"
clz_file_path="/github/workspace/bin/$2/$clz_file_name"

dotnet dotnet tool install --local SimplSharp.Tool --version 0.2.0 --create-manifest-if-needed 

dotnet simplsharp targets -d /github/workspace/$directory

dotnet build /github/workspace/$1 -c $3 -o /github/workspace/bin/$2

if [ ! -f "$clz_file_path" ]; then
  echo "Error: CLZ file not found at $clz_file_path"
  exit 1
fi

echo "Created CLZ $clz_file_path"

echo "clz_file=./bin/$2/$clz_file_name" >> $GITHUB_OUTPUT