"""""""""""""""""""""""""""""""""""""""""""""
" plugins 
"""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'AutoComplPop'
"Plug 'TeX-PDF'
Plug 'a.vim'
"Plug 'CSApprox'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-reload'
Plug 'sk1418/QFGrep'
Plug 'junegunn/vim-easy-align'
Plug 'yssl/vim-fugitive'
"Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'xolox/vim-session'
Plug 'vim-scripts/Conque-Gdb'

" my plugins
Plug 'yssl/QFEnter'
Plug 'yssl/TWcmd.vim'
Plug 'yssl/AutoCWD.vim'
Plug 'yssl/VIntSearch'
Plug 'yssl/AutoSettings.vim'

" requires gnome-terminal setting :
" Edit > Keyboard Shortcuts > uncheck "Enable menu access keys"
" Edit > Keyboard Shortcuts > uncheck "Enable menu shortcut keys"
" Edit > Keyboard Shortcuts > unbind F1 to Help
Plug 'drmikehenry/vim-fixkey'

" color schemes
Plug 'molokai'
Plug 'Wombat'
Plug 'obsidian'
Plug 'inkpot'
Plug 'werks.vim'
Plug 'xoria256.vim'
Plug 'jellybeans.vim'
Plug 'Zenburn'
Plug 'sjl/badwolf'
Plug 'Gummybears'
Plug 'junegunn/seoul256.vim'
Plug 'rdark'
Plug 'croaker/mustang-vim'
Plug 'neverland.vim--All-colorschemes-suck'
Plug 'vydark'
Plug 'Sorcerer'
Plug 'twerth/ir_black'

call plug#end()

"easy
"colorscheme obsidian
"colorscheme jellybeans
colorscheme xoria256
"colorscheme mustang
"colorscheme wombat
"colorscheme vydark
"colorscheme sorcerer

"bright
"colorscheme werks
"colorscheme desert

"dark
"colorscheme gummybears
"colorscheme rdark
"colorscheme ir_black

"high constrast
"colorscheme badwolf
"colorscheme molokai
"colorscheme inkpot
"colorscheme neverland

"low constrast
"colorscheme zenburn
"colorscheme seoul256

"""""""""""""""""""""""""""""""""""""""""""""
" vim options - common
"""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

syntax on    " syntax highlighting on
set hlsearch " switch on highlighting the last used search pattern

" The % key will switch between opening and closing brackets. By sourcing matchit.vim, the key can also switch among e.g. if/elsif/else/end, between opening and closing XML tags, and more. 
runtime macros/matchit.vim

" ctags - search 'tag' file from current directory to root directory
" recursively (';' is the key!)
set tags=./tags;,tags;
set notagbsearch

" guioptions
set guioptions-=T	"remove toolbar
set guioptions-=m	"remove menubar
set guioptions-=l	"left scrollbar always
set guioptions-=L	"left scrollbar
set guioptions-=r	"right scrollbar always
set guioptions-=R	"right scrollbar
set guioptions-=h	"bottom scrollsbar

set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch  " do incremental searching

set fdm=indent    " code folding using indentation
set ignorecase    " ignore case when search
set noswapfile    " no swap file
let mapleader="," " change <leader> key

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" not used anymore
"source $VIMRUNTIME/vimrc_example.vim
"set t_Co=256
"set fileencodings=utf-8

"""""""""""""""""""""""""""""""""""""""""""""
" vim options - platform dependent
"""""""""""""""""""""""""""""""""""""""""""""
if has('win32')
	" Ctrl+V to paste in command and insert mode on Windows. From $VIMRUNTIME/mswin.vim
	cmap <C-V> <C-R>+
	exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']

	set guifont=Consolas:h12 " font
	set backupdir=c:\\temp   " tmp backup
	set clipboard=unnamed    " clipboard - use system clipboard
else
	set guifont=Monospace\ 12    " font
	set backupdir=/tmp           " tmp backup
	set clipboard=unnamedplus    " clipboard - use system clipboard
endif

"""""""""""""""""""""""""""""""""""""""""""""
" common functions
"""""""""""""""""""""""""""""""""""""""""""""
fun! s:nnoreicmap(option, shortcut, command)
	exec 'nnoremap '.a:option.' '.a:shortcut.' '.a:command
	exec 'imap '.a:option.' '.a:shortcut.' <Esc>'.a:shortcut
	exec 'cmap '.a:option.' '.a:shortcut.' <Esc>'.a:shortcut
endfun

"""""""""""""""""""""""""""""""""""""""""""""
" autocmds
"""""""""""""""""""""""""""""""""""""""""""""
"set shellpipe=>%s\ 2>&1	|"windows default
"set shellpipe="2>&1| tee"	|"unix default
"set shellpipe=2>&1\|\ wtee |"test

