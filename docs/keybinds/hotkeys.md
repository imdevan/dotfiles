# Mac

cmd + ⌃ + ␣   - Emoji keyboard
^ + right   - Desktop right
^ + left    - Desktop left

## References

<https://support.apple.com/en-us/102650#:~:text=Command%20(or%20Cmd)%20%E2%8C%98>

# Keyboard Maestro

cmd N   - New group
cmd n   - New Macro

# Vs Code / Cursor

## Workspace

cmd B     - Close side bar
cmd opt B - Toggle ai chat
cmd shft E   - Open file explorer; scrollable
cmd shft X   - Open extension explorer; scrollable
cmd shft K + z   - Zen mode (vscode)
cmd shft R + z   - Zen mode (cursor)
^ shft G   - Source control
cmd + t     - toggle terminal focus (changed in keybinds)
cmd + j     - visually toggle terminal
cmd + r -> cmd + s  - open keyboard shortcuts
alt + shift   - duplicate line
cmd + alt     - create multi-line cursor down

terminal

cmd alt right - go to terminal split right
cmd alt left - go to terminal split left
cmd shift delete  - kill active terminal instance (changed in keybinds)

## Navigation

[Some assembly required](https://stackoverflow.com/questions/38957302/is-there-a-quick-change-tabs-function-in-visual-studio-code)

^ tab       - Go to next tab
^ shft tab     - Go to prev tab

cmd ⌥ →  /  cmd shft ]  - next tab
cmd ⌥ ←  /  cmd shft [  - prev tab

## Editing

cmd {     - tab code left
cmd }     - tab code right

## Cursor

cmd L         - chat
cmd K         - in line ai chat
shift cmd k   - file context ai

# Vim Motions

<https://www.worldtimzone.com/res/vi.html7>

## Cursor movement - Normal mode

h   - move left
j   - move down
k   - move up
l   - move right
J   - delete line down # TODO: remap to something useful
H   - move buffer left
K   - move up  # TODO: remap to something useful
L   - move buffer right
w   - jump by start of words (punctuation considered words)
W   - jump by words (spaces separate words)
e   - jump to end of words (punctuation considered words)
E   - jump to end of words (no punctuation)
b   - jump backward by words (punctuation considered words)
B   - jump backward by words (no punctuation)
0   - (zero) start of line
^   - first non-blank character of line
$   - end of line
G   - Go To command (prefix with number - 5G goes to line 5)
:#  - Also works as to command
"   - see register context
"0p - paste the "yank register"
"#y - yank to register

{   - go to beginning of paragraph
{w  - go to first word of paragraph
}   - go to end of paragraph
}ge - go to last word of paragraph

>> - indent line
<<  - undent line

ctrl+space  - select current block level and optionally more

Note: Prefix a cursor movement command with a number to repeat it. For example, 4j moves down 4 lines.

### Word affects

r     - replace hovered character
z=    - spell check suggestion

## Insert Mode - Inserting/Appending text

i     - start insert mode at cursor
I     - insert at the beginning of the line
a     - append after the cursor
A     - append at the end of the line
o     - open (append) blank line below current line (no need to press return)
O     - open blank line above current line
ea    - append at end of word
Esc   - exit insert mode

<ctrl+r>= - insert math expression

## Marking text (visual mode)

v       - start visual mode, mark lines, then do command (such as y-yank)
V       - start Linewise visual mode
o       - move to other end of marked area
Ctrl+v  - start visual block mode - multi line cursor
O       - move to Other corner of block
aw      - mark a word
%       - select matching current block
ab      - a () block (with braces)
aB      - a {} block (with brackets)
ib      - inner () block
iB      - inner {} block
Esc     - exit visual mode

### Editing in visual mode

c-v + c -> change -> esc - visual block; change a word (all words selected); escape to propagate
c-v + i -> change -> esc - visual block; insert a word (before all words selected); escape to propagate

## Visual commands

> - shift right
< - shift left
y - yank (copy) marked text
d - delete marked text
~ - switch case

%

## Cut and Paste

yy  - yank (copy) a line
2yy - yank 2 lines
yw  - yank word
y$  - yank to end of line
p   - put (paste) the clipboard after cursor
P   - put (paste) before cursor
dd  - delete (cut) a line
dw  - delete (cut) the current word
x   - delete (cut) current character

## Exiting

:w - write (save) the file, but don't exit
:wq - write (save) and quit
:q - quit (fails if anything has changed)
:q! - quit and throw away changes

## Search/Replace

/pattern        - search for pattern
?pattern        - search backward for pattern
n               - repeat search in same direction
N               - repeat search in opposite direction
:%s/old/new/g   - replace all old with new throughout file
:%s/old/new/gc  - replace all old with new throughout file with confirmations

## Working with multiple files

:e filename - Edit a file in a new buffer
:bnext (or :bn) - go to next buffer
:bprev (or :bp) - go to previous buffer
:bd - delete a buffer (close a file)
:sp filename - Open a file in a new buffer and split window
ctrl+ws - Split windows
ctrl+ww - switch between windows

ctrl+wq - Quit a window
ctrl+wv - Split windows vertically

gx  - open link

### LSPs

gd — go to definition
gr — find references
gi — go to implementation
K — hover

## Explorer navigation

shift h and l - move left and right between open buffers
j and k — focus down and up between files and folders;
h and l — collapse folders and select folders and files;
enter   — select folders and files;
gg      — focus on the first item of the explorer;
G       — focus on the last item of the explorer;
A       — create a new folder;
a       — create a new file;
r       — rename a file/folder;
d       — delete a file/folder;
y       — copy a file/folder;
x       — cut a file/folder;
p       — paste a file/folder.

## Editing

i - start insert mode at cursor
I - insert at the beginning of the line
a - append after the cursor
A - append at the end of the line
o - open (append) blank line below current line (no need to press return)
O - open blank line above current line
ea - append at end of word
Esc - exit insert mode
r   - replace highlighted text
c   - change
ciw - replace word (change in word)

u   - undo
U   - undo all last line changes
^r  - redo

"   - access registers
"0  - last yanked register

^a  - increment a number # or next in line
^x  - decrement a number # or next in line

<!-- read more: https://learnvim.irian.to/basics/registers -->

### nvim-surround

cs__- replace surrounding with
ys__  - wrap with

## Full Screen Navigation
<!-- https://www.reddit.com/r/vim/comments/14o2l0m/comment/jqayb0u/ -->

gg      - move cursor to first line

# G      - move cursor to # line

GG      - move cursor to last line
CTRL+b  - move cursor Backwards full page
CTRL+f  - move cursor Forward full page
CTRL+u  - move cursor Up half page
CTRL+d  - move cursor Down half page
zt      - move screen so cursor is at Top
zb      - move screen so cursor is at Bottom
zz      - center screen on cursor (very useful!)
ZZ      - save document and quit (be careful!)
H       - move cursor to top ("high up" or "home") of window
M       - move to middle of window
L       - move to bottom ("low" or "last line") of window

## Editing

gu  - lowercase
gU  - Uppercase
g~  - toggle case

## LSP

[Configured in settings](https://dev.to/ansonh/10-vs-code-vim-tricks-to-boost-your-productivity-1b0n)

gd  - go to definition (🔥)
gpd - peek Definition
gh  - show Hover (🔥)
gi  - go to Implementations (🔥)
gpi - peek Implementations
gq  - quick fix (open the code action lightbulb menu)
gr  - go to References (🔥)
gt  - go to Type Definition (🔥)
gpt - peek Type Definition

## Numbers

⌃a  - increment number (on current line or cursor)
⌃x  - decrement number (on current line or cursor)

## Vim Commands

:q      - quit
:q!     - quit without saving
:qa     - save and quit
:sav    - save new file
:w      - save file
:!rm %  - delete current file
"

## Lazy / NeoVim

<https://www.lazyvim.org/keymaps>

<leader>sk - telescope search thru shortcuts :)

<leader>e   - open explorer side panel
<leader>ff  - file explorer menu
<leader>wh | ctrl + h   -  go to split left
<leader>wl | ctrl + l   -  go to split right

alt-cmd-k - move line (or selection in visual) up
alt-cmd-j - move line (or selection in visual) down

## Vimium

contrl p  - custom

## References

Sourced and stuff for me to read later

<https://dev.to/ansonh/10-vs-code-vim-tricks-to-boost-your-productivity-1b0n>
<https://www.barbarianmeetscoding.com/blog/boost-your-coding-fu-with-vscode-and-vim>
<https://www.reddit.com/r/vim/comments/14o2l0m/how_to_move_really_efficiently_in_vim/>
<https://vim.rtorr.com/>
<https://www.worldtimzone.com/res/vi.html>

# Terminal / ghostty

## Dirhistory (via plugin)

alt + left  - go to previous directory
alt + right - go to next directory
alt + up    - move into the parent directory
alt + down  - move into the first child directory by alphabetical order

## tmux

see [./config/stow/tmux/.tmux.config](./config/stow/tmux/.tmux.config)

## aerospace

see [./config/stow/aerospace/.aerospace.toml](./config/stow/aerospace/.aerospace.toml)

## qutebrowser

references:

https://qutebrowser.org/doc/help/settings.html
https://qutebrowser.org/doc/help/settings.html#bindings.default

O - open in new tab
o - open in curent tab
yy - yank url

normal:
': mode-enter jump_mark
+: zoom-in
-: zoom-out
=: reset zoom
.: cmd-repeat-last
/: cmd-set-text /
:: cmd-set-text :
;I: hint images tab
;O: hint links fill :open -t -r {hint-url}
;R: hint --rapid links window
;Y: hint links yank-primary
;b: hint all tab-bg
;d: hint links download
;f: hint all tab-fg
;h: hint all hover
;i: hint images
;o: hint links fill :open {hint-url}
;r: hint --rapid links tab-bg
;t: hint inputs
;y: hint links yank
<Alt-1>: tab-focus 1
<Alt-2>: tab-focus 2
<Alt-3>: tab-focus 3
<Alt-4>: tab-focus 4
<Alt-5>: tab-focus 5
<Alt-6>: tab-focus 6
<Alt-7>: tab-focus 7
<Alt-8>: tab-focus 8
<Alt-9>: tab-focus -1
<Alt-m>: tab-mute
<Ctrl-A>: navigate increment
<Ctrl-Alt-p>: print
<Ctrl-B>: scroll-page 0 -1
<Ctrl-D>: scroll-page 0 0.5
<Ctrl-F5>: reload -f
<Ctrl-F>: scroll-page 0 1
<Ctrl-N>: open -w
<Ctrl-PgDown>: tab-next
<Ctrl-PgUp>: tab-prev
<Ctrl-Q>: quit
<Ctrl-Return>: selection-follow -t
<Ctrl-Shift-N>: open -p
<Ctrl-Shift-T>: undo
<Ctrl-Shift-Tab>: nop
<Ctrl-Shift-W>: close
<Ctrl-T>: open -t
<Ctrl-Tab>: tab-focus last
<Ctrl-U>: scroll-page 0 -0.5
<Ctrl-V>: mode-enter passthrough
<Ctrl-W>: tab-close
<Ctrl-X>: navigate decrement
<Ctrl-^>: tab-focus last
<Ctrl-h>: home
<Ctrl-p>: tab-pin
<Ctrl-s>: stop
<Escape>: clear-keychain ;; search ;; fullscreen --leave
<F11>: fullscreen
<F5>: reload
<Return>: selection-follow
<back>: back
<forward>: forward
=: zoom
?: cmd-set-text ?
@: macro-run
B: cmd-set-text -s :quickmark-load -t
D: tab-close -o
F: hint all tab
G: scroll-to-perc
H: back
J: tab-next
K: tab-prev
L: forward
M: bookmark-add
N: search-prev
O: cmd-set-text -s :open -t
PP: open -t -- {primary}
Pp: open -t -- {clipboard}
R: reload -f
Sb: bookmark-list --jump
Sh: history
Sq: bookmark-list
Ss: set
T: cmd-set-text -sr :tab-focus
U: undo -w
V: mode-enter caret ;; selection-toggle --line
ZQ: quit
ZZ: quit --save
[[: navigate prev
]]: navigate next
`: mode-enter set_mark
ad: download-cancel
b: cmd-set-text -s :quickmark-load
cd: download-clear
co: tab-only
d: tab-close
f: hint
g$: tab-focus -1
g0: tab-focus 1
gB: cmd-set-text -s :bookmark-load -t
gC: tab-clone
gD: tab-give
gJ: tab-move +
gK: tab-move -
gO: cmd-set-text :open -t -r {url:pretty}
gU: navigate up -t
g^: tab-focus 1
ga: open -t
gb: cmd-set-text -s :bookmark-load
gd: download
gf: view-source
gg: scroll-to-perc 0
gi: hint inputs --first
gm: tab-move
go: cmd-set-text :open {url:pretty}
gt: cmd-set-text -s :tab-select
gu: navigate up
h: scroll left
i: mode-enter insert
j: scroll down
k: scroll up
l: scroll right
m: quickmark-save
n: search-next
o: cmd-set-text -s :open
pP: open -- {primary}
pp: open -- {clipboard}
q: macro-record
r: reload
sf: save
sk: cmd-set-text -s :bind
sl: cmd-set-text -s :set -t
ss: cmd-set-text -s :set
tCH: config-cycle -p -u *://*.{url:host}/* content.cookies.accept all no-3rdparty never ;; reload
tCh: config-cycle -p -u *://{url:host}/* content.cookies.accept all no-3rdparty never ;; reload
tCu: config-cycle -p -u {url} content.cookies.accept all no-3rdparty never ;; reload
tIH: config-cycle -p -u *://*.{url:host}/* content.images ;; reload
tIh: config-cycle -p -u *://{url:host}/* content.images ;; reload
tIu: config-cycle -p -u {url} content.images ;; reload
tPH: config-cycle -p -u *://*.{url:host}/* content.plugins ;; reload
tPh: config-cycle -p -u *://{url:host}/* content.plugins ;; reload
tPu: config-cycle -p -u {url} content.plugins ;; reload
tSH: config-cycle -p -u *://*.{url:host}/* content.javascript.enabled ;; reload
tSh: config-cycle -p -u *://{url:host}/* content.javascript.enabled ;; reload
tSu: config-cycle -p -u {url} content.javascript.enabled ;; reload
tcH: config-cycle -p -t -u *://*.{url:host}/* content.cookies.accept all no-3rdparty never ;; reload
tch: config-cycle -p -t -u *://{url:host}/* content.cookies.accept all no-3rdparty never ;; reload
tcu: config-cycle -p -t -u {url} content.cookies.accept all no-3rdparty never ;; reload
th: back -t
tiH: config-cycle -p -t -u *://*.{url:host}/* content.images ;; reload
tih: config-cycle -p -t -u *://{url:host}/* content.images ;; reload
tiu: config-cycle -p -t -u {url} content.images ;; reload
tl: forward -t
tpH: config-cycle -p -t -u *://*.{url:host}/* content.plugins ;; reload
tph: config-cycle -p -t -u *://{url:host}/* content.plugins ;; reload
tpu: config-cycle -p -t -u {url} content.plugins ;; reload
tsH: config-cycle -p -t -u *://*.{url:host}/* content.javascript.enabled ;; reload
tsh: config-cycle -p -t -u *://{url:host}/* content.javascript.enabled ;; reload
tsu: config-cycle -p -t -u {url} content.javascript.enabled ;; reload
u: undo
v: mode-enter caret
wB: cmd-set-text -s :bookmark-load -w
wIf: devtools-focus
wIh: devtools left
wIj: devtools bottom
wIk: devtools top
wIl: devtools right
wIw: devtools window
wO: cmd-set-text :open -w {url:pretty}
wP: open -w -- {primary}
wb: cmd-set-text -s :quickmark-load -w
wf: hint all window
wh: back -w
wi: devtools
wl: forward -w
wo: cmd-set-text -s :open -w
wp: open -w -- {clipboard}
xO: cmd-set-text :open -b -r {url:pretty}
xo: cmd-set-text -s :open -b
yD: yank domain -s
yM: yank inline [{title}]({url:yank}) -s
yP: yank pretty-url -s
yT: yank title -s
yY: yank -s
yd: yank domain
ym: yank inline [{title}]({url:yank})
yp: yank pretty-url
yt: yank title
yy: yank
{{: navigate prev -t
}}: navigate next -t

insert:
<Ctrl-E>: edit-text
<Escape>: mode-leave
<Shift-Escape>: fake-key <Escape>
<Shift-Ins>: insert-text -- {primary}

caret:  # editing
$: move-to-end-of-line
0: move-to-start-of-line
<Ctrl-Space>: selection-drop
<Escape>: mode-leave
<Return>: yank selection
Space>: selection-toggle
G: move-to-end-of-document
H: scroll left
J: scroll down
K: scroll up
L: scroll right
V: selection-toggle --line
Y: yank selection -s
[: move-to-start-of-prev-block
]: move-to-start-of-next-block
b: move-to-prev-word
c: mode-enter normal
e: move-to-end-of-word
gg: move-to-start-of-document
h: move-to-prev-char
j: move-to-next-line
k: move-to-prev-line
l: move-to-next-char
o: selection-reverse
v: selection-toggle
w: move-to-next-word
y: yank selection
{: move-to-end-of-prev-block
}: move-to-end-of-next-block

command:
<Alt-B>: rl-backward-word
<Alt-Backspace>: rl-backward-kill-word
<Alt-D>: rl-kill-word
<Alt-F>: rl-forward-word
<Ctrl-?>: rl-delete-char
<Ctrl-A>: rl-beginning-of-line
<Ctrl-B>: rl-backward-cha
<Ctrl-C>: completion-item-yank
<Ctrl-D>: completion-item-del
<Ctrl-E>: rl-end-of-line
<Ctrl-F>: rl-forward-char
<Ctrl-H>: rl-backward-delete-char
<Ctrl-K>: rl-kill-line
<Ctrl-N>: command-history-next
<Ctrl-P>: command-history-prev
<Ctrl-Return>: command-accept --rapid
<Ctrl-Shift-C>: completion-item-yank --sel
<Ctrl-Shift-Tab>: completion-item-focus prev-category
<Ctrl-Shift-W>: rl-filename-rubout
<Ctrl-Tab>: completion-item-focus next-category
<Ctrl-U>: rl-unix-line-discard
<Ctrl-W>: rl-rubout " "
<Ctrl-Y>: rl-yank
<Down>: completion-item-focus --history next
<Escape>: mode-leave
<PgDown>: completion-item-focus next-page
<PgUp>: completion-item-focus prev-page
<Return>: command-accept
<Shift-Delete>: completion-item-del
<Shift-Tab>: completion-item-focus prev
<Tab>: completion-item-focus next
<Up>: completion-item-focus --history prev

hint:
<Ctrl-B>: hint all tab-bg
<Ctrl-F>: hint links
<Ctrl-R>: hint --rapid links tab-bg
<Escape>: mode-leave
<Return>: hint-follow

passthrough:
<Shift-Escape>: mode-leave

prompt:
<Alt-B>: rl-backward-word
<Alt-Backspace>: rl-backward-kill-word
<Alt-D>: rl-kill-word
<Alt-E>: prompt-fileselect-external
<Alt-F>: rl-forward-word
<Alt-Shift-Y>: prompt-yank --sel
<Alt-Y>: prompt-yank
<Ctrl-?>: rl-delete-char
<Ctrl-A>: rl-beginning-of-line
<Ctrl-B>: rl-backward-char
<Ctrl-E>: rl-end-of-line
<Ctrl-F>: rl-forward-char
<Ctrl-H>: rl-backward-delete-char
<Ctrl-K>: rl-kill-line
<Ctrl-P>: prompt-open-download --pdfjs
<Ctrl-Shift-W>: rl-filename-rubout
<Ctrl-U>: rl-unix-line-discard
<Ctrl-W>: rl-rubout " "
<Ctrl-X>: prompt-open-download
<Ctrl-Y>: rl-yank
<Down>: prompt-item-focus next
<Escape>: mode-leave
<Return>: prompt-accept
<Shift-Tab>: prompt-item-focus prev
<Tab>: prompt-item-focus next
<Up>: prompt-item-focus prev
