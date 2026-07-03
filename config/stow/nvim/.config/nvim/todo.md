## Feature 1: Keymaps
- [x] 1.1 <C-o> newline at cursor in normal or insert mode # current alternative: tab, then enter
- [ ] 1.2 <leader>tw "toggle word" 
- toggle next boolean word on the current line
- [x] 1.3 insert mode, <C-n>, inert nerd font icon (see keymap pn for current usage)
- lua/plugins/nerdy.lua:10
- [ ] 1.4 <M-'>'> super-tab 
- [x] 1.5 <M-o> copy content under cursor to register o. in normal mode copy word under cursor in visual mode copy content
## Feature 2: fixes
- [x] 2.1 keymap <leader>p<M-y> yank between separators: should also yank content before or after separators if at least one separator is found
  - example:
  ```md
  ---
  [this should be a valid yank]
  ```
