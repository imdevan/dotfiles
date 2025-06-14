# Mac

⌘ + ⌃ + ␣   - Emoji keyboard
^ + right   - Desktop right
^ + left    - Desktop left

## References

<https://support.apple.com/en-us/102650#:~:text=Command%20(or%20Cmd)%20%E2%8C%98>

# Keyboard Maestro

⌘ ↑ G   - Search the web
^ `     - Open ghostty

# Vs Code / Cursor

## Workspace

⌘ B     - Close side bar
⌘ ↑ E   - Open file explorer; scrollable
⌘ ↑ X   - Open extension explorer; scrollable
⌘ ↑ K + z   - Zen mode (vscode)
⌘ ↑ R + z   - Zen mode (cursor)
^ ↑ G   - Source control

## Navigation

[Some assembly required](https://stackoverflow.com/questions/38957302/is-there-a-quick-change-tabs-function-in-visual-studio-code)

^ tab       - Go to next tab
^ ↑ tab     - Go to prev tab

⌘ ⌥ →  /  ⌘ ↑ ]  - next tab
⌘ ⌥ ←  /  ⌘ ↑ [  - prev tab

## Editing

⌘ {     - tab code left
⌘ }     - tab code right

## Cursor

cmd L         - chat
cmd K         - in line ai chat
shift cmd k   - file context ai

# Vim Motions

<https://www.worldtimzone.com/res/vi.html7>

## Cursor movement

h   - move left
j   - move down
k   - move up
l   - move right
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

{   - go to beginning of paragraph
{w  - go to first word of paragraph
}   - go to end of paragraph
}ge - go to last word of paragraph

Note: Prefix a cursor movement command with a number to repeat it. For example, 4j moves down 4 lines.

## Insert Mode - Inserting/Appending text

i     - start insert mode at cursor
I     - insert at the beginning of the line
a     - append after the cursor
A     - append at the end of the line
o     - open (append) blank line below current line (no need to press return)
O     - open blank line above current line
ea    - append at end of word
Esc   - exit insert mode

## Marking text (visual mode)

v       - start visual mode, mark lines, then do command (such as y-yank)
V       - start Linewise visual mode
o       - move to other end of marked area
Ctrl+v  - start visual block mode
O       - move to Other corner of block
aw      - mark a word
ab      - a () block (with braces)
aB      - a {} block (with brackets)
ib      - inner () block
iB      - inner {} block
Esc     - exit visual mode

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
:bprev (of :bp) - go to previous buffer
:bd - delete a buffer (close a file)
:sp filename - Open a file in a new buffer and split window
ctrl+ws - Split windows
ctrl+ww - switch between windows

ctrl+wq - Quit a window
ctrl+wv - Split windows vertically

gx  - open link

## Explorer navigation

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

u   - undo
U   - undo all last line changes
^r  - redo

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

## Lazy / NeoVim

<leader>e   - open explorer side panel
<leader>ff  - file explorer menu
<leader>wh | ctrl + h   -  go to split left
<leader>wl | ctrl + l   -  go to split right

## References

Sourced and stuff for me to read later

<https://dev.to/ansonh/10-vs-code-vim-tricks-to-boost-your-productivity-1b0n>
<https://www.barbarianmeetscoding.com/blog/boost-your-coding-fu-with-vscode-and-vim>
<https://www.reddit.com/r/vim/comments/14o2l0m/how_to_move_really_efficiently_in_vim/>
<https://vim.rtorr.com/>
<https://www.worldtimzone.com/res/vi.html>

# Lazy Vim Keybinds

<https://www.lazyvim.org/keymaps>
