#!/bin/sh -l

echo "Running simpl-sharp-action against project $1 $2 $3"

directory=$(dirname "$1")
project_name=$(basename "$1" .csproj)
clz_file="${project_name}.clz"

dotnet dotnet tool install --global SimplSharp.Tool --version 0.2.0

dotnet simplsharp targets -d $directory

dotnet build $1 -c $3 -o ./bin/$2

echo "clz_file=./bin/$2/$clz_file" >> $GITHUB_OUTPUT