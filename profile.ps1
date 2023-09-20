# PowerShell Profile
# Run `Set-ExecutionPolicy Bypass` from an admin shell if not working

# Aliases
#########
function GitStatus {git status}
function GitPull {git pull}
function GitPush {git push}
function PythonActivateVenv {venv\scripts\activate}
Set-Alias gs GitStatus
Set-Alias -Name gp -Value GitPull -Force -Option Allscope
Set-Alias -Name cat -Value bat -Force -Option Allscope
Set-Alias gpu GitPush
Set-Alias grep rg
Set-Alias actenv PythonActivateVenv

# Activate a pipx virtual environment based on the current directory
function actx {
  $dirname = Split-Path -Leaf (Get-Location)
  & ~\.local\pipx\venvs\$dirname\Scripts\activate.ps1
}

# Quality-Of-Life
#################
Set-PSReadLineOption -EditMode vi -BellStyle None
Set-PSReadLineKeyHandler -Key Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Ctrl+n -Function HistorySearchForward

# Fzf
# Used The following commands from an admin shell to get this working:
# choco install fzf
# Install-Module -Name PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