augroup mygroup
	autocmd!

	" disable auto commenting with new line
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

	" all folds open when opening a file except NerdTree
	autocmd BufWinEnter * normal! zR
	autocmd FileType nerdtree setlocal foldlevel=99

	" enter key in normal mode
	autocmd BufEnter * if &modifiable==1 | nnoremap <buffer> <CR> o<Esc>| endif

	" highlight current window cursor line
	" autocmd BufEnter,WinEnter * if getbufvar(bufnr('%'), '&buftype')!=#'quickfix' | set cursorline | endif
	autocmd BufEnter,WinEnter * set cursorline
	autocmd WinLeave * set nocursorline |"nocursorcolumn

	"" remove trailing whitespace
	"autocmd BufWritePre * :%s/\s\+$//e

augroup END

"""""""""""""""""""""""""""""""""""""""""""""
" AutoSettings.vim
"""""""""""""""""""""""""""""""""""""""""""""
" default edit & build settings for all file types

" text wrapping
set nowrap
set textwidth=0

" indentation
set tabstop=4
set shiftwidth=4
set noexpandtab

" makeprg (with immediate output prints)
set makeprg=stdbuf\ -i0\ -o0\ -e0\ make\ %

" errorformat to go to the last line ("ERROREND" print out)
set errorformat+=ERROREND
set errorformat+=ERROREND\ 

" default: blank,buffers,curdir,folds,help,options,tabpages,winsize
set sessionoptions=curdir,folds,help,options,tabpages,winpos,winsize

"""""""""""""""""""""""""""""""""""""""""""""
" different makeprg for each platform

if has('win32')
	" blocking make. results are displayed in quickfix after program is finished.
	"\'makeprg=(python\ %\ &\ echo\ ERROREND)',

	" non-blocking make. but no way to put results to quickfix.
	"\'makeprg=start\ cmd\ /c\ \"python\ %\ &\ echo\ ERROREND\"',

	"""""""""""""""""""""""""""""""""""""""""
	" new windows version using GnuWin CoreUtils tee (http://gnuwin32.sourceforge.net/packages.html#Setup)
	" : non-blocking make, result are displayed in quickfix after program is finished.
	" unbuffered output should be done by each makeprg, because ms windows inherently does not have something like 'stdbuf'
	" for example, python -u

	" temp file to write stdout of program
	let s:tempfile = tempname()
	"let s:tempfile = 'c:/Users/yoonsang/temp.txt'

	let s:makeprg_pre = 'start\ cmd\ /c\ \"('
	let s:makeprg_post = '\ &\ echo\ ERROREND)\ 2>&1\ \\|\ tee\ '.s:tempfile.'\ &\ gvim\ --server-name\ '.v:servername.'\ --remote-send\ :FillQuickfixWithTempFile^<CR^>\"'

	"" for hangul
	"let s:makeprg_pre = 'start\ cmd\ /k\ \"('
	"let s:makeprg_post = '\ &\ echo\ ERROREND)\ 2>&1\"'
	
	" 'makeprg='.s:makeprg_pre.'python\ -u\ %'.s:makeprg_post
	" ->
	" 'makeprg=start\ cmd\ /c\ \"(python\ -u\ %\ &\ echo\ ERROREND)\ 2>&1\ \\|\ tee\ '.s:tempfile.'\ &\ gvim\ --server-name\ '.v:servername.'\ --remote-send\ :FillQuickfixWithTempFile^<CR^>\"'
	" ->
	" start cmd /c "(python -u test.py & echo ERROREND) 2>&1 | tee temp.txt & gvim --server-name GVIM --remote-send :FillQuickfixWithTempFile^<CR^>"

	func! s:FillQuickfixWithTempFile()
		exec 'cgetfile '.s:tempfile
		call delete(s:tempfile)
		call QuickfixCWindowError()
	endfun

	command! FillQuickfixWithTempFile call s:FillQuickfixWithTempFile()

else
	"""""""""""""""""""""""""""""""""""""""""
	" linux version
	" : no delay, unbuffered screen output

	let s:makeprg_pre = 'stdbuf\ -i0\ -o0\ '
	let s:makeprg_post = ';\ echo\ ERROREND'

	" 'makeprg='.s:makeprg_pre.'python\ %'.s:makeprg_post
	" ->
	" stdbuf -i0 -o0 python test.py; echo ERROREND
endif

"""""""""""""""""""""""""""""""""""""""""""""
" local settings for file path

" build & run shortcut
" F9 : build & run
" C-S-A-F9 : build all & run
" C-F9 : run
" A-F9 : build only
" S-F9 : debugger run (conquegdb)
" F12 : toggle release/debug
" A-S-F12 : clean
" S-F12 : configure

