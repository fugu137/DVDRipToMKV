### Functions ###

#Function to set source (.ifo) path from user input
function Set-SourcePath {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ref] 
        $SourcePath,

        [ValidateScript({Test-Path $_ -PathType 'Container'})]
        [string] 
        $NewPath
    )

    $SourcePath.Value = $NewPath
    Write-Host "Source path changed to: $NewPath" -ForegroundColor White
}

#Function to set location of makemkvcon.exe from user input
function Set-ExePath {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ref] 
        $ExePath,

        [ValidateScript({$_ -like '*makemkvcon.exe' -and (Test-Path $_ -PathType 'Leaf')})]
        [string] 
        $NewPath
    )

    $ExePath.Value = $NewPath
    Write-Host "makemkv.exe path changed to: $NewPath" -ForegroundColor White
}

#Function to set save folder for .mkv files from user input
function Set-SaveFolder {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ref] 
        $SaveFolder,

        [ValidateScript({$_ -like '*:\*' -and (New-Item -Path $_ -ItemType Directory -Force)})]
        [string] 
        $NewPath
    )

    $SaveFolder.Value = $NewPath
    Write-Host "Folder to save .mkv files into set to: $NewPath" -ForegroundColor White
}

##### Main Script #####
Clear-Host

#Source paths for DVD rip folder and makemkvcon.exe file
[string] $sourcePath = 'D:\Movies'    
[string] $exePath = 'C:\Program Files (x86)\MakeMKV\makemkvcon.exe'

#Folder to save .mkv files into (contained in a folder with the movie name). If left as null, the script will save each .mkv into the same folder as the source.
[string] $saveFolderName = $null


### Display title & Main Menu (prompts user to change videos folder, makemkv.exe location, save location, or continue with defaults) ###

Write-Host ''
Write-Host '----BATCH CONVERT DVD RIPS TO MKV FILES----' -ForegroundColor White
    
while ($true) {
    Write-Host ''
    Write-Host "[1] Location of folder containing DVD rips   [$sourcePath]" -ForegroundColor Yellow
    Write-Host "[2] Location of makemkvcon.exe               [$exePath]" -ForegroundColor Yellow

    if (!$saveFolderName) {
        Write-Host '[3] Location to save .mkv files into         [Files are saved into the same folder as the folders containing the source .ifo files]' -ForegroundColor Yellow
    } else {
        Write-Host "[3] Location to save .mkv files into         [$saveFolderName]" -ForegroundColor Yellow
    }
    Write-Host ''
    

    $response = Read-Host 'Press ENTER to continue, or type ''1'', ''2'', or ''3'' to choose where the script will look for ripped DVDs, for makemkvcon.exe, or where the new .mkv files will be saved (''exit'' exits)'

    if ($response -eq '') {
        break

    } elseif ($response -eq '1') {
        $text = Read-Host 'Please enter the full path of the folder containing your DVD rips, or type ''back'' to return to the main menu'

        if ($text -eq 'back') {
            continue
        } else {
            Set-SourcePath -SourcePath ([ref]$sourcePath) -NewPath $text
            continue
        }
        
    } elseif ($response -eq '2') {
        $text = Read-Host 'Please enter the full path of the folder containing makemkvcon.exe, or type ''back'' to return to the main menu'

        if ($text -eq 'back') {
            continue
        } else {
            Set-ExePath -ExePath ([ref]$exePath) -NewPath $text
            continue
        }

    } elseif ($response -eq '3') {
        $text = Read-Host 'Please enter the full path of the folder you would like to save your new .mkv files into, or type ''same'' to save into the same folder as the source (''back'' returns to the main menu)'
    
        if ($text -eq 'back') {
            continue
        } elseif ($text -eq 'same') {
            $saveFolderName = $null
        } else {
            Set-SaveFolder -SaveFolder ([ref]$saveFolderName) -NewPath $text
            continue
        }

    } elseif ($response -eq 'exit') {
        exit
    
    } else {
        Write-Host 'Invalid entry; please try again'
        continue
    }
}


### Convert to MKV ###

[int] $numberCompleted = 0
[int] $numberSkipped = 0

#Get all folders containing .IFO files and run makemkvcon.exe on each
Set-Alias makemkv $exePath

Get-ChildItem $sourcePath -Filter "VIDEO_TS.IFO" -Recurse | ForEach-Object {

    $directory = $_.Directory
    $filePath = $directory.FullName
    $parentFolder = Split-Path $directory
    $parentName = $directory.Parent.Name

    $savePath
    $searchFolder
    
    if (!$saveFolderName) {
        $searchFolder = $parentFolder
        $savePath = "$parentFolder\$parentName.mkv"

    } else {
        $searchFolder = "$saveFolderName\$parentName"
        $savePath = "$saveFolderName\$parentName\$parentName.mkv"
        New-Item -Path $searchFolder -ItemType Directory -Force
    }

    $video = Get-ChildItem $searchFolder -Filter *.mkv

    if ($null -eq $video) {
        Write-Host "Making .mkv from file in $filePath..." -ForegroundColor DarkGreen

        #Makes mkv file at the same location as the source files
        makemkv mkv file:"$filePath" all "$searchFolder"
        
        #Renames mkv file to match parent folder name
        Move-Item -Path "$searchFolder\title_t00.mkv" -Destination $savePath
                       
        #Update and print progress
        $numberCompleted++

        Write-Host ''
        Write-Host 'Progress:' -ForegroundColor Magenta
        Write-Host "Total number of files converted: $numberCompleted" -ForegroundColor Magenta
        Write-Host "Total number of files skipped: $numberSkipped" -ForegroundColor Magenta
        Write-Host ''

    } else {
        Write-Host ".mkv file already exists at $searchFolder; skipping..." -ForegroundColor DarkYellow

        #Update and print progress
        $numberSkipped++

        Write-Host ''
        Write-Host 'Progress:' -ForegroundColor Magenta
        Write-Host "Total number of files converted: $numberCompleted" -ForegroundColor Magenta
        Write-Host "Total number of files skipped: $numberSkipped" -ForegroundColor Magenta
        Write-Host ''
    }

}
