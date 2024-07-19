#!/bin/sh -l

echo "Running simpl-sharp-action against project $1 $2 $3"

directory=$(dirname "$1")
project_name=$(basename "$1" .csproj)
clz_file="${project_name}.clz"

dotnet dotnet tool install --local SimplSharp.Tool --version 0.2.0 --create-manifest-if-needed 

dotnet simplsharp targets -d /github/workspace/$directory

dotnet build /github/workspace/$1 -c $3 -o ./bin/$2

echo "clz_file=./bin/$2/$clz_file" >> $GITHUB_OUTPUT