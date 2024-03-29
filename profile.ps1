# PowerShell Profile
# Run `Set-ExecutionPolicy Bypass` from an admin shell if not working

# Aliases
#########
function GitStatus {git status}
function GitPull {git pull}
function GitPush {git push}
function GitLog {git log --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)%cd%C(reset) %C(blue)%an%C(reset) %C(green)%d%C(reset)' --date=format:'%a %b %e, %Y' --graph}
function PythonActivateVenv {venv\scripts\activate}
Set-Alias gs GitStatus
Set-Alias gl GitLog -Force -Option Allscope
Set-Alias -Name gp -Value GitPull -Force -Option Allscope
Set-Alias -Name cat -Value bat -Force -Option Allscope
Set-Alias gpu GitPush
Set-Alias grep rg
Set-Alias actenv PythonActivateVenv
Set-Alias vim nvim

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
