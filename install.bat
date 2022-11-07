echo "Cloning repository..."
git clone https://github.com/blairfrandeen/dotfiles

echo "Making symbolic links..."
mklink /J "C:\Users\%username%\My Drive\Notes\.obsidian" "C:\Users\%username%\dotfiles\
obsidian"
mklink /J "C:\Users\%username%\AppData\Roaming\espanso" "C:\Users\%username%\dotfiles\espanso"
mklink "C:\Users\%username%\AppData\Roaming\Code\User\settings.json" "C:\Users\%username%\dotfiles\vscode"
echo "Getting submodules..."
git submodule update --init --remote
