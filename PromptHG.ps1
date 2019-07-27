# Title: PromptHG
# Author: Theodore Mike
# Description: Displays basic Mercurial info in the PowerShell prompt.

# Copyright 2019 Theodore J. Mike
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
# FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# THE SOFTWARE MAY NOT BE USED FOR ANYTHING HATEFUL, ILLEGAL, PORNOGRAPHIC, OR RELIGIOUSLY OFFENSIVE.  THE AUTHOR RESERVES THE RIGHT
# TO ALTER THIS LICENSE AT ANY TIME.

## General Rules (Mt. 23: 37, 39)
# ...Love the Lord your God with all your hear, with all your soul, with all your mind.
# ...Love your neighbor as you love yourself.


# Settings
$global:promptConfig = [PSCustomObject]@{
    # Title Settings
    ShowTitle                   = $true
    ShowTitleLocation           = $true
    ShowTitleBranch             = $true
    ShowTitleChanges            = $true
    TitleChangesIndicator       = "*"

    # Prompt Display Settings
    ShowPromptLocation          = $true
    ShowPromptBranch            = $true
    ShowPromptNumChanges        = $true
    ShowPromptParent            = $true
    
    # Separators
    HgInfoStart                 = "["
    HgInfoEnd                   = "]"
    NumChangesStart             = "("
    NumChangesEnd               = ")"
    PromptEnd                   = ">"    
    
    # Prompt Colors
    PSColor                     = "White"
    LocationColor               = "White"
    HgInfoSeparatorColor        = "Green"
    BranchColor                 = "Cyan"
    ParentColor                 = "Green"
    NumChangesSeparatorColor    = "Yellow"
    NumChangesColor             = "Yellow"        
    PromptEndColor              = "White"   
}


function Get-HG-Parent
{
    $summary = hg summary
    $parent = $summary[0].Replace("parent: ", "").Trim();
    return $parent
}

function Get-HG-Branch
{
    $branch = hg branch
    return $branch.Trim()
}

function Get-HG-Num-Changes
{
    $status = hg status
    return $status.Count;
}

function Show-PromptHG
{
    $title = ""   
    $location = $(Get-Location)
    $branch = $(Get-HG-Branch)
    $numChanges = 0

    # Prompt - Start
    Write-Host -NoNewline "PS" -ForegroundColor $promptConfig.PSColor

    # Prompt - Location
    if ($promptConfig.ShowPromptLocation) {
        Write-Host -NoNewline " "
        Write-Host -NoNewline $location -ForegroundColor $promptConfig.LocationColor
    }

    # Prompt - HG Info    
    if(-not $branch -eq ""){
        # HG Info - Start
        Write-Host -NoNewline " "
        Write-Host -NoNewline $promptConfig.HgInfoStart -ForegroundColor $promptConfig.HgInfoSeparatorColor

        # HG Info -  Branch
        if($promptConfig.ShowPromptBranch) {            
            Write-Host -NoNewline $Branch -ForegroundColor $promptConfig.BranchColor
        }

        # HG Info - Parent
        if($promptConfig.ShowPromptParent) {
            Write-Host -NoNewline " "
            $parent = $(Get-HG-Parent)

            Write-Host -NoNewline $parent -ForegroundColor $promptConfig.ParentColor
        }

        # HG Info - Number of Changes
        $numChanges = $(Get-HG-Num-Changes)
        if($promptConfig.ShowPromptNumChanges) {
            if($numChanges -gt 0){
                Write-Host -NoNewline " "
                Write-Host -NoNewline $promptConfig.NumChangesStart -ForegroundColor $promptConfig.NumChangesSeparatorColor
                Write-Host -NoNewline $numChanges -ForegroundColor $promptConfig.NumChangesColor
                Write-Host -NoNewline $promptConfig.NumChangesEnd -ForegroundColor $promptConfig.NumChangesSeparatorColor
            }            
        }

        # HG Info - End
        Write-Host -NoNewline $promptConfig.HgInfoEnd -ForegroundColor $promptConfig.HgInfoSeparatorColor
        Write-Host -NoNewline " "

        # Setup Title - HG Info
        if ($promptConfig.ShowTitle){
            if($promptConfig.ShowTitleBranch)
            {
                $title += $branch
            }
            if ($promptConfig.ShowTitleChanges)
            {
                if($numChanges -gt 0){
                   $title += $promptConfig.TitleChangesIndicator
                }
            }
        }
    }

    # Setup Title - Location
    if ($promptConfig.ShowTitle -and $promptConfig.ShowTitleLocation) {
        if(-not $title.Length -eq 0)
        {
            $title += " - "
        }
        $title += $location
    }
 
    # Prompt - End
    Write-Host -NoNewline $promptConfig.PromptEnd -ForegroundColor $promptConfig.PromptEndColor
    
    # Title - Show
    if ($promptConfig.ShowTitle){
        $host.ui.rawui.WindowTitle = $title        
    }
    return " "    
}

# Replace the prompt
function Prompt
{
    return Show-PromptHG
}
