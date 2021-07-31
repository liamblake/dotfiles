set DOTFILES=%~dp0..\..

mklink /D %USERPROFILE%\AppData\Local\nvim %DOTFILES%\config\nvim