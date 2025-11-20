-- Plugin to open urls in browser. Also works with certain plugins
-- https://github.com/sontungexpt/url-open

-- Keymap
vim.keymap.set("n", "gx", "<esc>:URLOpenUnderCursor<cr>")

-- Plugin config
return {
  "sontungexpt/url-open",
  event = "VeryLazy",
  branch = "mini", -- minimal source with no comments, no validate configs, no documents
  cmd = "URLOpenUnderCursor",
  config = function()
    local status_ok, url_open = pcall(require, "url-open")
    if not status_ok then
      return
    end
    url_open.setup({
      open_app = "qutebrowser",
    })
  end,
}
