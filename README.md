# Blair's dotfiles
Installation instructions:
1. Cone this repo
2. Run `./dotinstall` (Linux) or `install.bat` (Windows) - note that this may run into problems if any of the files listed below already exist.
3. Make junctions for obsidian and espanso (windows)

## Shell Scripts Included
- projects.sh - clone projects stored on github to workspace directory
- programs.sh - install my most commonly used programs
- obsidian.sh - install Obsidian customizations
- cargoinsta.sh - Rust programs :)

## Files covered by `dotinstall` script (linux only)
- `.vimrc`
- `.bashrc`
- `.bash_aliases`
- `.input_rc`
- `.gitconfig`

## Files not covered by install script (windows)
- Obsidian
- Espanso

## Adding a new dotfile (linux)
1. Copy to dotfiles
```sh
cp ~/.config/terminator/config ~/dotfiles/terminator
```
2. Add the following to `dotinstall`:
```sh
ln -s ${BASEDIR}/terminator ~/.config/terminator/config
```
3. Run the above command

