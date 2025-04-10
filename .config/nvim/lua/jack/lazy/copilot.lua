return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "BufRead",
    config = function()
        require("copilot").setup({
            panel = {
                auto_refresh = true,
            },
            suggestion = {
                auto_trigger = true,
                accept = false,
                keymap = {
                    next = "<M-j>",
                    prev = "<M-k>",
                    dismiss = "<C-]>",
                },

            },
            filetypes = {
                gleam = false,
            },

        })

    end;

}
