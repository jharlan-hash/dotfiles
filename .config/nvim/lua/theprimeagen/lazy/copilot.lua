return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            panel = {
                auto_refresh = true,
            },
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = "<TAB>",
                    next = "<M-j>",
                    prev = "<M-k>",
                    dismiss = "<C-]>",
                },

            },
        })

    end;

}




