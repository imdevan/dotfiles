-- https://catppuccin.com/palette/
--
return {
  "HiPhish/rainbow-delimiters.nvim",
  event = "VeryLazy",
  config = function()
    -- local rainbow_delimiters = require("rainbow-delimiters")
    --
    -- vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { foreground = "#FF00FF" }) -- Magenta
    --
    -- vim.g.rainbow_delimiters = {
    --   strategy = {
    --     [""] = rainbow_delimiters.strategy["global"],
    --     vim = rainbow_delimiters.strategy["local"],
    --   },
    --   query = {
    --     [""] = "rainbow-delimiters",
    --     lua = "rainbow-blocks",
    --   },
    --   priority = {
    --     [""] = 110,
    --     lua = 210,
    --   },
    --   highlight = {
    --     "RainbowDelimiterOrange",
    --     "RainbowDelimiterGreen",
    --     "RainbowDelimiterRed",
    --     "RainbowDelimiterBlue",
    --     "RainbowDelimiterViolet",
    --     "RainbowDelimiterYellow",
    --     "RainbowDelimiterCyan",
    --   },
    -- }

    vim.cmd([[
      highlight RainbowDelimiterRed guifg=#ea76cb
      highlight RainbowDelimiterYellow guifg=#eed49f
      highlight RainbowDelimiterBlue guifg=#8aadf4
      highlight RainbowDelimiterGreen guifg=#a6da95
      highlight RainbowDelimiterOrange guifg=#f5a97f
      highlight RainbowDelimiterViolet guifg=##babbf1
      highlight RainbowDelimiterCyan guifg=#8bd5ca
    ]])

    -- vim.cmd([[
    --   highlight RainbowDelimiterRed guifg=#f5bde6
    -- highlight RainbowDelimiterViolet guifg=#845EC2
    --   highlight RainbowDelimiterYellow guifg=#eed49f
    --   highlight RainbowDelimiterBlue guifg=#8aadf4
    --   highlight RainbowDelimiterGreen guifg=#a6da95
    --   highlight RainbowDelimiterOrange guifg=#f5a97f
    --   highlight RainbowDelimiterViolet guifg=#845EC2
    --   highlight RainbowDelimiterCyan guifg=#8bd5ca
    -- ]])
  end,
  keys = {
    {
      "<leader>pur",
      function()
        require("rainbow-delimiters").toggle(0)
      end,
      desc = "Toggle Rainbow Delimiters",
    },
  },
}

-- Define
-- vim.cmd [[
-- highlight RainbowDelimiterRed guifg=#f5bde6 ctermfg=203
-- highlight RainbowDelimiterYellow guifg=#eed49f ctermfg=221
-- highlight RainbowDelimiterBlue guifg=#8aadf4 ctermfg=113
-- highlight RainbowDelimiterGreen guifg=#a6da95 ctermfg=75
-- highlight RainbowDelimiterOrange guifg=#f5a97f ctermfg=214
-- highlight RainbowDelimiterViolet guifg=#845EC2 ctermfg=91
-- highlight RainbowDelimiterCyan guifg=#8bd5ca ctermfg=51
-- ]]
