# Some tools can be used and configured in Windows, without using a subsystem.

# Absolute path of the root directory
$DOTFILES = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

# Create a directory if it does not already exist
function Make-Dir {
    param (
        $Dir
    )

    If(!(test-path $Dir))
    {
        echo "Creating new directory " $Dir
        New-Item -ItemType Directory -Force -Path $Dir
    }
}

# Create a link
function Make-Link {
    param (
        $SourceName,
        $TargetName
    )

    New-Item -Path $TargetName -ItemType SymbolicLink -Value $SourceName
}

# Powershell configuration
$PSDIR = $PROFILE
# Make the config directory if it does not already exist
Make-Dir -Dir PSDIR
Make-Link -TargetName $PSDIR  -SourceName $DOTFILES\powershell

# Neovim
Make-Link -TargetName $env:USERPROFILE\AppData\Local\nvim -SourceName $DOTFILES\config\nvim

# Alacritty
Make-Link -TargetName $env:USERPROFILE\AppData\Roaming\alacritty -SourceName $DOTFILES\config\alacritty

# Git
# TODO

# VSCode
Make-Link -TargetName $env:USERPROFILE\AppData\Roaming\Code\User -SourceName $DOTFILES\config\vscode

# LaTeX style files
# Assumes a MiKTeX installation
# TODO: Automatically detect version?
# for %%f in (%DOTFILES%\tex\latex\*) do mklink /D %USERPROFILE%\AppData\Roaming\MiKTeX\2.9\tex\latex\%%~nxi %%f
