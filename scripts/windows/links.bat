REM Some tools can be used and configured in Windows, without using a subsystem.

REM Absolute path of the root directory
set DOTFILES=%~dp0..\..

REM Neovim
mklink /D %USERPROFILE%\AppData\Local\nvim %DOTFILES%\config\nvim

REM Git
REM TODO

REM VSCode
mklink /D %USERPROFILE%\AppData\Roaming\Code\User %DOTFILES%\config\vscode

REM LaTeX style files
REM TODO