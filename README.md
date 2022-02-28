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

```Shell
git clone https://github.com/blairfrandeen/dotfiles
xcopy /s /i obsidian "\Users\blair\My Drive\Notes\.obsidian"
```