let g:autosettings_settings = [
	\[['*'],{
		\'setLocals':[
			\'textwidth=0',
			\'encoding=cp949',
		\],
	\}],
	\[['*.cpp','*.c','*.h','*.hpp'],{
		\'setLocals':[
			\'expandtab',
		\],
	\}],
	\[['*.bat'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':w<CR>:silent Make<CR>']
		\],
		\'setLocals':[
			\'expandtab',
			\'makeprg='.s:makeprg_pre.'%'.s:makeprg_post,
		\],
	\}],
	\[['*.txt','*.md','*.html','*.htm'],{
		\'setLocals':[
			\'wrap',
		\],
	\}],
	\[['*.py'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':w<CR>:silent Make<CR>']
		\],
		\'setLocals':[
			\'expandtab',
			\'makeprg='.s:makeprg_pre.'python\ -u\ %'.s:makeprg_post,
			\'errorformat=ERROREND\ ',
		\],
	\}],
	\[['*/DMLcpp/*'],{
		\'buildConfigNames':['release','debug'],
		\'buildConfigs':{
			\'release':{
				\'localMaps':[
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ rbuildrun\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ rbuild\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ rrun\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ rclean\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
				\],
			\},
			\'debug':{
				\'localMaps':[
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ dbuildrun\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ dbuild\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ drun\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ dclean\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
				\],
			\},
		\},
	\}],
	\[['*/DMLpy/setup.py','*/DMLcpp/*/*_py.cpp'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ setup.py\ build_ext'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ setup.py\ clean'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
		\],
	\}],
	\[['*utf8.tex', '*utf.tex'],{
		\'setLocals':[
			\'encoding=utf8',
			\'fileencoding=utf8',
		\],
	\}],
	\[['*/dart/*'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ rbuildrun\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ rbuild\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ rrun\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ rclean\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
		\],
	\}],
\]

if has('win32')
	fun! OpenCurrentPDF()
		exec 'silent !start cmd /K "start '.fnamemodify(expand('%'), ":p:r").'.pdf && exit"'
	endfun

	call add(g:autosettings_settings,
		\[['*.tex'],{
			\'localMaps':[
				\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':w<CR>:silent Make<CR>:call OpenCurrentPDF()<CR>'],
				\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':w<CR>:silent Make<CR>'],
				\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':w<CR>:call OpenCurrentPDF()<CR>'],
				\[['nnoremap'], '<Leader>fs', ':call Tex_ForwardSearchLaTeX()<CR>'],
			\],
			\'setLocals':[
				\'wrap',
				\'expandtab',
				\'makeprg='.s:makeprg_pre.'latexmk\ -pdf\ -latexoption=\"-synctex=1\"\ %'.s:makeprg_post,
			\],
		\}])
else
	function! Tex_ForwardSearchLaTeX()
	let cmd = 'evince_forward_search ' . fnamemodify(Tex_GetMainFileName(), ":p:r") . '.pdf ' . line(".") . ' ' . expand("%:p")
	let output = system(cmd)
	endfunction

	function! Tex_GetMainFileName()
		return expand('%')
	endfunction

	call add(g:autosettings_settings,
		\[['*.tex'],{
			\'localMaps':[
				\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':w<CR>:BuildAndViewTexPdf<CR>:call QuickfixCWindowError()<CR><C-l><C-l>'],
				\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':w<CR>:BuildTexPdf<CR>:call QuickfixCWindowError()<CR><C-l>'],
				\[['nnoremap'], '<Leader>fs', ':call Tex_ForwardSearchLaTeX()<CR>'],
			\],
			\'setLocals':[
				\'wrap',
				\'expandtab',
			\],
		\}])
