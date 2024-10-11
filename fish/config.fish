if status is-interactive
    # Commands to run in interactive sessions can go here
end


# Use vi key bindings
fish_vi_key_bindings

bind --mode insert \cn down-or-search
bind --mode insert \cp up-or-search

if which python3.13 &> /dev/null
    alias python3='uv run --python=3.13 python3'
end

abbr -a gs 'git status'
abbr -a vim nvim
abbr -a python python3
abbr -a ipython ipython3
abbr -a actenv 'source venv/bin/activate.fish'
abbr -a cat bat
abbr -a gl "git log --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)%cd%C(reset) %C(blue)%an%C(reset) %C(green)%d%C(reset)' --date=format:'%a %b %e, %Y' --graph"
abbr -a grep rg
abbr -a ls exa

# fly io
set -x FLYCTL_INSTALL "/home/blair/.fly"
set -x PATH "$FLYCTL_INSTALL/bin" $PATH

