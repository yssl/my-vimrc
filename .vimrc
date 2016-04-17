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
Plug 'TeX-PDF'
Plug 'a.vim'
"Plug 'CSApprox'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-reload'
Plug 'sk1418/QFGrep'
Plug 'junegunn/vim-easy-align'
Plug 'yssl/vim-fugitive'
"Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
"Plug 'xolox/vim-session'
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
"colorscheme xoria256
colorscheme mustang
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
" vim options
"""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on

source $VIMRUNTIME/vimrc_example.vim
" The % key will switch between opening and closing brackets. By sourcing matchit.vim, the key can also switch among e.g. if/elsif/else/end, between opening and closing XML tags, and more. 
runtime macros/matchit.vim

set fileencodings=utf-8

let g:vimwiki_file_exts='pdf,chm'

"guioptions
set guioptions-=T	|"remove toolbar
set guioptions-=m	|"remove menubar
set guioptions-=l	|"left scrollbar always
set guioptions-=L	|"left scrollbar
set guioptions-=r	|"right scrollbar always
set guioptions-=R	|"right scrollbar
set guioptions-=h	|"bottom scrollsbar

set t_Co=256

" font
if has('win32')
	set guifont=Consolas:h12
else
	set guifont=Monospace\ 12
endif

" search option
set ignorecase

" swap, backup files - no swap, tmp backup
set noswapfile
if has('win32')
	set backupdir=c:\\temp
else
	set backupdir=/tmp
endif

" clipboard - use system clipboard
if has('win32')
	set clipboard=unnamed
else
	set clipboard=unnamedplus
endif

" ctags - search 'tag' file from current directory to root directory
" recursively (; is the key)
set tags=./tags;,tags;
set notagbsearch

" code folding using indentation
set fdm=indent

" change <leader> key
let mapleader=","

"""""""""""""""""""""""""""""""""""""""""""""
" common functions
"""""""""""""""""""""""""""""""""""""""""""""
fun! s:nnoreicmap(option, shortcut, command)
	exec 'nnoremap '.a:option.' '.a:shortcut.' '.a:command
	exec 'imap '.a:option.' '.a:shortcut.' <Esc>'.a:shortcut
	exec 'cmap '.a:option.' '.a:shortcut.' <Esc>'.a:shortcut
endfun

fun! StartDebugger()
	let token = split(system('make '.g:build_char.'printbin'), '\n')
	echo token
	if len(token) > 1
		let binpath = token[1]
		exec ':ConqueGdb '.binpath
	endif
endfun

let g:release_build=0
let g:build_char='d'
fun! PrintBuildMode()
	if g:release_build
		echom 'Build mode: Release'
	else
		echom 'Build mode: Debug'
	endif
endfun
fun! ToggleBuildMode()
	let g:release_build=!g:release_build
	if g:release_build
		let g:build_char='r'
	else
		let g:build_char='d'
	endif
	exec ':e'
	call PrintBuildMode()
endfun
call s:nnoreicmap('', '<F12>', ':call ToggleBuildMode()<CR>')
call s:nnoreicmap('', '<C-F12>', ':call PrintBuildMode()<CR>')

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

" build & run shortcut
" F9 : build & run
" C-S-A-F9 : build all & run
" C-F9 : run
" A-F9 : build only
" S-F9 : debugger run (conquegdb)
" F12 : toggle release/debug
" A-S-F12 : clean
" S-F12 : configure

"""""""""""""""""""""""""""""""""""""""""""""
" default settings for each laguange

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

	"let s:makeprg_pre = 'start\ cmd\ /c\ \"('
	"let s:makeprg_post = '\ &\ echo\ ERROREND)\ 2>&1\ \\|\ tee\ '.s:tempfile.'\ &\ gvim\ --server-name\ '.v:servername.'\ "--remote-send\ :FillQuickfixWithTempFile^<CR^>\"'
	
	" for hangul
	let s:makeprg_pre = 'start\ cmd\ /k\ \"('
	let s:makeprg_post = '\ &\ echo\ ERROREND)\ 2>&1\"'
	
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

