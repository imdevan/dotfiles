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
  config = function(_, opts)
    require("render-markdown").setup(opts)
  end,
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
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      -- foregrounds defaults to RenderMarkdownH1-H6, which we override above.
    },
    pipe_table = { preset = "round" },
    bullet = {
      icons = { "󰊠", "󰮯", "󱙝", "󰊠" },
      -- icons = { "󰮯", "󰊠", "󱙝" },
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
