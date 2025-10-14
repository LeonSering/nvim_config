# Iterm2 settings:

Preferences -> Profiles -> Keys -> Key Mappings -> +
-> "Send Escape Sequence"

^Return to [13;5u (Ctrl+Enter)
^Up to [1;5A (for Ctrl+Up)
^Down to [1;5B (for Ctrl+Down)
^Right to [1;5C (for Ctrl+Right)
^Left to [1;5D (for Ctrl+Left)
^Return [13;2u (for Shift+Enter)

-> "Send Hex Codes"

^/ to 0x1f (for Ctrl-/)

# Normal Mode

## basic commands

u - undo
U - undo all changes on the line (to the last saved version)
Ctrl-R - redo
Ctrl-s - write/save file
[Space]w or Ctrl+s or :w - write buffer (save file)
:q - quit window
[Space]q or :wq - write buffer and quit window
:q! - quite file without saving
K - show help or documentary for the word under the cursor
[Space]p - format code (supports json, rs so far)
z= - show spelling suggestions
gt / gT - go to next / previous tab
Ctrl-\ - open floating terminal

## basic movement

h, j, k, l - left, down, up, right
0 - to first character in line
^ - first non blank character in line
$ - end of line
gm - middle of screen line
gM - middle of line
ge - previous end of word
H - go to the upper part of the window
M - go to the middle of the window
L - go to the lower part of the window
f[char] - to the next occurence of [char] in current line (using hop char1)
F[char] - to the previous occurence of [char] in current line (using hop char1)
t[char] - one letter to the left of the next occurence of [char] in current line (using hop char1)
T[char] - one letter to the right of previous occurence of [char] in current line (using hop char1)
;[char] - hop char1 all visible windows
G - goto the very last line
gg - goto the very first line
:[N] - goto line N
[N]% - goto N percent of the file
w - one word forward
W - one blank-separated word forward
e - to the end of the next word
E - to the end of the next blank-separated word
b - one word backwards
B - one blank-sperated word backwards
) - sentence forward
( - sentence backwards
% - find the next bracket

## jumps

[f / ]f - go to previous / next function start
[F / ]F - go to previous / next function end
`[[ / ]]`- go to previous / next class start
[] / ][ - go to previous / next class end
[t / ]t - go to previous / next TODO or NOTE
[e / ]e - go to previous / next diagnostic
[g / ]g - go to previous / next git hunk
{ - previsous aerial section
} - next aerial section

## scrolling

Ctrl-E - go down a line and scroll window
Ctrl-D - go down a half window
Ctrl-F - go down a full window
Ctrl-Y - go up a line and scroll window
Ctrl-U - go up a half window
Ctrl-B - go up a full winodw
Shift-Up - scroll up fast
Shift-Down - scroll down fast
zz - center the screen on the cursor
zt - center the screen on the top
zb - center the screen on the bottom

## copy and past

p - paste after cursor line
P - past before cursor line
Ctrl-H - previous yanked entry (right after pasting)
Ctrl-L - next yanked entry (right after pasting)
y - yank next motion (or selection in visual mode)
yy - yank line
Y - yank until end of line
"[char] - select a register for the next yank or past command (default is \* (middle mouse))
:reg - show the content of all registers

#### registers

0 or " - yank register
1-9 - yank history
a-z - named registers
A-Z - append to named registers

- - system clipboard (middle mouse) (DEFAULT)

* - system clipboard (Ctrl+c, Ctrl+v)
    . - last inserted text
    : - last command
    % - current file name
    / - last search pattern

## enter insert mode

a - append text after the cursor
A - append text at the end of line
i - insert text before the cursor
I - insert text before the first non-blank in the line
o - open a new line below and append text
O - open a new line above and append text
cw - delete the next word (yanking) and go to insert mode (can use other motions as well)
C - delete everthing on right (yanking) and go to insert mode
cc or S - delete line (yanking) and go to insert mode
Backspace - delete the character before the cursor (yanking) go to insert mode

## deleting

Del - delete the character under the cursor (yanking)
x - delete the character under the cursor (no yanking)
X - delete the character before the cursor (no yanking)
x / X in visual mode - delete selection (no yanking)
d[motion] - delete next motion (yanking)
dd - delete full line (yanking)
D - delete end of line (yanking)
cw - delete the next word (yanking) and go to insert mode (can use other motions as well)
C - delete everthing on right (yanking) and go to insert mode
cc or S - delete line (yanking) and go to insert mode
Backspace - delete the character before the cursor (yanking) go to insert mode

## inside/around commands

Enter or ciw - change word under cursor
[Space]Enter ci( - change inside parentheses
cis - change current statement
cip - change current paragraph

[Bracket] = (, ), [, ], {, }, <, >, ", ', `,
[Object] = w (word), p (paragraph), f (function), c (class), s (statement), l (loop), b (block), m (method call), a (argument), k (comment)
[Space][Bracket] - change inside brackets
ci[Bracket/Object] - change inside
ca[Bracket/Object] - change around
di[Bracket/Object] - delete inside
da[Bracket/Object] - delete around
yi[Bracket/Object] - yank inside
ya[Bracket/Object] - yank around
vi[Bracket/Object] - select inside
va[Bracket/Object] - select around
<i[Bracket/Object] - decrease indent inside
<a[Bracket/Object] - decrease indent around

> i[Bracket/Object] - increase indent inside
> a[Bracket/Object] - increase indent around

## surround

sa[motion][new] - add surrounding [new] to [motion]
sc[old][new] - change surrounding [old] with [new]
sd[old] - delete surrounding [old]
ss[new] - add surrounding [new] around current word
sA[new] - add surrounding [new] around current line
[space]c - change brackets (same as csb)
[space]C - change quotes (same as csq)
s[new] - in visual mode: add surrounding [new] around selection
S[new] - in visual mode: add surrounding [new] around selection inserting line breaks
[new/old] = (, ), [, ], {, }, <, >, ", ', `, t (html-tag: <tag>inner<\tag>), f (function: my_function(inner)), g (generic: MyType<Inner>)
[new] = i (individual start and end)
[old] = b (any bracket <>, (), [], {}), q (any quote '',"",``), s (any bracket or quote)

## enter visual mode

v - enter visual mode
V - enter visual mode full line
Ctrl-V - enter visual box mode
gv - reselect last visual selection

## changing text

r - replace the character under cursor
R - enter replace mode
~ - toggle case of the character under cursor

## indentation

> > - tab line to the right
> >   << - tab line the the left

## repeating commands

. - repeat last change
q[char] - record types characters into register [char]
q - stop recording
Q - replay last recorded macro
@[char] - execute content of register [char]

## search

/[pattern] - search word forward
?[pattern] - search word backwards

- - search identifier under cursor forward
    sharp (#) - search identifier under cursor backward
    n - go to next finding
    N - go to previous finding

## marks

m[mark] - mark current position with [mark]
'[mark] - go to first non-blank character of the line of the mark
`[mark] - go to the exact position of the mark
:marks : print the active marks
Ctrl-O : go to the previous position in the jump list
Ctrl-I : go to the next position in the jump list
:ju : print jump list

#### moves from marks-plugin

m, - set the next available (lowercase) mark
m; - toggle mark at current line
dmx - delete mark x
dm- - delete all marks on the current line
dm[Space] - delete all marks in the current buffer
m] - move to the next mark
m[ - move to the previous mark
m[0-9] - set bookmark (can be set multiple times)
dm[0-9] - delete all bookmarks of the group
m} - move to the next bookmark of the same group
m{ - move to the previous bookmark of the same group
dm= - delete bookmark under cursor

#### marks types

[char] - local mark
[CHAR] - global mark
` - go to position before the last jump
" - go to the position when last exiting the file
^ - go to the position where the last time Insert mode was stopped
. - go to the position of the last change in this file
[ - go to the start of the last change or yank
] - go to the end of the last change or yank
< - go to the start of the last visual selection

> - go to the end of the last visual selection

## commentary

Ctrl-/ - toggle comment for line
Ctrl-K - toggle comment for line and go up
Ctrl-J - toggle comment for line and go down

## open config files and cheat sheets

[Space]\ - open nvim config file lua/options.lua
[Space]| - open nvim config file lua/mappings.lua
[Space]? - open this keymappings.md
[Space]/n - open cheat sheet normal_mode
[Space]/s - open cheat sheet space
[Space]/c - open cheat sheet ctrl
[Space]/a - open cheat sheet alt
[Space]/f - open cheat sheet FzfLua

# Insert Mode:

## movement

Ctrl-{H,J,K,L} : left, down, up, right

## commentary

Ctrl-/ - toggle comment for line

## inserting

Ctrl-V - paste at cursor position (even if lines were yanked)
(afterwards in normal mode Ctrl-H / Ctrl-L - previous / next yanked entry)
Ctrl-R[register] - insert content of register [register]

## deleting

Ctrl-S - delete the character under the cursor
Ctrl-B - delete previous word
Ctrl-U - delete everything on the left
Ctrl-X - delete single character on the right
Ctrl-W - delete next word
Ctrl-A - delete until end of line

## indentation

Ctrl-T (insert mode) - indent line
Ctrl-D (insert mode) - unindent line

# Visual Mode:

o - exchange cursor position with start of selection
J - joins all selected lines
S[new] - change surrounding delimiter to [new]
x - delete without yanking
Ctrl-/ - toggle comment for block
Ctrl-C - yank into register + (system clipboard)
Ctrl-X - delete block and yank into register + (system clipboard)

# Windows Control

## Custom settings (All Modes)

Alt-Q - close all other windows
Alt-W - maximize current window
Alt-E - rotate windows to the left
Alt-R - rotate windows to the right
Alt-T - move current window to new tab
Alt-A - go to previous window (cyclic)
Alt-S - equalize width of all windows
Alt-D - go to next window (cyclic)
Alt-Z - close window
Alt-X - open new buffer in vertical split
Alt-C - close current tab
Alt-V - split window vertically (dublicate current buffer)
Alt-N - go to left tab (equals gT in normal mode)
Alt-M - go to right tab (equals gt in normal mode)
Alt-H - go to previous window (cyclic)
Alt-J - go to window below
Alt-K - go to window above
Alt-L - go to next window (cyclic)

## Default settings (Normal Mode) - disabled

Ctrl-W followed by:
w - go to next window (Ctrl can be hold)
l - go to window on the left
h - go to window on the right
j - go to window below
k - go to window above
s - split window horizontal
v - split window vertically
n - create new empty window
o - close all other windows
p - previsou active windows
r - rotate to the right or upwards
R - rotate to the left or downwards
= - make all windows equal size
| - make current window almost full screen > - make current window larger
< - make current window smaller

# Copilot (all commands in insert mode)

Ctrl-Enter - accept full suggestion
Ctrl-P - accept line
Ctrl-O - accept word
Ctrl-Right - request suggestion
Ctrl-Up - next suggestion
Ctrl-Down - previous suggestion
Ctrl-Left - dissmiss suggestion

# Github copilot chat (except for Ac and Aq all commands need visual selection)

Ctrl-C - toggle chat window
[Space]Ap - quick chat (full buffer)
[Space]Ac - open chat window
[Space]Ax - explain code
[Space]Ar - review code
[Space]Ao - optimize code
[Space]Af - fix code
[Space]Af - fix diagnostics
[Space]At - generate tests
[Space]Ad - generate documentation
[Space]Ap - format comment to 100 chars per line
[Space]As - correct spelling
[Space]Aw - improve wording
[Space]Am - summarize
[Space]Ag - write git commit message

## in chat window:

gh - go to help
C-l - clear chat window
C-y - accept diff
[Enter] in normal mode / Ctrl-Enter in insert mode - send message
[Esc] - close chat window

# FzfLua

\ - resume last FzfLua picker
[Space]ff - files
[Space]fF or [Space] FF - files including ignored and hidden files
[Space]fo - old / recent files
[Space]fb - buffers
[Space]fg - live grep in working directory (normal or visual mode)
[Space]fG or [Space] FG - live grep in working directory (word under cursor)
[Space]fw - grep word under cursor
[Space]f/ - fuzzy find in current file

[Space]fj - jumplist
[Space]fm - marks
[Space]fr - register
[Space]f? - search history
[Space]fc - command history
[Space]f: - commands
[Space]fh - help tags
[Space]fk - keymaps

[Space]fe - errors
[Space]fE or [Space]FE - errors and warnings
[Space]fu - references / usages
[Space]fi - incoming calls
[Space]fv - symbols of current file
[Space]fV or [Space]FV - symbols of workspace
[Space]fa - LSP document structure (aerial like)
[Space]fq - quickfix

[Space]fs - spell suggestions
[Space]fp - select from yank history for pasting (telescope)
[Space]ft - select TODOs and NOTEs (telescope)

[Space]fzc - colorscheme
[Space]fzo - vim-options
[Space]fzh - highlights
[Space]fza - autocommands

[Space]fzz - FzfLua picker

[Space]gl - Git log of current file

#### in FzfLua picker

Esc - close picker
Enter - open file or select item
Ctrl-{j,k} - move up and down
Ctrl-v / Ctrl-t (or v / t in normal mode) - open in new vsplit / tab
Shift-up/down - scroll preview window up/down
Shift-Alt-up/down - scroll preview window up/down fast
F1 - show keymappings
F2 - toggle fullscreen
F3 - wrap lines in preview window
F4 - toggle preview window

# Spectre

[Space]SR - search and replace in working directory (normal or visual mode)
[Space]SW - search current word in working directory (normal mode)
[Space]sr - search and replace in current file (normal or visual mode)
[Space]sw - search current word in current file (normal mode)

#### in spectre

? - show mappings
Enter - open file
ti - toggle ignore case
dd - toggle item
[Space]r - replace current item
[Space]R - replace all marked items

# Git

[Space]gb - toggle git blame
[Space]gs - toggle git signs (line diff in signcolumn)
[Space]gw - toggle git inline changes (word diff)
[Space]gl - open git log of current file to open vimdiff
[Space]gh - open git DiffviewFileHistory of current file
[Space]gH - open git DiffviewFileHistory of working directory
[Space]gd - open git Diffview against current index (three-way diff)
[Space]ga - stages / unstages git hunk (in visual mode only selected lines)

# Aerial

Ctrl-a - toggle aerial view (also in visual and insert mode)

# NvimTree

Ctrl-n - toggle nvim-tree

#### in nvim-tree

? or g? - show mappings
Enter - open file
v / Ctrl-v - open file in vertical split
t / Ctrl-t - open file in new tab
r - rename show full path
Ctrl-r - rename omit base name
Backspace - Close directory
Tab - open preview (open but stay in nvim-tree)
f - start filter
F - clear filter
x - cut node
c - copy node
p - paste node
d - delete
R - refresh view
K - info about node
Ctrl-] - change root
a - create new file
H - toggle hidden files
I - toggle gitignored files
P - go to parent directory
E - expand all
W or C - collapse all

# Visual-Multi (multiple cursors)

[Space]m - search for word under cursor (selection in visual mode)
[Space]M - search for word under cursor (selection in visual mode) and select all
Ctrl-Up/Down/Left/Right - add cursor at current location and move to direction

## in visual-multi mode:

Tab - switch between cursor and extend mode
[movement] - move all cursors (in extend mode j/k moves to start/end of line; use Shift-Up/Down instead)
Up/Down/Left/Right - move independent of other cursors
Ctrl-Up/Down/Left/Right - toggle additional cursor at current location and move to direction
Shift-Up/Down/Left/Right - switch to extend mode and select in the direction
n/N - go to next/previous match and add a cursor there
q/Q - remove current cursor and go the next/previous match
]/[ - go the next/previous cursor
o - switch to other side of selection (in extend mode)
[Space][Space] followed by
a - align at cursors
C - case conversion menue
n - add increasing numbers (starting with 1)
0n - add increasing numbers (starting with 0)

# LSP

[Space]a - code action
[Space]d - peek definition
[Space]t - list type definitions
[Space]u - list usages/references/definitions/type_definitions
Enter / v / t - in preview window: open in current window, vertical split, new tab

[Space]e - go to next diagnostic and open floating window (rust: rendered as in terminal)
[Space]E - go to previous diagnostics and open floating window (rust: rendered as in terminal)
]e - go to next diagnostic and open floating window with code actions
[e - go to previous diagnostic and open floating window with code actions
[Space]h - toggle inlay hints / show types
[Space]l - toggle lsp lines
[Space]rn - rename symbol (refactoring)
[Space]p - format code

[Space]fe - list diagnostics
[Space]fv - list symbols (variable names) of current file
[Space]fV - list symbols (variable names) of workspace
[Space]fq - select quickfix

Ctrl-e - toggle signature help (in insert mode)

# Autocomplete (blink.cmp)

Ctrl-Space - open autocomplete menu
Tab - open autocomplete menu (if text on the left of cursor)

## in autocomplete menu

Tab / Ctrl-j - move down
Shift-Tab / Ctrl-k - move up
Enter or Ctrl-Space - confirm suggestion
Ctrl-e - toggle docs
Ctrl-u - scroll docs up
Ctrl-d - scroll docs down
Esc - close menu

## in function snippet

Tab - move to next placeholder
Shift-Tab - move to previous placeholder

# Rust

[Space]rt - run test under cursor
[Space]rT or [Space]RT - run all tests
[Space]rb - cargo build
[Space]rc - cargo clippy
[Space]rr - cargo run
[Space]rd - open docs in browser
[Space]re - explain next error
[Space]rE or [Space]RE - explain previous error
[Space]rlb - build test coverage (cargo llvm-cov) and show signs
[Space]rlt - toggle test coverage signs
[Space]rls - show test coverage summary
[Space]rk - move item up / left
[Space]rj - move item down / right

# Debugging

[Space]bp - toggle breakpoint
[Space]bs - start new debugging session
[Space]bt - terminate
[Space]bc - continue to next breakpoint
[Space]bn - next step / step over
[Space]bi - step in
[Space]bo - step out
[Space]bu - toggle dap-ui

# Neotest

[Space]nt - run test under cursor
[Space]nf - run all tests in file
[Space]na - run all tests in project
[Space]ns - stop running tests
[Space]np - toggle output panel
[Space]nn - toggle summary panel
[Space]nw - toggle watch for test under cursor (runs automatically after text change)
[Space]nc - clear output panel
