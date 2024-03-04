# Normal Mode
## Basic Movement
h, j, k, l - left, down, up, right
0 - to first character in line
^ - first non blank character in line
$ - end of line
gm - middle of screen line
gM - middle of line
H - go to the upper part of the window
M - go to the middle of the window
L - go to the lower part of the window
f{char} : to the next occurence of {char}
F{char} : to the last occurence of {char}
t{char} : to the character before the next occurence of {char}
T{char} : to the character after the last occurence of {char}
; : repeat last f, F, t or T
, : repeat last f, F, t or T but reversied
G : goto the last line
gg : goto the first line 
:[N] : goto line N
[N]% : goto N percent of the file
w : one word forward
W : one blank-separated word forward
e : to the end of the next word
E : to the end of the next blank-separated word
b : one word backwards
B : one blank-sperated word backwards
) : sentence forward
( : sentence backwards
} : paragraph forward
{ : paragraph backwards
% : find the next bracket

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

## basic commands
u - undo
U - undo all changes on the line (to the last saved version)
Ctrl-R - redo
:w - write file
:q - quit file
:wq - write and quite file
:q! - quite file without saving
K - show help or documentary for the word under the cursor

## copy and past
p - paste after cursor
P - past before cursor
y - yank visual (or next motion)
yy - yank line
Y - yank until end of line
"{char} - select a register for the next yank or past command (default is * (middle mouse))
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
d{movement} - delete next movement
dd - delete full line
D - delete end of line
J - join lines (in visual mode, joins all selected lines)
cw - delete the next word and go to insert mode (can use other motions as well)
C - delete everthing on right and go to insert mode
cc or S - delete line and go to insert mode

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
q{char} - record types characters into register {char}
q - stop recording
Q - replay last recorded macro
@{char} - execute content of register {char}

## search
/{pattern} - search word forward
?{pattern} - search word backwards
* - search identifier under cursor forward
sharp (#) - search identifier under cursor backward
n - go to next finding
N - go to previous finding

## marks
m{mark} - mark current position with mark {char}
'{mark} - go to first non-blank character of the line of the mark
`{mark} - go to the exact position of the mark
:marks : print the active marks
Ctrl-O : go to the previous position in the jump list
Ctrl-I : go to the next position in the jump list
:ju : print jump list

#### moves from plugin
m, - set the next available (lowercase) mark
m; - toggle mark at current line
dmx - delete mark x
dm- - delete all marks on the current line
dm[Space] - delete all marks in the current buffer
m] - move to the next mark
m[ - move to the previous mark
m: - preview all marks
m{0-9} - set bookmark (can be set multiple times)
dm{0-9} - delete all bookmarks of the group
m} - move to the next bookmark of the same group
m{ - move to the previous bookmark of the same group
dm= - delete bookmark under cursor

#### marks types
{char} - local mark
{CHAR} - global mark
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

# Insert Mode:
## movement
Ctrl-{H,J,K,L} : left, down, up, right

## commentary
Ctrl-/ - toggle comment for line

## inserting
Ctrl-V{key} - insert {key} literally
Ctrl-R{register} - insert content of register {register}

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
o - exchange cursor position with start of highlighting
Ctrl-/ - toggle comment for block
Ctrl=-c - yank into register + (system clipboard)
Ctrl=-x - delete block and yank into register + (system clipboard)

# Windows Control (Normal Mode)
Ctrl-W followed by:
    w - go to next window (Ctrl can be hold)
    l - go to window on the left
    h - go to window on the right
    j - go to window below
    k - go to window above
    s - split window horizontal
    v - split window vertically
    n - create new empty window
    o - make current window the only one (close all others)
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
Ctrl-[Left] - dissmiss suggestion
Ctrl-[Right] - ask for suggestion
Ctrl-[Up] - next suggestion
Ctrl-[Down] - previous suggestion


# Telescope
[Space]ff - find files
[Space]fo - select old files
[Space]fg - live grep in working directory
[Space]fu - fuzzy find in current file 
[Space]fb - select buffers
[Space]fh - find help tags
[Space]fc - select from command history
[Space]f/ - select from search history 
[Space]ft - find tags
[Space]fi - find tags in curent buffer
[Space]fm - select marks
[Space]fr - select from register
[Space]fj - select jumplist
[Space]fq - select quickfix
[Space]f; - find commands
[Space]fs - select spell suggestions
[Space]fk - find keymaps
[Space]fz - find telescope picker
[Space]fzc - select colorscheme
[Space]fzo - find vim-options
[Space]fzh - find highlights
[Space]fza - find autocommands

## in telescope picker
#### insert mode:
Enter - open file
Ctrl-V - open file in vertical split
Ctrl-{J,K} - move up and down in insert mode 
Ctrl-Up,Ctrl-Down - last and next history
Ctrl-? - show help
Esc - go to normal mode
#### normal mode:
Enter - open file
v - open file in vertical split
j,k - move up and down
Ctrl-Up,Ctrl-Down - last and next history
? - show help

# Spectre
[Space]SR - search and replace in working directory (normal or visual mode)
[Space]SW - search current word in working directory (normal mode)
[Space]sr - search and replace in current file (normal or visual mode)
[Space]sr - search current word in current file (normal mode)
