vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("jack.set");
require("jack.remap");
require("jack.lazy_init");

require("noice").setup({
    routes = { -- ts does not work
        {
            filter = {
                any = {
                    { find = "client.request" },
                    { find = "deprecated" },
                },
            },
            opts = { skip = true },
        },
    },
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
    },

})

require("luasnip.loaders.from_snipmate").lazy_load()

require("dirbuf").setup {
    hash_padding = 2,
}

require("illuminate").configure({
    delay = 10,
})

-- require('mini.animate').setup()

require("lsp-endhints").setup()
require("lsp-endhints").enable()

require("notify").setup({
    background_colour = "#1E1E2D", -- The default background color for the floating windows.
})


-- harpoon --
local harpoon = require("harpoon")
harpoon:setup()
-- startup

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-d>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
