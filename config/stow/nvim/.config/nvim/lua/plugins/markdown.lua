return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- config = function()
  --   -- vim.filetype.add({
  --   -- extension = { mdx = "mdx" },
  --   -- })
  --   -- vim.treesitter.language.register("markdown", "mdx")
  --
  --   require("render-markdown").setup({
  --     file_types = { "markdown", "mdx" },
  --   })
  -- end,
  opts = {
    file_types = { "markdown", "mdx" },
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
      -- above = "󰮯",
      above = "",
      below = "󱙝",
      -- above = "",
      -- below = "",
      -- above = "󰺵",
      -- below = "󰺵",
      -- Highlight for the heading icon and extends through the entire line.
      -- Output is evaluated by `clamp(value, context.level)`.
      backgrounds = {},
      -- Highlight for the heading and sign icons.
      -- Output is evaluated using the same logic as 'backgrounds'.
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },
    pipe_table = { preset = "round" },
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
