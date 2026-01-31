return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    render_modes = true,
    -- render_modes = { "n", "c", "t", "x", "v" },
    anti_conceal = { enabled = false },
    -- anti_conceal = {
    --   enabled = true,
    --   disabled_modes = false,
    --   above = 3,
    --   below = 3,
    -- },
    -- anti_conceal = "none", -- "cursor_line" | "all" | "none"
    -- Conceal: this hides the raw markdown markup on the cursor line when in render_modes
    conceal = {
      enabled = true,
      conceal_cursor_line = true,
    },
    heading = {
      border = true,
      enabled = true,
      sign = true,
      signs = { "󰫎 " },
      -- ions = {'', ''}
      -- atx = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },

      position = "ineline",
      border_virtual = true,
      border_prefix = true,
      -- above = "󰮯",
      -- below = "󱙝",
      above = "󰮯",
      below = "󱙝",
      -- above = "",
      -- below = "",
      -- above = "󰺵",
      -- below = "󰺵",
    },
    bullet = {
      icons = { "󰮯", "󰊠", "󱙝" },
      -- icons = { "○", "●", "◆", "◇" },
      -- icons = { "", "", "◆", "◇", "󰮯", "󰊠", "󱙝" },
      -- icons = { "󰢚", "󱃋", "", "" },
      -- icons = { "󰺵", "󰺶", "󰮯", "󰊠", "󱙝" },
    },
    checkbox = {
      enabled = true,
    },
  },
}
