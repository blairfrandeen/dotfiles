echo "Cloning repository..."
git clone https://github.com/blairfrandeen/dotfiles

echo "Making symbolic links..."
mklink /J "C:\Users\%username%\My Drive\Notes\.obsidian" "C:\Users\%username%\dotfiles\
obsidian"
mklink /J "C:\Users\%username%\AppData\Roaming\espanso" "C:\Users\%username%\dotfiles\espanso"
echo "Getting submodules..."
git submodule update --init --remote
