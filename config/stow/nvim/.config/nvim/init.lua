-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Override markdown heading highlight groups after everything has loaded.
-- VimEnter fires after all plugins, plugin/ dirs, and colorscheme are done.
--
-- TODO: some kind of fix related to this
-- ~/.config/aether/theme/neovim.lua:1
-- possibly defining a color scheme plugin to override the aether config
local function apply_markdown_hl()
  local hls = {
    -- RenderMarkdown icon/sign virtual text
    RenderMarkdownH1 = { ctermfg = 15, fg = "#b5bfe2" },
    RenderMarkdownH2 = { ctermfg = 5, fg = "#f4b8e4" },
    RenderMarkdownH3 = { ctermfg = 2, fg = "#a6d189" },
    RenderMarkdownH4 = { ctermfg = 4, fg = "#ca9ee6" },
    RenderMarkdownH5 = { ctermfg = 3, fg = "#e5c890" },
    RenderMarkdownH6 = { ctermfg = 1, fg = "#e78284" },
    -- RenderMarkdown background lines
    RenderMarkdownH1Bg = { ctermbg = 15, bg = "#b5bfe2" },
    RenderMarkdownH2Bg = { ctermbg = 5, bg = "#f4b8e4" },
    RenderMarkdownH3Bg = { ctermbg = 2, bg = "#a6d189" },
    RenderMarkdownH4Bg = { ctermbg = 4, bg = "#ca9ee6" },
    RenderMarkdownH5Bg = { ctermbg = 3, bg = "#e5c890" },
    RenderMarkdownH6Bg = { ctermbg = 1, bg = "#e78284" },
    -- Treesitter groups that color the actual heading text
    ["@markup.heading.1.markdown"] = { ctermfg = 15, fg = "#b5bfe2" },
    ["@markup.heading.2.markdown"] = { ctermfg = 5, fg = "#f4b8e4" },
    ["@markup.heading.3.markdown"] = { ctermfg = 2, fg = "#a6d189" },
    ["@markup.heading.4.markdown"] = { ctermfg = 4, fg = "#ca9ee6" },
    ["@markup.heading.5.markdown"] = { ctermfg = 3, fg = "#e5c890" },
    ["@markup.heading.6.markdown"] = { ctermfg = 1, fg = "#e78284" },
  }
  for group, v in pairs(hls) do
    vim.api.nvim_set_hl(0, group, v)
  end
end

vim.api.nvim_create_autocmd({ "FileType", "ColorScheme" }, {
  pattern = { "markdown", "*" },
  callback = function(ev)
    if ev.event == "ColorScheme" or vim.bo[ev.buf].filetype == "markdown" then
      apply_markdown_hl()
    end
  end,
})

-- todo: configure aether style setup on macos
-- if not vim.g.vscode then
--   -- Load colorscheme and UI-related plugins
--   vim.cmd("colorscheme catppuccin-macchiato") -- or your preferred theme
-- end

-- vim.opt.spellfile = "~/.config/nvim/spell/en.utf-8.add"
-- vim.opt.spellfile = "~/.config/nvim/spell"