let g:autosettings_settings = [
	\[['*.cpp','*.c','*.h','*.hpp'],{
		\'setLocals':[
			\'expandtab',
		\],
	\}],
	\[['*.py'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':w<CR>:silent Make<CR>']
		\],
		\'setLocals':[
			\'expandtab',
			\'makeprg='.s:makeprg_pre.'python\ -u\ %'.s:makeprg_post,
		\],
	\}],
	\[['*.tex'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':w<CR>:BuildAndViewTexPdf<CR>:call QuickfixCWindowError()<CR><C-l><C-l>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':w<CR>:BuildTexPdf<CR>:call QuickfixCWindowError()<CR><C-l>'],
			\[['nnoremap'], '<Leader>fs', ':call Tex_ForwardSearchLaTeX()<CR>'],
		\],
		\'setLocals':[
			\'wrap',
			\'expandtab',
			\'makeprg=stdbuf\ -i0\ -o0\ -e0\ python\ %',
		\],
	\}],
	\[['*.txt','*.md','*.html','*.htm'],{
		\'setLocals':[
			\'wrap',
		\],
	\}],
	\[['*/DMLcpp/*'],{
		\'setLocals':[
			\'makeprg=stdbuf\ -i0\ -o0\ -e0\ python\ make.py\ %',
		\],
		\'buildConfigNames':['release','debug'],
		\'buildConfigs':{
			\'release':{
				\'localMaps':[
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':Make rbuildrun; echo \"END:0::\"<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':Make rbuild; echo \"END:0::\"<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':Make rrun; echo \"END:0::\"<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':Make clean; echo \"END:0::\"<CR>'],
				\],
				\'localMapsExpr':[
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<S-F9>', "':ConqueGdb '.split(system('make rprintbin'),'\n')[1].'<CR>'"],
				\],
			\},
			\'debug':{
				\'localMaps':[
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':Make dbuildrun; echo \"END:0::\"<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':Make dbuild; echo \"END:0::\"<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':Make drun; echo \"END:0::\"<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':Make clean; echo \"END:0::\"<CR>'],
				\],
				\'localMapsExpr':[
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<S-F9>', "':ConqueGdb '.split(system('make dprintbin'),'\n')[1].'<CR>'"],
				\],
			\},
		\},
	\}],
\]


" F9 : build & run
" C-S-A-F9 : build all & run
" A-F9 : build only
" C-F9 : run
" S-F9 : debugger run (conquegdb)
" F12 : toggle release/debug
" A-S-F12 : clean
" S-F12 : configure

"let g:autosettings_for_build = [
	"\[['*/DMLcpp/*'],{
		"\'configNames':['release','debug'],
		"\'defaultConfigName':'release',
		"\'configs':{
			"\'release':{
				"\'localMaps':[
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':Make rbuildrun; echo "END:0::"<CR>'],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':Make rbuild; echo "END:0::"<CR>'],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':Make rrun; echo "END:0::"<CR>'],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':Make clean; echo "END:0::"<CR>'],
				"\],
				"\'localMapsExpr':[
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<S-F9>', "':ConqueGdb '.split(system('make rprintbin'),'\n')[1].'<CR>'"],
				"\],
			"\},
			"\'debug':{
				"\'localMaps':[
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':Make dbuildrun; echo "END:0::"<CR>'],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':Make dbuild; echo "END:0::"<CR>'],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':Make drun; echo "END:0::"<CR>'],
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':Make clean; echo "END:0::"<CR>'],
				"\],
				"\'localMapsExpr':[
					"\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<S-F9>', "':ConqueGdb '.split(system('make dprintbin'),'\n')[1].'<CR>'"],
				"\],
			"\},
		"\},
	"\}],
"\]

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

	"autocmd BufEnter *.tex exec 'nnoremap <buffer> <expr> <Leader>sc ":!aspell --lang=en --mode=tex -c ".expand("%:p")."\<CR>"'

	"" build & run shortcut
	"autocmd BufEnter *.cpp\|.c\|.h\|.hpp exec "call s:nnoreicmap('<buffer>','<F9>',':Make ".g:build_char."buildrun; echo \"END:0::\"<CR>')"
	"autocmd BufEnter *.cpp\|.c\|.h\|.hpp exec "call s:nnoreicmap('<buffer>','<C-F9>',':Make ".g:build_char."run; echo \"END:0::\"<CR>')"
	"autocmd BufEnter *.cpp\|.c\|.h\|.hpp exec "call s:nnoreicmap('<buffer>','<A-F9>',':Make ".g:build_char."build; echo \"END:0::\"<CR>')"
	"autocmd BufEnter *.cpp\|.c\|.h\|.hpp exec "call s:nnoreicmap('<buffer>','<S-F9>',':call StartDebugger()<CR>')"