endif

	"\[['*/DMLcpp/*'],{
		"\'buildConfigNames':['release','debug'],
		"\'buildConfigs':{
			"\'release':{
				"\'localMaps':[
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ rbuildrun\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ rbuild\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ rrun\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ rclean\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
				"\],
				"\'localMapsExpr':[
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<S-F9>', "':ConqueGdb '.split(system('make rprintbin'),'\n')[1].'<CR>'"],
				"\],
			"\},
			"\'debug':{
				"\'localMaps':[
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ dbuildrun\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ dbuild\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ drun\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:makeprg_pre.'python\ -u\ make.py\ dclean\ %'.s:makeprg_post.'<CR>:w<CR>:silent Make<CR>'],
				"\],
				"\'localMapsExpr':[
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<S-F9>', "':ConqueGdb '.split(system('make dprintbin'),'\n')[1].'<CR>'"],
				"\],
			"\},
		"\},
	"\}],

	"\[['*/dali*'],{
		"\'setLocals':[
			"\'tabstop=2',
			"\'shiftwidth=2',
			"\'expandtab',
		"\],
	"\}],
	"\[['*/homescreen*','*/itc*','*/online-doc*'],{
		"\'setLocals':[
			"\'tabstop=2',
			"\'shiftwidth=2',
			"\'noexpandtab',
		"\],
	"\}],
	"\[['*/dali*'],{
		"\'configNames':['release','debug'],
		"\'defaultConfigName':'release',
		"\'commonConfig':{
			"\'localMapsExpr':[
				"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', "':Dispatch makedali.py install2run '.expand('%:p').'; echo \"END:0::\"<CR>'"],
				"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', "':Dispatch makedali.py run '.expand('%:p').'; echo \"END:0::\"<CR>'"],
				"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<S-F9>', "':ConqueGdb '.$DESKTOP_PREFIX.'/bin/'.GetDaliRunFile(expand('%:p')).'; echo \"END:0::\"<CR>'"],
				"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', "':Dispatch makedali.py install '.expand('%:p').'; echo \"END:0::\"<CR>'"],
				"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', "':Dispatch makedali.py clean '.expand('%:p').'; echo \"END:0::\"<CR>'"],
			"\],
		"\},
		"\'configs':{
			"\'release':{
				"\'localMapsExpr':[
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-S-A-F9>', "':Dispatch makedali.py install_all2run_release '.expand('%:p').'; echo \"END:0::\"<CR>'"],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<S-F12>', "':Dispatch makedali.py configure_release '.expand('%:p').'; echo \"END:0::\"<CR>'"],
				"\],
			"\},
			"\'debug':{
				"\'localMapsExpr':[
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-S-A-F9>', "':Dispatch makedali.py install_all2run_debug '.expand('%:p').'; echo \"END:0::\"<CR>'"],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<S-F12>', "':Dispatch makedali.py configure_debug '.expand('%:p').'; echo \"END:0::\"<CR>'"],
				"\],
			"\},
		"\},
	"\}],

"""""""""""""""""""""""""""""""""""""""""""""
" key mappings - not necessary for xterm
"""""""""""""""""""""""""""""""""""""""""""""
"if !has('gui_running')
	"" to recognize alt key in gnome terminal
	"" http://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim
	"function! RegisterAltMaps(start_ascii, end_ascii)
		"let n=a:start_ascii
		"while n <= a:end_ascii
		  "let c = nr2char(n)
		  "if c==#'"'
			  "let c = '\'.c
		  "elseif c==#'>' || c==#'|'
			  "let n = n+1
			  "continue
		  "endif
		  "exec "set <A-".c.">=\e".c
		  "exec "imap \e".c." <A-".c.">"
		  "let n = n+1
		"endw
	"endfunction
	""call RegisterAltMaps(48, 57)	|"0 to 9
	"call RegisterAltMaps(92, 93)	|"\,]
	"call RegisterAltMaps(45, 61)	|"-,=
	"call RegisterAltMaps(40, 41)	|"(,)
	""call RegisterAltMaps(97, 122)	|"a to z - now vim-fixkey do this.
	"set timeout ttimeoutlen=50
"endif

"""""""""""""""""""""""""""""""""""""""""""""
" useful default mappings
"
" [[, ]] : cursor N sections backward, forward
" [z, ]z : move to start, end of open fold
" p`[, P`[ : paste without moving cursor
" C-o, C-i : you can go to cursor positions before older jumps, and back again.
" C-p, C-n : up, down. do not remap these keys because it is very useful with AutoComplPop plugin
" C-e, C-y : scroll one line down, up
" zl, zL / zh, zH : scroll left one line, half screenwidth / right one line, half screenwidth
" zs, ze : scroll horizontally to position the cursor at the start / end of the screen
" C-w : instead of Ctrl-Delete in insert mode
" C-^ : switch back to the previous buffer
" g C-g : word count
" gv : reselect visual block
" f-<char> : jump to next <char>
" zz, zt, zb : put the line with the cursor at the center, top, bottom
" [I : Display all lines that contain the keyword under the cursor
" g~, gU, gu : toggle, upper, lower case (in visual selection)
" <Esc>4ic<Esc> : insert 4 repeating 'c's
"
" - in vimdiff mode
" ]c - Jump to the next change.
" [c - Jump to the previous change.
" :%diffget - do for all changes
" :diffthis - do this command for each already opened windows

"""""""""""""""""""""""""""""""""""""""""""""
" basic mappings

nnoremap <silent> <Space> :normal! za<CR>	|"Map toggle function to Space key. 
nnoremap <Leader><CR> O<Esc>				|"insert one line above cursor
call s:nnoreicmap('','<C-s>',':w<CR>')		|"save. works only when "stty -ixon" is defined in .bashrc
nnoremap <silent> <C-c> <C-c>:noh<CR>		|"<C-c> in normal model removes search highlighting.

"if !has('win32')
	"" excape hangul mode in normal mode
"python <<EOF
"import ibus
"import vim
"im_bus = ibus.Bus()
"im_ic = ibus.InputContext(im_bus, im_bus.current_input_contxt())
"def im_is_active():
	"if im_ic.is_enabled():
		"return 1
	"else:
		"return 0
