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

abbr -a confish 'nvim ~/dotfiles/fish/config.fish'
abbr -a srfish 'source ~/.config/fish/config.fish'

abbr -a dots 'cd ~/dotfiles'

# fly io
set -x FLYCTL_INSTALL "/home/blair/.fly"
set -x PATH "$FLYCTL_INSTALL/bin" $PATH

# UV for python
alias python3.8 'uv run --python=3.8 python3'
alias python3.9 'uv run --python=3.9 python3'
alias python3.10 'uv run --python=3.10 python3'
alias python3.11 'uv run --python=3.11 python3'
alias python3.12 'uv run --python=3.12 python3'
alias python3.13 'uv run --python=3.13 python3'
alias python3 python3.12

# LLM with terse replies, piped to bat
function lc
      llm -t c $argv | bat --language=markdown --style=plain
end
