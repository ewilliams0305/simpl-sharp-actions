<img src="./target.png" alt="drawing" width="100"/>

![Static Badge](https://img.shields.io/badge/SIMPL-green)
![Static Badge](https://img.shields.io/badge/SHARP-blue)
![Static Badge](https://img.shields.io/badge/TARGETS-red)

# Simpl Sharp Actions
github action used to build Crestron SIMPL Sharp libraries and applications

## Inputs

## `project`

**Required** File path or glob for the csproj file to compile `"./source/**.csproj"`.

## Outputs

## `clz_path`

The file path for the generated CLZ.
**note this will be null if the target project is a SimplSharp program**

## `cpz_path`

The file path for the generated CPZ.
**note this will be null if the target project is a SimplSharp library**

## Example usage

uses: actions/simpl-sharp-actions@v1
with:
  who-to-greet: 'Mona the Octocat'