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
$configFileName = "PromptHGConfig.json"
$configFilePath = $PROFILE.Substring(0, $PROFILE.LastIndexOf("\")) + "\$configFileName"  
$global:promptConfig = Get-Content -Raw -Path $configFilePath | ConvertFrom-Json


function Get-HG-Parent
{
    $summary = hg summary
    $parent = $summary[0].Replace("parent: ", "").Trim();
    return $parent
}

function Get-HG-Branch
{
    try {
        $branch = hg branch
        return $branch.Trim()    
    }
    catch {
        return ""
    }    
}

function Get-HG-Num-Changes
{
    try {
        $status = hg status
        return $status.Count;    
    }
    catch {
        return -1
    }    
}

function Show-PromptHG
{
    $title = ""   
    $location = $(Get-Location)
    $branch = $(Get-HG-Branch)
    $numChanges = 0

    # Prompt - Start
    if ($promptConfig.Show.PromptPS) {
        Write-Host -NoNewline "PS" -ForegroundColor $promptConfig.Color.PS
    }

    # Prompt - Location
    if ($promptConfig.Show.PromptLocation) {
        Write-Host -NoNewline " "
        Write-Host -NoNewline $location -ForegroundColor $promptConfig.Color.Location
    }

    # Prompt - HG Info    
    if(-not $branch -eq ""){
        # HG Info - Start
        Write-Host -NoNewline " "
        Write-Host -NoNewline $promptConfig.Symbol.HgInfoStart -ForegroundColor $promptConfig.Color.HgInfoSeparator

        # HG Info -  Branch
        if($promptConfig.Show.PromptBranch) {            
            Write-Host -NoNewline $Branch -ForegroundColor $promptConfig.Color.Branch
        }

        # HG Info - Parent
        if($promptConfig.Show.PromptParent) {
            Write-Host -NoNewline " "
            $parent = $(Get-HG-Parent)

            Write-Host -NoNewline $parent -ForegroundColor $promptConfig.Color.Parent
        }

        # HG Info - Number of Changes
        $numChanges = $(Get-HG-Num-Changes)
        if($promptConfig.Show.PromptNumChanges) {
            if($numChanges -gt 0){
                Write-Host -NoNewline " "
                Write-Host -NoNewline $promptConfig.Symbol.NumChangesStart -ForegroundColor $promptConfig.Color.NumChangesSeparator
                Write-Host -NoNewline $numChanges -ForegroundColor $promptConfig.Color.NumChanges
                Write-Host -NoNewline $promptConfig.Symbol.NumChangesEnd -ForegroundColor $promptConfig.Color.NumChangesSeparator
            }            
        }

        # HG Info - End
        Write-Host -NoNewline $promptConfig.Symbol.HgInfoEnd -ForegroundColor $promptConfig.Color.HgInfoSeparator
        Write-Host -NoNewline " "

        # Setup Title - HG Info
        if ($promptConfig.Show.Title){
            if($promptConfig.Show.TitleBranch)
            {
                $title += $branch
            }
            if ($promptConfig.Show.TitleChanges)
            {
                if($numChanges -gt 0){
                   $title += $promptConfig.Symbol.TitleChanges
                }
            }
        }
    }

    # Setup Title - Location
    if ($promptConfig.Show.Title -and $promptConfig.Show.TitleLocation) {
        if(-not $title.Length -eq 0)
        {
            $title += " - "
        }
        $title += $location
    }
 
    # Prompt - End
    Write-Host -NoNewline $promptConfig.Symbol.PromptEnd -ForegroundColor $promptConfig.Color.PromptEnd
    
    # Title - Show
    if ($promptConfig.Show.Title){
        $host.ui.rawui.WindowTitle = $title        
    }
    return " "    
}

# Replace the prompt
function Prompt
{
    return Show-PromptHG
}
