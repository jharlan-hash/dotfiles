set -g fish_greeting
set -Ux EDITOR nvim
set -Ux VISUAL nvim

if status is-interactive
    #neofetch
    alias conf="nvim ~/.config/fish/config.fish"
    alias c="clear && source ~/.config/fish/config.fish"
    alias cp="cp -v"
    zoxide init --cmd cd fish | source

end

fish_vi_key_bindings
set starship_path (which starship)
source ($starship_path init fish --print-full-init | psub )
fzf --fish | source
