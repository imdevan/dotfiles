## Feature 1: Keymaps
- [x] 1.1 <C-o> newline at cursor in normal or insert mode # current alternative: tab, then enter
- [x] 1.3 insert mode, <C-n>, inert nerd font icon (see keymap pn for current usage)
- lua/plugins/nerdy.lua:10
- [x] 1.4 <M-'>'> super-tab 
- [x] 1.5 <M-o> copy content under cursor to register o. in normal mode copy word under cursor in visual mode copy content

## Feature 2: fixes
- [x] 2.1 keymap <leader>p<M-y> yank between separators: should also yank content before or after separators if at least one separator is found

# Possible plugins
  - example:
  ```md
  ---
  [this should be a valid yank]
  ```

# Possible features

## UnderCursor

WordUnderCursor
LineUnderCursor
ParagraphUnderCursor
PageUnderCursor

## togglr fork

- [x] 1.2 <leader>tw "toggle word" 
- if current word is not toggleable toggle next boolean word on the current line
  - if no word found then search the prev boolean word on current line
- accept regix for values map `["- [ ]"] = "- [x]", should be valid`
- add toggle line
- add toggle paragraph

