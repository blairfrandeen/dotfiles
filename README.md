# Blair's dotfiles

Installation instructions:
1. Cone this repo
2. Run `./dotinstall`
3. Hope for the best

## Files covered by `dotinstall` script (linux only)
- `.vimrc`
- `.bashrc`
- `.bash_aliases`
- `.input_rc`
- `.gitconfig`

## Files not covered by install script (windows)
- Espanso `default.yml` - needs to be manually copied or linked to espanso directory
- Obsidian `obsidian.css` - manually copied to `.obsidian` folder in vault

## Copying files to Windows:
Make sure to specify the correct paths:
```Shell
git clone https://github.com/blairfrandeen/dotfiles
mklink /J "C:\Users\blair\My Drive\Notes\.obsidian" "C:\Users\blair\dotfiles\
obsidian"
mklink /J "C:\Users\blair\AppData\Roaming\espanso" "C:\Users\blair\dotfiles\espanso"
```
