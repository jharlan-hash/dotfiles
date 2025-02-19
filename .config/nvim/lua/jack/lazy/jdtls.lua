return {
   'mfussenegger/nvim-jdtls',
    -- setup options

    opts = {
        cmd = { 'jdtls' },
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
        vim.keymap.set("n", "gt", function() vim.lsp.buf.definition() end),
        vim.keymap.set("n", "gk", function() vim.lsp.buf.hover() end),
        vim.keymap.set("n", "dn", function() vim.diagnostic.goto_next() end),
        vim.keymap.set("n", "dp", function() vim.diagnostic.goto_prev() end),
        vim.keymap
            .set("n", "<C-CR>", function() vim.lsp.buf.code_action() end),
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end),
        vim.keymap
            .set("n", "<leader>vrn", function() vim.lsp.buf.rename() end),

    },
    -- setup nvim-jdtls
    config = function(_, opts)
        -- vim api auto-command to start_or_attach this only for java
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                -- prints and pcall are there only to give quick feedback if it works. 
                pcall(require('jdtls').start_or_attach, opts)
            end
        })
    end
}
