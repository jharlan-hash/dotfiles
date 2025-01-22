vim.g.mapleader = " "

-- best remap of all time
vim.keymap.set("n", "<leader>jh", vim.cmd.Dirbuf)

-- hop
vim.keymap.set("n", "<leader>h", "<cmd>HopWord<cr>")

-- quick save
vim.keymap.set("n", "<leader>k", vim.cmd.w)


-- i hate when enter moves the cursor for some reason
vim.keymap.set('n', '<CR>', 'm`o<Esc>``')
vim.keymap.set('n', '<S-CR>', 'm`O<Esc>``')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- concatenate
vim.keymap.set("n", "J", "mzJ`z") vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- navbuddy is awesome
vim.keymap.set("n", "<leader>l", "<cmd>Navbuddy<cr>")

-- little function to add a semicolon at the end of the line
vim.keymap.set('n', '<leader>;', function()
    local cur_pos = vim.fn.getcurpos()
    local line = vim.fn.getline('.')
    if not line:match(';%s*$') then
        vim.cmd('normal! A;')
    end
    vim.fn.setpos('.', cur_pos)
end, { noremap = true, silent = true })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

-- i love lsp formatting
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- great regex for finding and changing all instances
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