"def im_escape():
	"vim.command('let g:imstatus = %d' % im_is_active())
	"im_ic.disable()
"def im_enable():
	"im_ic.enable()
"def im_disable():
	"im_ic.disable()
"EOF
	"if !has('gui_running')
		"let g:ibusinit = 0
		"let g:imstatus = 0

		"function! InitIBus()
			"if g:ibusinit
				"return
			"endif
			"let g:ibusinit = 1
		"endfunction

		"function! ImEscape()
			"py im_escape()
		"endfunction
		"function! ImEnter()
			"if g:imstatus
				"py im_enable()
			"endif
		"endfunction

		"autocmd VimEnter * call InitIBus()

		"inoremap <silent> <ESC> <ESC>:call ImEscape()<CR>
		"nnoremap <silent> i :call ImEnter()<CR>i
		"nnoremap <silent> I :call ImEnter()<CR>I
		"nnoremap <silent> o :call ImEnter()<CR>o
		"nnoremap <silent> O :call ImEnter()<CR>O
		"nnoremap <silent> a :call ImEnter()<CR>a
		"nnoremap <silent> A :call ImEnter()<CR>A
	"endif
"endif

" window resizing
nnoremap <A--> 4<C-w><
nnoremap <A-=> 4<C-w>>
nnoremap _ 4<C-w>-
nnoremap + 4<C-w>+

" select a word under cursor
noremap ; lbve

" select all
nnoremap <C-a> ggVG

" prevent replacement of copied text when pasted on visual block
" 'p' to paste, 'gv' to re-select what was originally selected. 'y' to copy it again.
xnoremap p pgvy

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Highlight matches without moving
"nnoremap <Tab> *``z.
"vmap <Tab> *``z.

"""""""""""""""""""""""""""""""""""""""""""""
" advanced mappings

" quickfix
call s:nnoreicmap('','<F2>',':call QuickfixFocusOrOpen()<CR>')
call s:nnoreicmap('','<S-F2>',':cclose<CR>')
call s:nnoreicmap('','<F8>',':VScnextc<CR>')
call s:nnoreicmap('','<S-F8>',':VScprevc<CR>')
call s:nnoreicmap('','<C-F8>',':call QuickfixFocusOrOpenError(1)<CR>')
call s:nnoreicmap('','<C-S-F8>',':call QuickfixFocusOrOpenError(0)<CR>')
call s:nnoreicmap('','<A-1>',':cold<CR>')
call s:nnoreicmap('','<A-2>',':cnew<CR>')

" first call : open quickfix, second call : jump to quickfix
function! QuickfixFocusOrOpen()
	let qfexist = JumpToWinByBuftype('quickfix')
	if qfexist==0
		call QuickfixCOpen()
	endif
endfunction

function! QuickfixCOpen()
	botright copen
	wincmd p
endfunction

" first call : open quickfix, second call : jump to quickfix and jump to the last error
function! QuickfixFocusOrOpenError(isNext)
	let qfexist = JumpToWinByBuftype('quickfix')
	if qfexist==0
		call QuickfixCOpen()
	endif
	execute "silent! cla"
	if a:isNext
		execute "silent! normal! /error\<CR>"
	else
		execute "silent! normal! ?error\<CR>"
	endif
endfunction

" Open Quickfix if there is error and jump to the last error
function! QuickfixCWindowError()
	botright cwindow
	execute "silent! cla"
	let qfexist = JumpToWinByBuftype('quickfix')
	if qfexist==1
		wincmd p
	endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""
" leader mappings

" copy selected whole lines and paste it just below
nnoremap <Leader>vv yyp
xnoremap <Leader>vv y'[V']y`]p

if has('win32')
	" open cmd
	nnoremap <Leader>tc :!start cmd<CR>	|" open in CWD
	nnoremap <expr> <Leader>tf ":!start cmd /K \"cd /d ".expand("%:p:h")."\"<CR>"	|" open in dir of current file
	nnoremap <expr> <Leader>tr ":!start cmd /K \"cd /d ".FindRepoDirFrom(expand("%:p:h"))."\"<CR>"	|" open in dir of current file

	" open explorer
	nnoremap <expr> <Leader>fc ":silent !explorer ".getcwd()."<CR><CR>"	|" open in CWD
	nnoremap <expr> <Leader>ff ":silent !explorer ".expand("%:p:h")."<CR><CR>"	|" open in dir of current file
	nnoremap <expr> <Leader>fr ":silent !explorer ".FindRepoDirFrom(expand("%:p:h"))."<CR><CR>"	|" open in dir of current file
else
	" open gnome terminal
	nnoremap <Leader>tc :!gnome-terminal<CR><CR>	|" open in CWD
	nnoremap <expr> <Leader>tf ":!gnome-terminal --working-directory=".expand("%:p:h")."<CR><CR>"	|" open in dir of current file
	nnoremap <expr> <Leader>tr ":!gnome-terminal --working-directory=".FindRepoDirFrom(expand("%:p:h"))."<CR><CR>"	|" open in dir of current file

	" open nautilus file explorer
	nnoremap <expr> <Leader>fc ":!nautilus ".getcwd()."<CR><CR>"	|" open in CWD
	nnoremap <expr> <Leader>ff ":!nautilus ".expand("%:p:h")."<CR><CR>"	|" open in dir of current file
	nnoremap <expr> <Leader>fr ":!nautilus ".FindRepoDirFrom(expand("%:p:h"))."<CR><CR>"	|" open in dir of current file
endif

let g:repodirs = ['.git', '.hg', '.svn']

function! FindRepoDirFrom(dir)
python << EOF
import vim
repodirs = vim.eval('g:repodirs')
firstdir = vim.eval('a:dir')
dir = firstdir
while True:
	exist = False
	for repodir in repodirs:
		if os.path.exists(os.path.join(dir, repodir)):
			vim.command('return \'%s\''%dir)
			exist = True
			break
	if exist:
	   break

	prevdir = dir
	dir = os.path.dirname(dir)
	if dir==prevdir:
		print 'no repo dir in ancestors of %s'%firstdir
		vim.command('return \'\'')
		break
EOF
endfunction

" open browser

" preview .md file (gfm format) with grip
" https://github.com/joeyespo/grip
" sudo apt-get install pip
" sudo pip install grip
nmap <Leader>bm :call OpenCurrentFileWithGrip()<CR><CR><CR>
function! OpenCurrentFileWithGrip()
	"execute "!gnome-terminal --command \"timeout 5s grip --gfm ".expand('%:p')."\""
	execute "!gnome-terminal --command \"timeout 5s grip ".expand('%:p')."\""
	execute "!sleep .5"
	execute "!/usr/bin/firefox \"localhost:5000\""
endfunction

" preview .md file with google chrome 'Markdown Preview Plus' extension from www.ooso.net. Check 'Allow access to file URLs' in Extension settings.
nmap <expr> <Leader>bc ":!/usr/bin/google-chrome ".expand('%:p')."\<CR>"

" spell check
nmap <expr> <Leader>sc ":!aspell --lang=en -c ".expand('%:p')."\<CR>"

"""""""""""""""""""""""""""""""""""""""""""""
" plugin mappings