function! Tex_ForwardSearchLaTeX()
let cmd = 'evince_forward_search ' . fnamemodify(Tex_GetMainFileName(), ":p:r") . '.pdf ' . line(".") . ' ' . expand("%:p")
let output = system(cmd)
endfunction

function! Tex_GetMainFileName()
	return expand('%')
endfunction

"""""""""""""""""""""""""""""""""""""""""""""
" key mappings
"""""""""""""""""""""""""""""""""""""""""""""

if !has('gui_running')
	" to recognize alt key in gnome terminal
	" http://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim
	function! RegisterAltMaps(start_ascii, end_ascii)
		let n=a:start_ascii
		while n <= a:end_ascii
		  let c = nr2char(n)
		  if c==#'"'
			  let c = '\'.c
		  elseif c==#'>' || c==#'|'
			  let n = n+1
			  continue
		  endif
		  exec "set <A-".c.">=\e".c
		  exec "imap \e".c." <A-".c.">"
		  let n = n+1
		endw
	endfunction
	"call RegisterAltMaps(48, 57)	|"0 to 9
	call RegisterAltMaps(92, 93)	|"\,]
	call RegisterAltMaps(45, 61)	|"-,=
	call RegisterAltMaps(40, 41)	|"(,)
	"call RegisterAltMaps(97, 122)	|"a to z - now vim-fixkey do this.
	set timeout ttimeoutlen=50
endif

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
call s:nnoreicmap('','<F8>',':VScnext<CR>')
call s:nnoreicmap('','<S-F8>',':VScprev<CR>')
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
else
	" open gnome terminal
	nnoremap <Leader>tc :!gnome-terminal<CR><CR>	|" open in CWD
	nnoremap <expr> <Leader>tf ":!gnome-terminal --working-directory=".expand("%:p:h")."<CR><CR>"	|" open in dir of current file
	nnoremap <expr> <Leader>tr ":!gnome-terminal --working-directory=".FindRepoDirFrom(expand("%:p:h"))."<CR><CR>"	|" open in dir of current file
endif

" open nautilus file explorer
nnoremap <expr> <Leader>fc ":!nautilus ".getcwd()."<CR><CR>"	|" open in CWD
nnoremap <expr> <Leader>ff ":!nautilus ".expand("%:p:h")."<CR><CR>"	|" open in dir of current file
nnoremap <expr> <Leader>fr ":!nautilus ".FindRepoDirFrom(expand("%:p:h"))."<CR><CR>"	|" open in dir of current file

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
" Disable default Alt+F10 : CCSM, go to Desktop -> Ubuntu Unity Plugin -> Behaviour to disable the “open panel menu” key.
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
	\['*.vim', '%:p:h'],
	\['*.tex', '%:p:h'],
	\['*/gallery-lite/*', '*REPO*'],
	\['*/DMLcpp/*', '*REPO*/DMLcpp'],
	\['*/DMLpy/*', '*REPO*/DMLpy'],
	\]

" VIntSearch
let g:vintsearch_enable_default_quickfix_enter = 0
call s:nnoreicmap('','<A-3>',':VIntSearchMoveBackward<CR>')
call s:nnoreicmap('','<A-4>',':VIntSearchMoveForward<CR>')

call s:nnoreicmap('','<A-]>',':VIntSearchCursor symbol n j<CR>')
nnoremap g] :<C-u>VIntSearchCursor symbol n l<CR>
nnoremap g[ :<C-u>VIntSearchCursor text n l<CR><CR>
nnoremap g{ :<C-u>VIntSearchCursor cftext n l<CR><CR>
nnoremap g\ :<C-u>VIntSearchCursor file n l<CR><CR>
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
"let g:vintsearch_excludepatterns =
	"\ ['*automated-tests*','*CMakeFiles*']

" QFEnter
let g:qfenter_cc_cmd = 'VScc ##'
let g:qfenter_cn_cmd = 'VScnext'
let g:qfenter_cp_cmd = 'VScprev'
let g:qfenter_cnext_map = ['<F8>']
let g:qfenter_cprev_map = ['<S-F8>']
"let g:qfenter_keep_quickfixfocus = {
			"\'open':0,
			"\'cnext':1,
			"\'cprev':1,
			"\}
"let g:qfenter_enable_autoquickfix = 0

" QFGrep
"let g:QFG_Grep = '<leader>g'
"let g:QFG_GrepV = '<leader>i'
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
