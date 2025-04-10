vim.g.mapleader = " "

-- my two directory buffers
vim.keymap.set("n", "<leader>jh", vim.cmd.Dirbuf)
-- vim.keymap.set("n", "<leader>jh", vim.cmd.NvimTreeToggle)

-- remapping switching panes to Command + h/j/k/l
vim.keymap.set("n", "<D-h>", "<C-w>h")
vim.keymap.set("n", "<D-j>", "<C-w>j")
vim.keymap.set("n", "<D-k>", "<C-w>k")
vim.keymap.set("n", "<D-l>", "<C-w>l")

-- most annoying command ever
vim.keymap.set("n", "q:", "<nop>");

-- i hate when enter moves the cursor for some reason
vim.keymap.set('n', '<CR>', 'm`o<Esc>``')
vim.keymap.set('n', '<S-CR>', 'm`O<Esc>``')


-- moves lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- concatenate
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

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
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

-- i love lsp formatting
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>r", vim.cmd.LspRestart)

vim.keymap.set("n", "gt", function() vim.lsp.buf.definition() end)

vim.keymap.set("n", "dn", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "dp", function() vim.diagnostic.goto_prev() end)

vim.keymap.set("n", "<C-CR>", function() vim.lsp.buf.code_action() end)

vim.keymap.set("n", "<leader>o",
    -- organize imports
    function()
        vim.lsp.buf.code_action({
            apply = true,
            context = {
                only = { "source.organizeImports" }
            }
        })
    end)
vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end)
vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end)


-- great regex for finding and changing all instances
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
