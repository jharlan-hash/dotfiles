require("jack.set");
require("jack.remap");
require("jack.lazy_init");

local navbuddy = require("nvim-navbuddy")

require("lspconfig").clangd.setup {
    on_attach = function(client, bufnr)
        navbuddy.attach(client, bufnr)
    end
}

require("lspconfig").jdtls.setup {
    on_attach = function(client, bufnr)
        navbuddy.attach(client, bufnr)
    end
}

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

require("dirbuf").setup {
    hash_padding = 2,
}

--vim.api.nvim_set_hl(0, 'Comment', { italic=false })

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
