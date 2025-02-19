function ColorMyPencils(color)
	color = color or "lunar"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, 'Comment', { italic=false })
end

return {
    {
        "LunarVim/lunar.nvim",
        name = "lunar",
        priority = 1000,
        lazy = "false",
    }
}