if has('win32')
	let g:acp_behaviorPythonOmniLength = -1
endif

" twcmd.vim
let g:twcmd_focus_after_closing = 'prev_win_curr_tab'

let g:left_alt = 0
if g:left_alt
	" tab cursor moving and managing
	call s:nnoreicmap('','<A-H>',':TWcmd tcm h<CR>')
	call s:nnoreicmap('','<A-L>',':TWcmd tcm l<CR>')
	call s:nnoreicmap('','<A-P>',':TWcmd tcm p<CR>')
	call s:nnoreicmap('','<A-Q>',':TWcmd tcm q<CR>')
	call s:nnoreicmap('','<A-N>',':TWcmd tcm n<CR>')
	call s:nnoreicmap('','<A-Y>',':TWcmd tcm t<CR>')
	call s:nnoreicmap('','<A-)>',':TWcmd tcm b<CR>')

	" tab moving
	call s:nnoreicmap('','<A-J>',':TWcmd tmv h<CR>')
	call s:nnoreicmap('','<A-K>',':TWcmd tmv l<CR>')
	call s:nnoreicmap('','<A-U>',':TWcmd tmv t<CR>')
	call s:nnoreicmap('','<A-I>',':TWcmd tmv b<CR>')

	" window cursor moving and managing
	call s:nnoreicmap('','<A-h>',':TWcmd wcm h<CR>')
	call s:nnoreicmap('','<A-j>',':TWcmd wcm j<CR>')
	call s:nnoreicmap('','<A-k>',':TWcmd wcm k<CR>')
	call s:nnoreicmap('','<A-l>',':TWcmd wcm l<CR>')
	call s:nnoreicmap('','<A-p>',':TWcmd wcm p<CR>')
	call s:nnoreicmap('','<C-w>',':TWcmd wcm q<CR>')
	call s:nnoreicmap('','<A-n>',':TWcmd wcm n<CR>')
	call s:nnoreicmap('','<C-v>',':TWcmd wcm v<CR>')
	call s:nnoreicmap('','<A-m>',':TWcmd wcm m<CR>')

	" window moving
	call s:nnoreicmap('','<A-y>',':TWcmd wmv h<CR>')
	call s:nnoreicmap('','<A-o>',':TWcmd wmv l<CR>')

	" window moving between tabs
	call s:nnoreicmap('','<A-u>',':TWcmd wmvt h<CR>')
	call s:nnoreicmap('','<A-i>',':TWcmd wmvt l<CR>')
