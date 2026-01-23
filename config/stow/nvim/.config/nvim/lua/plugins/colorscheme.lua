-- https://github.com/catppuccin/nvim
-- https://catppuccin.com/palette/
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = not vim.g.vscode,
    -- opts = {
    --   transparent_background = true,
    -- },
    config = function()
      -- Detect system appearance (light/dark mode)
      local function is_dark_mode()
        local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
        if not handle then
          return true -- default to dark mode if detection fails
        end
        local result = handle:read("*a")
        handle:close()
        return result:match("Dark") ~= nil
      end

      local dark_mode = is_dark_mode()
      local flavour = dark_mode and "macchiato" or "latte"

      -- Catppuccin color palettes for markdown headers
      -- Macchiato (dark mode) colors
      local macchiato_colors = {
        h1 = "#8aadf4", -- blue
        h2 = "#a6da95", -- green
        h3 = "#f5a97f", -- peach
        h4 = "#ed8796", -- red
        h5 = "#c6a0f6", -- mauve
        h6 = "#f4dbd6", -- rosewater
      }

      -- Latte (light mode) colors
      local latte_colors = {
        h1 = "#7287fd", -- lavender
        h2 = "#8839ef", -- mauve
        h3 = "#ea76cb", -- pink
        h4 = "#04a5e5", -- sky
        h5 = "#40a02b", -- green
        h6 = "#dc8a78", -- rosewater
      }

      -- Select colors based on system color scheme
      local header_colors = dark_mode and macchiato_colors or latte_colors

      require("catppuccin").setup({
        flavour = flavour, -- latte for light mode, macchiato for dark mode
        transparent_background = true, -- disables setting the background color.
        -- transparent = true,
        float = {
          -- transparent = false, -- enable transparent floating windows
          transparent = true, -- enable transparent floating windows
          solid = false, -- use solid styling for floating windows, see |winborder|
          -- solid = true, -- use solid styling for floating windows, see |winborder|
        },
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        integrations = {
          treesitter = true,
          lsp_saga = true,
          cmp = true,
          gitsigns = true,
          telescope = true,
          notify = true,
          mini = true,
          native_lsp = {
            enabled = true,
          },
        },
        highlight_overrides = {
          all = function(colors)
            return {
              -- Markdown header colors (system-aware)
              ["@markup.heading.1.markdown"] = { fg = header_colors.h1, style = { "bold" } },
              ["@markup.heading.2.markdown"] = { fg = header_colors.h2, style = { "bold" } },
              ["@markup.heading.3.markdown"] = { fg = header_colors.h3, style = { "bold" } },
              ["@markup.heading.4.markdown"] = { fg = header_colors.h4, style = { "bold" } },
              ["@markup.heading.5.markdown"] = { fg = header_colors.h5, style = { "bold" } },
              ["@markup.heading.6.markdown"] = { fg = header_colors.h6, style = { "bold" } },
              -- Alternative treesitter group names
              ["@text.title.1.markdown"] = { fg = header_colors.h1, style = { "bold" } },
              ["@text.title.2.markdown"] = { fg = header_colors.h2, style = { "bold" } },
              ["@text.title.3.markdown"] = { fg = header_colors.h3, style = { "bold" } },
              ["@text.title.4.markdown"] = { fg = header_colors.h4, style = { "bold" } },
              ["@text.title.5.markdown"] = { fg = header_colors.h5, style = { "bold" } },
              ["@text.title.6.markdown"] = { fg = header_colors.h6, style = { "bold" } },
              -- Fallback for older syntax highlighting
              ["markdownH1"] = { fg = header_colors.h1, style = { "bold" } },
              ["markdownH2"] = { fg = header_colors.h2, style = { "bold" } },
              ["markdownH3"] = { fg = header_colors.h3, style = { "bold" } },
              ["markdownH4"] = { fg = header_colors.h4, style = { "bold" } },
              ["markdownH5"] = { fg = header_colors.h5, style = { "bold" } },
              ["markdownH6"] = { fg = header_colors.h6, style = { "bold" } },
            }
          end,
        },
      })

      vim.cmd.colorscheme("catppuccin")

      local transparent_groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "FloatBorder",
        "SignColumn",
        "EndOfBuffer",
        "MsgArea",
        "MsgSeparator",
        "StatusLine",
        "StatusLineNC",
        "VertSplit",
        "WinSeparator",
      }

      for _, group in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end

      -- ============================================================================
      -- Additional Markdown Styling Options (commented out)
      -- Uncomment the sections below to enable additional markdown styling
      -- ============================================================================

      -- -- Markdown code blocks
      -- vim.cmd("highlight! markdownCode guifg=" .. (dark_mode and "#a6da95" or "#40a02b") .. " guibg=" .. (dark_mode and "#363a4f" or "#ccd0da"))
      -- vim.cmd("highlight! markdownCodeBlock guifg=" .. (dark_mode and "#cad3f5" or "#4c4f69") .. " guibg=" .. (dark_mode and "#363a4f" or "#ccd0da"))
      -- vim.cmd("highlight! @markup.raw.markdown guifg=" .. (dark_mode and "#a6da95" or "#40a02b") .. " guibg=" .. (dark_mode and "#363a4f" or "#ccd0da"))
      -- vim.cmd("highlight! @markup.raw.block.markdown guifg=" .. (dark_mode and "#cad3f5" or "#4c4f69") .. " guibg=" .. (dark_mode and "#363a4f" or "#ccd0da"))

      -- -- Markdown inline code
      -- vim.cmd("highlight! markdownCodeDelimiter guifg=" .. (dark_mode and "#8aadf4" or "#1e66f5"))
      -- vim.cmd("highlight! @markup.raw.inline.markdown guifg=" .. (dark_mode and "#a6da95" or "#40a02b") .. " guibg=" .. (dark_mode and "#363a4f" or "#ccd0da"))

      -- -- Markdown links
      -- vim.cmd("highlight! markdownLinkText guifg=" .. (dark_mode and "#8aadf4" or "#1e66f5") .. " gui=underline")
      -- vim.cmd("highlight! markdownLinkTextDelimiter guifg=" .. (dark_mode and "#8aadf4" or "#1e66f5"))
      -- vim.cmd("highlight! markdownUrl guifg=" .. (dark_mode and "#7dc4e4" or "#209fb5") .. " gui=underline")
      -- vim.cmd("highlight! markdownUrlTitle guifg=" .. (dark_mode and "#8aadf4" or "#1e66f5"))
      -- vim.cmd("highlight! @markup.link.markdown guifg=" .. (dark_mode and "#8aadf4" or "#1e66f5") .. " gui=underline")
      -- vim.cmd("highlight! @markup.link.label.markdown guifg=" .. (dark_mode and "#8aadf4" or "#1e66f5"))
      -- vim.cmd("highlight! @markup.link.url.markdown guifg=" .. (dark_mode and "#7dc4e4" or "#209fb5") .. " gui=underline")

      -- -- Markdown bold and italic
      -- vim.cmd("highlight! markdownBold guifg=" .. (dark_mode and "#f5a97f" or "#fe640b") .. " gui=bold")
      -- vim.cmd("highlight! markdownItalic guifg=" .. (dark_mode and "#c6a0f6" or "#8839ef") .. " gui=italic")
      -- vim.cmd("highlight! @markup.strong.markdown guifg=" .. (dark_mode and "#f5a97f" or "#fe640b") .. " gui=bold")
      -- vim.cmd("highlight! @markup.emphasis.markdown guifg=" .. (dark_mode and "#c6a0f6" or "#8839ef") .. " gui=italic")

      -- -- Markdown lists
      -- vim.cmd("highlight! markdownListMarker guifg=" .. (dark_mode and "#8aadf4" or "#1e66f5"))
      -- vim.cmd("highlight! markdownOrderedListMarker guifg=" .. (dark_mode and "#8aadf4" or "#1e66f5"))
      -- vim.cmd("highlight! @markup.list.markdown guifg=" .. (dark_mode and "#8aadf4" or "#1e66f5"))
      -- vim.cmd("highlight! @markup.list.numbered.markdown guifg=" .. (dark_mode and "#8aadf4" or "#1e66f5"))
      -- vim.cmd("highlight! @markup.list.unnumbered.markdown guifg=" .. (dark_mode and "#8aadf4" or "#1e66f5"))

      -- -- Markdown blockquotes
      -- vim.cmd("highlight! markdownBlockquote guifg=" .. (dark_mode and "#6e738d" or "#9ca0b0") .. " gui=italic")
      -- vim.cmd("highlight! markdownBlockquoteDelimiter guifg=" .. (dark_mode and "#6e738d" or "#9ca0b0"))
      -- vim.cmd("highlight! @markup.quote.markdown guifg=" .. (dark_mode and "#6e738d" or "#9ca0b0") .. " gui=italic")

      -- -- Markdown horizontal rules
      -- vim.cmd("highlight! markdownHr guifg=" .. (dark_mode and "#6e738d" or "#9ca0b0"))

      -- -- Markdown tables
      -- vim.cmd("highlight! markdownTableDelimiter guifg=" .. (dark_mode and "#6e738d" or "#9ca0b0"))
      -- vim.cmd("highlight! markdownTable guifg=" .. (dark_mode and "#cad3f5" or "#4c4f69"))

      -- -- Markdown strikethrough
      -- vim.cmd("highlight! markdownStrikethrough guifg=" .. (dark_mode and "#6e738d" or "#9ca0b0") .. " gui=strikethrough")
      -- vim.cmd("highlight! @markup.strikethrough.markdown guifg=" .. (dark_mode and "#6e738d" or "#9ca0b0") .. " gui=strikethrough")

      -- -- Markdown task lists (checkboxes)
      -- vim.cmd("highlight! markdownTaskMarker guifg=" .. (dark_mode and "#a6da95" or "#40a02b"))
      -- vim.cmd("highlight! markdownTaskMarkerDone guifg=" .. (dark_mode and "#6e738d" or "#9ca0b0") .. " gui=strikethrough")
    end,
  },
}
