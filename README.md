# Blair's dotfiles
Installation instructions:
1. Cone this repo
2. Run `./dotinstall` (linux only) - note that this may run into problems if any of the files listed below already exist.
3. Make junctions for obsidian and espanso (windows)

## Files covered by `dotinstall` script (linux only)
- `.vimrc`
- `.bashrc`
- `.bash_aliases`
- `.input_rc`
- `.gitconfig`

## Files not covered by install script (windows)
Make sure to specify the correct paths:
```Shell
git clone https://github.com/blairfrandeen/dotfiles
mklink /J "C:\Users\blair\My Drive\Notes\.obsidian" "C:\Users\blair\dotfiles\
obsidian"
mklink /J "C:\Users\blair\AppData\Roaming\espanso" "C:\Users\blair\dotfiles\espanso"
```
