# Normal Mode
## basic commands
u - undo
U - undo all changes on the line (to the last saved version)
Ctrl-R - redo
:w - write file
:q - quit file
:wq - write and quite file
:q! - quite file without saving
K - show help or documentary for the word under the cursor
[Space]p - format code (supports json, rs so far)
z= - show spelling suggestions
gt / gT - go to next / previous tab

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
F[char] - to the last occurence of [char] in current line (usung hop char1)
t[char] - hop char1 current window
T[char] - hop char1 all visible windows
; - hop word on all visible windows
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
} - paragraph forward
{ - paragraph backwards
% - find the next bracket

## jumps
[m / ]m - go to previous / next method start
[M / ]M - go to previous / next method end
[t / ]t - go to previous / next TODO or NOTE
[e / ]e - go to previous / next error or warning
[g / ]g - go to previous / next git hunk

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
p - paste after cursor
P - past before cursor
y - yank next motion (or selection in visual mode)
yy - yank line
Y - yank until end of line
"[char] - select a register for the next yank or past command (default is * (middle mouse))
:reg - show the content of all registers

#### registers
0 or " - yank register
1-9 - yank history
a-z - named registers
A-Z - append to named registers
* - system clipboard (middle mouse) (DEFAULT)
+ - system clipboard (Ctrl+c, Ctrl+v)
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

## deleting
x or Del - delete the character under the cursor
X - delete the character before the cursor
d[motion] - delete next motion
dd - delete full line
D - delete end of line
J - join line below (in visual mode, joins all selected lines)
cw - delete the next word and go to insert mode (can use other motions as well)
C - delete everthing on right and go to insert mode
cc or S - delete line and go to insert mode

## inside/around commands
Enter or ciw - change word under cursor
[Space]Enter ci( - change inside parentheses
cis - change current sentence
cip - change current paragraph

[Bracket] = (, ), [, ], {, }, <, >, ", ', `, also w for word, s for sentence, p for paragraph
[Space][Bracket] or ci[Bracket] - change inside brackets
ca[Bracket] - change around brackets
di[Bracket] - delete inside brackets
da[Bracket] - delete around brackets
yi[Bracket] - yank inside brackets
ya[Bracket] - yank around brackets
vi[Bracket] - select inside brackets
va[Bracket] - select around brackets

## surround
ys[motion][new] - add surrounding [new] to [motion]
cs[old][new] - change surrounding [old] with [new]
ds[old] - delete surrounding [old]
yss[new] - add surrounding [new] to line
S[new] - in visual mode: add surrounding [new]
[space]b - change brackets (same as csb)
[space]B - change quotes (same as csq)
[new/old] = [Bracket], b (brackets: >,),],}), q (quotes: ',",`), s (brackets, quotes), t (html-tags), f (function), i (individual start and end)

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
>> - tab line to the right
<< - tab line the the left

## repeating commands
. - repeat last change
q[char] - record types characters into register [char]
q - stop recording
Q - replay last recorded macro
@[char] - execute content of register [char]

## search
/[pattern] - search word forward
?[pattern] - search word backwards
* - search identifier under cursor forward
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
[Space]/n - open cheat sheet normal_mode.pdf
[Space]/s - open cheat sheet space.pdf
[Space]/c - open cheat sheet ctrl.pdf
[Space]/a - open cheat sheet alt.pdf

# Insert Mode:
## movement
Ctrl-{H,J,K,L} : left, down, up, right

## commentary
Ctrl-/ - toggle comment for line

## inserting
Ctrl-V - paste content of + register (system clipboard)
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
Ctrl-/ - toggle comment for block
Ctrl-c - yank into register + (system clipboard)
Ctrl-x - delete block and yank into register + (system clipboard)


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
    | - make current window almost full screen
    > - make current window larger
    < - make current window smaller

# Copilot (all commands in insert mode)
Ctrl-Enter - accept full suggestion
Ctrl-P - accept line
Ctrl-O - accept word
Ctrl-Right - request suggestion
Ctrl-Up - next suggestion
Ctrl-Down - previous suggestion
Ctrl-Left - dissmiss suggestion

# Telescope
\ - resume last telescope picker
[Space]ff - find files
[Space]fF or [Space] FF - find files including ignored and hidden files
[Space]fo - select old / recent files
[Space]fb - select buffers
[Space]fg - live grep in working directory
[Space]fu - fuzzy find in current file

[Space]fj - select jumplist
[Space]fm - select marks
[Space]fr - select from register
[Space]f/ - select from search history
[Space]fc - select from command history
[Space]f: - find commands
[Space]fh - find help tags
[Space]fk - find keymaps

[Space]fe - list diagnostics
[Space]fv - list symbols (variable names) of current file
[Space]fV - list symbols (variable names) of workspace
[Space]fa - open aerial picker
[Space]fq - select quickfix
[Space]fs - select spell suggestions

[Space]ft - select TODOs and NOTEs

[Space]fzc - select colorscheme
[Space]fzo - find vim-options
[Space]fzh - find highlights
[Space]fza - find autocommands

[Space]fz - find telescope picker

Ctrl-U / Ctrl-D - scroll preview window up/down (normal mode in telescope)
Ctrl-V / Ctrl-T (or v / t in normal mode) - open in new vsplit / tab

## in telescope picker
#### insert mode:
Enter - open file
Ctrl-V - open file in vertical split
Ctrl-T - open file in new tab
Ctrl-{J,K} - move up and down in insert mode
Ctrl-Up,Ctrl-Down - last and next history
Ctrl-? - show help
Esc - go to normal mode
#### normal mode:
Enter - open file
v - open file in vertical split
t - open file in new tab
j,k - move up and down
Ctrl-Up,Ctrl-Down - last and next history
? - show help

# Spectre
[Space]SR - search and replace in working directory (normal or visual mode)
[Space]SW - search current word in working directory (normal mode)
[Space]sr - search and replace in current file (normal or visual mode)
[Space]sr - search current word in current file (normal mode)
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

# Aerial
Ctrl-a - toggle aerial view (also in visual and insert mode)
[Space]fa - open telescope picker for aerial

# NvimTree
Ctrl-n - toggle nvim-tree
#### in nvim-tree
? or g? - show mappings
Enter - open file
v / Ctrl-v - open file in vertical split
t / Ctrl-t - open file in new tab
r - rename show full path
Ctrl-R - rename omit base name
Backspace - Close directory
Tab - open preview (open but stay in nvim-tree)
f - start filter
F - clear filter
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

# LSP
[Space]a - code action
[Space]d - peek definition
[Space]t - peek type definition
[Space]u - list usages/references
[Space]i - Lspsaga finder (show, definition, type-definition, references, and implementation)
Enter / v / t - in preview window: open in current window, vertical split, new tab

[Space]e - goto next diagnostics or show diagnostics under cursor
[Space]E - goto previous diagnostics
[Space]r - rename
[Space]p - format code

[Space]fe - list diagnostics
[Space]fv - list symbols (variable names) of current file
[Space]fV - list symbols (variable names) of workspace
[Space]fq - select quickfix

Ctrl-e - toggle signature help (in insert mode)

# Autocomplete (cmp)
Ctrl-Space - open autocomplete menu
Tab - open autocomplete menu (if text of the left)
## in autocomplete menu
Ctrl-j - move down
Ctrl-k - move up
Tab - next suggestion
Shift-Tab - previous suggestion
Enter or Ctrl-Space - confirm suggestion
Ctrl-U - scroll docs up
Ctrl-D - scroll docs down
Esc - close menu

## in function snippet
Tab - move to next placeholder
Shift-Tab - move to previous placeholder

# Rust
[Space]ct - runt test under cursor
[Space]cT or [Space]CT - run all tests
[Space]cb - build project
[Space]cr - run project

