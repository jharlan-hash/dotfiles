require("theprimeagen.set")
require("theprimeagen.remap")
require("theprimeagen.lazy_init")

local navbuddy = require("nvim-navbuddy")

require("CopilotChat").setup {}

require("lspconfig").clangd.setup {
    on_attach = function(client, bufnr)
        navbuddy.attach(client, bufnr)
    end
}

require("lspconfig").jdtls.setup{
    on_attach = function(client, bufnr)
        navbuddy.attach(client, bufnr)
    end
}

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('LspAttach', {
    group = ThePrimeagenGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})


vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-d>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

require("luasnip.loaders.from_snipmate").lazy_load()

-- Create the function to record and create mappings
local function setup_keymap_helper()
    local function get_key_notation(key)
        -- Common special key translations
        local special_keys = {
            ['\27'] = '<Esc>',
            ['\r'] = '<CR>',
            ['\n'] = '<CR>',
            ['\t'] = '<Tab>',
            [' '] = '<Space>',
        }

        -- Handle Control combinations
        if #key == 1 and key:byte() <= 26 then
            return '<C-' .. string.char(key:byte() + 96) .. '>'
        end

        -- Handle special keys
        if special_keys[key] then
            return special_keys[key]
        end

        -- Handle regular characters
        if key:match('^[%g%s]$') then  -- Only include printable chars and spaces
            return key
        end
        return ''  -- Skip non-printable characters
    end

    local function start_recording_keys()
        local keys = {}
        local timer = vim.loop.new_timer()
        local callback_id

        -- Create a temporary buffer for showing pressed keys
        local buf = vim.api.nvim_create_buf(false, true)
        local win = vim.api.nvim_open_win(buf, true, {
            relative = 'editor',
            width = 40,
            height = 3,
            row = 3,
            col = 10,
            style = 'minimal',
            border = 'rounded'
        })

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
            'Recording keymap...',
            'Press <Esc> to finish',
            ''
        })

        -- Set up key handling
        local old_mapping = vim.fn.maparg('<Esc>', 'n', false, true)

        local function cleanup()
            -- Remove the on_key callback
            if callback_id then
                vim.on_key(nil, callback_id)
            end

            -- Only restore old mapping if it existed and had an rhs
            if old_mapping.rhs and old_mapping.rhs ~= '' then
                if old_mapping.buffer then
                    vim.keymap.set('n', '<Esc>', old_mapping.rhs, { buffer = old_mapping.buffer })
                else
                    vim.keymap.set('n', '<Esc>', old_mapping.rhs)
                end
            else
                -- Only try to delete if there was a temporary mapping
                pcall(vim.keymap.del, 'n', '<Esc>', { buffer = true })
            end

            -- Close recording window if it still exists
            if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_win_close(win, true)
                vim.api.nvim_buf_delete(buf, { force = true })
            end

            -- Clear the timer
            if timer then
                timer:stop()
                timer:close()
            end
        end

        vim.keymap.set('n', '<Esc>', function()
            -- Format the recorded keys, filtering out any empty strings
            local keymap = table.concat(vim.tbl_filter(function(k) return k ~= '' end, keys))

            -- Copy to clipboard
            vim.fn.setreg('+', keymap)
            vim.notify('Keymap copied to clipboard: ' .. keymap)

            cleanup()
        end, { buffer = true })

        -- Record typed keys
        callback_id = vim.on_key(function(key)
            if #keys == 0 then
                timer:start(3000, 0, vim.schedule_wrap(function()
                    cleanup()
                    vim.notify('Recording timed out')
                end))
            end

            local notation = get_key_notation(key)
            if notation ~= '' then
                table.insert(keys, notation)
                -- Update display if buffer still exists
                if vim.api.nvim_buf_is_valid(buf) then
                    vim.api.nvim_buf_set_lines(buf, 2, 3, false, { table.concat(keys) })
                end
            end
        end)
    end

    -- Create command to start recording
    vim.api.nvim_create_user_command('RecordKeymap', start_recording_keys, {})
end

-- Initialize the keymap helper
setup_keymap_helper()