else
	" tab cursor moving and managing
	call s:nnoreicmap('','<A-S>',':TWcmd tcm h<CR>')
	call s:nnoreicmap('','<A-G>',':TWcmd tcm l<CR>')
	call s:nnoreicmap('','<A-Q>',':TWcmd tcm p<CR>')
	call s:nnoreicmap('','<A-C>',':TWcmd tcm q<CR>')
	call s:nnoreicmap('','<A-B>',':TWcmd tcm n<CR>')
	call s:nnoreicmap('','<A-W>',':TWcmd tcm t<CR>')
	call s:nnoreicmap('','<A-T>',':TWcmd tcm b<CR>')

	" tab moving
	call s:nnoreicmap('','<A-D>',':TWcmd tmv h<CR>')
	call s:nnoreicmap('','<A-F>',':TWcmd tmv l<CR>')
	call s:nnoreicmap('','<A-E>',':TWcmd tmv t<CR>')
	call s:nnoreicmap('','<A-R>',':TWcmd tmv b<CR>')

	" window cursor moving and managing
	call s:nnoreicmap('','<A-s>',':TWcmd wcm h<CR>')
	call s:nnoreicmap('','<A-f>',':TWcmd wcm j<CR>')
	call s:nnoreicmap('','<A-d>',':TWcmd wcm k<CR>')
	call s:nnoreicmap('','<A-g>',':TWcmd wcm l<CR>')
	call s:nnoreicmap('','<A-q>',':TWcmd wcm p<CR>')
	call s:nnoreicmap('','<A-c>',':TWcmd wcm q<CR>')
	call s:nnoreicmap('','<A-b>',':vnew<CR>')
	call s:nnoreicmap('','<A-v>',':TWcmd wcm v<CR>')
	call s:nnoreicmap('','<A-x>',':TWcmd wcm m<CR>')

	" window moving
	call s:nnoreicmap('','<A-w>',':TWcmd wmv h<CR>')
	call s:nnoreicmap('','<A-t>',':TWcmd wmv l<CR>')

	" window moving between tabs
	call s:nnoreicmap('','<A-e>',':TWcmd wmvt h<CR>')
	call s:nnoreicmap('','<A-r>',':TWcmd wmvt l<CR>')
endif

" CtrlP
" Disable default Alt+F10 : CCSM, go to Desktop -> Ubuntu Unity Plugin -> Behaviour to disable the 'open panel menu' key.
let ctrlp_keys = ['F10', 'F7']
let g:ctrlp_map = '<'.ctrlp_keys[0].'>'
for ctrlp_key in ctrlp_keys
	execute 'nmap <'.ctrlp_key.'> :CtrlP ./<CR>'
	execute 'nmap <C-'.ctrlp_key.'> :CtrlPMRU<CR>'
	execute 'nmap <expr> <A-'.ctrlp_key.'> ":CtrlP ./<CR>".expand("<cword>")'
	execute 'imap <'.ctrlp_key.'> <Esc><'.ctrlp_key.'>'
	execute 'imap <C-'.ctrlp_key.'> <Esc><C-'.ctrlp_key.'>'
	execute 'imap <A-'.ctrlp_key.'> <Esc><A-'.ctrlp_key.'>'
endfor

" NerdTree
if has('unix')
	let g:NERDTreeDirArrowCollapsible = '-'
	let g:NERDTreeDirArrowExpandable = '+'
endif
let NERDTreeShowBookmarks=1
call s:nnoreicmap('','<F3>',':call NERDTreeFocusOrOpen()<CR>')
call s:nnoreicmap('','<S-F3>',':NERDTreeClose<CR>')
call s:nnoreicmap('','<C-F3>',':NERDTreeFind<CR>')

function! NERDTreeFocusOrOpen()
	let ntexist = JumpToWinBySubname('NERD_tree')
	if ntexist==0
		call feedkeys(":NERDTree\<CR>")
	endif
endfunction

" Tagbar
call s:nnoreicmap('','<F4>',':TagbarOpen fj<CR>')
call s:nnoreicmap('','<S-F4>',':TagbarClose<CR>')

"" NerdCommenter
let NERDCreateDefaultMappings = 0		|"disable default mapping
let NERDCommentWholeLinesInVMode = 1	|"always comment whole line
map <Leader>c <plug>NERDCommenterComment
map <Leader>x <plug>NERDCommenterUncomment

nmap <Leader>vc yy<plug>NERDCommenterCommentp
xmap <Leader>vc y`[V`]ygv<plug>NERDCommenterCommentp

