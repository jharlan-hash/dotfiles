set -g fish_greeting
set -Ux EDITOR nvim
set -Ux VISUAL nvim

if status is-interactive
    #neofetch
    alias conf="nvim ~/.config/fish/config.fish"
    alias c="clear && source ~/.config/fish/config.fish"
    alias r="cargo run -q"
    zoxide init --cmd cd fish | source

end

source (/opt/homebrew/bin/starship init fish --print-full-init | source )⏎
eval "$(/opt/homebrew/bin/brew shellenv)"
fzf --fish | source
