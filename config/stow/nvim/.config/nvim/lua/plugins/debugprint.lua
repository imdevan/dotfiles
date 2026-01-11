-- https://github.com/andrewferrier/debugprint.nvim/blob/main/SHOWCASE.md

local js_like = {
  left = 'console.info("',
  right = '")',
  mid_var = '", ',
  right_var = ")",
}

local python_config = {
  left_var = "print('",
  mid_var = "'); __import__('wat').wat(", -- https://github.com/andrewferrier/debugprint.nvim/blob/main/SHOWCASE.md#use-wat-inspector-to-fully-dump-objects-in-python
  right_var = ")",
}
return {
  "andrewferrier/debugprint.nvim",
  opts = {
    print_tag = "🚀",
    display_counter = false,

    filetypes = {
      ["javascript"] = js_like,
      ["javascriptreact"] = js_like,
      ["typescript"] = js_like,
      ["typescriptreact"] = js_like,
      ["python"] = python_config,
    },
    keymaps = {
      normal = {
        plain_below = "g?p",
        plain_above = "g?P",
        variable_below = "g?v",
        variable_above = "g?V",
        variable_below_alwaysprompt = "",
        variable_above_alwaysprompt = "",
        surround_plain = "g?sp",
        surround_variable = "g?sv",
        surround_variable_alwaysprompt = "",
        textobj_below = "g?o",
        textobj_above = "g?O",
        textobj_surround = "g?so",
        toggle_comment_debug_prints = "",
        delete_debug_prints = "",
      },
      insert = {
        plain = "<C-G>p",
        variable = "<C-G>v",
      },
      visual = {
        variable_below = "g?v",
        variable_above = "g?V",
      },
    },
  },

  lazy = false, -- Required to make line highlighting work before debugprint is first used
  version = "*", -- Remove if you DON'T want to use the stable version
}
