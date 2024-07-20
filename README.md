<img src="./target.png" alt="drawing" width="100"/>

![Static Badge](https://img.shields.io/badge/SIMPL-green)
![Static Badge](https://img.shields.io/badge/SHARP-blue)
![Static Badge](https://img.shields.io/badge/TARGETS-red)

# Simpl Sharp Actions
github action used to build Crestron SIMPL Sharp libraries and applications

*Note only a single CLZ can be created using this action at the moment, see issues for roadmap*

[Usage Example - Simpl Sharp Targets](https://github.com/ewilliams0305/simpl-sharp-targets/blob/61fa7543ec0da7afba4b86704b4b014d96cefe12/.github/workflows/simpl-sharp.yml)

## Inputs

## `project`

**Required** File path or glob for the csproj file to compile `"./source/**.csproj"`.
*Note currently only a fullpath to the .csproj file is functional*

## Outputs

## `clz_path`

The file path for the generated CLZ.
**note this will be null if the target project is a SimplSharp program**

## `cpz_path`

The file path for the generated CPZ.
**note this will be null if the target project is a SimplSharp library**
*note not currently supported*

## Example usage

```yaml
- name: Simpl Sharp
  uses: ewilliams0305/simpl-sharp-actions@v0.0.18
  id: clz 
  with: 
    project: example/SimplSharp.Action.Clz/SimplSharp.Action.Clz.csproj
    targets: net472
    configuration: Release

- name: Display CLZ Output path
  run: echo ${{ steps.clz.outputs.clz_file }}

- name: Upload CLZ Artifact
  uses: actions/upload-artifact@v4
  with:
    name: clz_files
    path: ./${{ steps.clz.outputs.artifacts_path }}
```
