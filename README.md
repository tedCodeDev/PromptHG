# PromptHG
## Copyright 2019 Theodore J. Mike
---

## Description
Displays basic Mercurial info in the PowerShell prompt.

For license terms, please see License.md.


---

## Installation

To install, you need to add PromptHG.ps1 to your PowerShell profile and place the config file in the same folder as your PowerShell profile.

**For Example:**

1. Edit C:\Users\<UserName>\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 to contain the following: . '<PathToScript>\PromptHG.ps1'
2. Copy PromptHGConfig.json to C:\Users\<UserName>\Documents\WindowsPowerShell\


---

## Configuration
Several aspects of the prompt can be easily adjusted to meet your individual preferences.  To make these customizations, you may change the values of any of the properties of the copy of PromptHGConfig.json that is in you PowerShell profile folder.

| Section    | Property            | Description                                                                                               |
| ---------- | ------------------- | --------------------------------------------------------------------------------------------------------- |
| **Show**   |                     |                                                                                                           |
|            | Title               | Show customized info in the title bar (see the following properties)                                      |
|            | TitleBranch         | Show the current branch in the title bar                                                                  |
|            | TitleLocation       | Show the current path in the title bar                                                                    |
|            | TitleChanges        | Show a symbol indicating uncommitted local changes in the title bar                                       |
|            | PromptPS            | Show "PS" at the beginning of the PowerShell prompt                                                       |
|            | PromptLocation      | Show the current path in the PowerShell prompt                                                            |
|            | PromptBranch        | Show the current branch in the PowerShell prompt                                                          |
|            | PromptNumChanges    | Show the number of uncommitted local changes in the PowerShell prompt                                     |
|            | PromptParent        | Show the parent branch info in the PowerShell prompt                                                      |
| **Symbol** |                     |                                                                                                           |
|            | HgInfoStart         | The symbol to show in the PowerShell prompt before any Mercurial info                                     |
|            | HgInfoEnd           | The symbol to show in the PowerShell prompt after any Mercurial info                                      |
|            | NumChangesStart     | The symbol to show in the PowerShell before the number of uncommitted local changes                       |
|            | NumChangesEnd       | The symbol to show in the PowerShell after the number of uncommitted local changes                        |
|            | PromptEnd           | The symbol to show after the entire PowerShell prompt                                                     |
|            | TitleChanges        | The symbol to show in the titlebar for any uncommitted local changes                                      |
| **Color**  |                     |                                                                                                           |
|            | PS                  | The color of the "PS" that displays at the beginning of the PowerShell prompt                             |
|            | Location            | The color of the current path                                                                             |
|            | HgInfoSeparator     | The color of the symbols that appear immediately before and after the Mercurial info                      |
|            | Branch              | The color of the current branch                                                                           |
|            | Parent              | The color of the parent                                                                                   |
|            | NumChangesSeparator | The color of the symbols that appear immediately before and after the number of uncommitted local changes |
|            | NumChanges          | The color of the number of uncommitted local changes                                                      |
|            | PromptEnd           | The color of the symbol that appears after the entire PowerShell prompt                                   |