" autocwd.vim
"" test
"let g:patterncwd_patternwd_pairs = [
	"\['[quic*', '/home/yoonsang/Data/Research/'],
	"\['*Pattern*', '/home/yoonsang/Data/'],
	"\['*.vim', '%:p:h'],
	"\]
" real use 
let g:autocwd_patternwd_pairs = [
	\['*.py', '%:p:h'],
	\['*.bat', '%:p:h'],
	\['*.vim', '%:p:h'],
	\['*.tex', '%:p:h'],
	\['*/gallery-lite/*', '*REPO*'],
	\['*/DMLcpp/ExternalLibraries/VirtualPhysics/*', '*REPO*/DMLcpp/ExternalLibraries/VirtualPhysics/'],
	\['*/DMLcpp/ExternalLibraries/GEAR/*', '*REPO*/DMLcpp/ExternalLibraries/GEAR/'],
	\['*/DMLcpp/*/*_py.cpp', '*REPO*/DMLpy'],
	\['*/DMLcpp/*', '*REPO*/DMLcpp'],
	\['*/DMLpy/*', '*REPO*/DMLpy'],
	\['*dali*', '*REPO*'],
	\['*/dart/*', '*REPO*'],
	\]

" VIntSearch
if has('win32')
	set grepprg=grep\ -n
	let g:vintsearch_findcmd_path = 'C:\Program Files (x86)\UnxUtils\usr\local\wbin\find.exe'
endif
let g:vintsearch_enable_default_quickfix_enter = 0
call s:nnoreicmap('','<A-3>',':VIntSearchMoveBackward<CR>')
call s:nnoreicmap('','<A-4>',':VIntSearchMoveForward<CR>')

call s:nnoreicmap('','<A-]>',':VIntSearchCursor symbol n j<CR>')
nnoremap g] :VIntSearchCursor symbol n l<CR>
nnoremap g[ :VIntSearchCursor text n l<CR><CR>
nnoremap g{ :VIntSearchCursor cftext n l<CR><CR>
nnoremap g\ :VIntSearchCursor file n l<CR><CR>
vnoremap <A-]> :<C-u>VIntSearchCursor symbol v j<CR>
vnoremap g] :<C-u>VIntSearchCursor symbol v l<CR>
vnoremap g[ :<C-u>VIntSearchCursor text v l<CR><CR>
vnoremap g{ :<C-u>VIntSearchCursor cftext v l<CR><CR>
vnoremap g\ :<C-u>VIntSearchCursor file v l<CR><CR>

let g:vintsearch_includepatterns = 
		\ ['*.c','*.cpp','*.h','*.hpp','*.inl','*.py','*.lua','*.vim','*.js',
		\'*.md','*.txt','*.tex','*.sh',
		\'*.html','*.htm','*.doxy','*.doxy.in',
		\'*file.list','*configure.ac','*Makefile.am','*.spec']
"let g:vintsearch_includepatterns =
	"\ ['*.c','*.cpp','*.h','*.hpp','*.inl']
let g:vintsearch_excludepatterns =
	\ ['*automated-tests*','*release*','*optresult*', '*evalresult*', '*video*']

" QFEnter
let g:qfenter_cc_cmd = 'VScc ##'
"let g:qfenter_enable_autoquickfix = 0

" QFGrep - default mapping
"let g:QFG_Grep = '<leader>g'
"let g:QFG_GrepV = '<leader>v'
"let g:QFG_Restore = '<leader>r'

" fugitive
nnoremap <Leader>g :Gstatus<CR><C-w>K
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" vim-easy-align
let g:easy_align_delimiters = {
\  't': { 'pattern': '	',  'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\}
vmap A <Plug>(LiveEasyAlign)
vmap a <Plug>(EasyAlign)	|" Start interactive EasyAlign in visual mode

" vim-session
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'

" a.vim
nnoremap <Leader>a :A<CR>

" ConqueGdb
let g:ConqueGdb_Leader = '\'

"""""""""""""""""""""""""""""""""""""""""""""
" jump to window functions
"""""""""""""""""""""""""""""""""""""""""""""
" return 0 if the quickfix window exist, 0 otherwise
function! JumpToWinByBuftype(type)
	for i in range(1, winnr('$'))
		let bufnr = winbufnr(i)
		let buftype = getbufvar(bufnr, '&buftype')
		if buftype==#a:type
			execute i.'wincmd w'
			return 1
		endif
	endfor
	return 0
endfunction

function! JumpToWinBySubname(subname)
python << EOF
import vim
subname = vim.eval('a:subname')
exist = False
for i in range(len(vim.windows)):
	bufname = vim.windows[i].buffer.name
	#print bufname
	if bufname==None:
		continue
	elif subname in bufname:
		vim.command(str(i+1)+'wincmd w')
		exist = True
		break
vim.command('return 1' if exist else 'return 0')
EOF
endfunction
