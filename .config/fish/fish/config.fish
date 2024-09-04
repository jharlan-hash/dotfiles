set -g fish_greeting
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -x PATH ~/Library/.jack/homebrew/bin/ $PATH

if status is-interactive
    #neofetch
    alias conf="nvim ~/.config/fish/config.fish"
    alias c="clear && source ~/.config/fish/config.fish"
    alias r="cargo run -q"
    zoxide init --cmd cd fish | source
end
source (/sbin/starship init fish --print-full-init | psub)
