return {
   'mfussenegger/nvim-jdtls',
    -- setup options
    opts = {
        cmd = {"jdtls"},
    };

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
