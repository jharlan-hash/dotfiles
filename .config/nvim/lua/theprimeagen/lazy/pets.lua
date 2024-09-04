return {
  "giusgad/pets.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
    config = function ()
        require("pets").setup({
            death_animation = true,
            random = false,
            row = 5,
            popup = { -- popup options, try changing these if you see a rectangle around the pets
                width = "100%", -- can be a string with percentage like "45%" or a number of columns like 45
                winblend = 100, -- winblend value - see :h 'winblend' - only used if avoid_statusline is false
                hl = { Normal = "Normal" }, -- hl is only set if avoid_statusline is true, you can put any hl group instead of "Normal"
                avoid_statusline = true, -- if winblend is 100 then the popup is invisible and covers the statusline, if that
                -- doesn't work for you then set this to true and the popup will use hl and will be spawned above the statusline (hopefully)
            }
        })
    end
}
