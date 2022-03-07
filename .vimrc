"""""""""""""""""""""""""""""""""""""""""""""
" plugins 
"""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/AutoComplPop'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/CSApprox'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-reload'
Plug 'mhinz/vim-startify'
Plug 'sk1418/QFGrep'
Plug 'junegunn/vim-easy-align'
Plug 'plytophogy/vim-virtualenv'

" my modifications
"Plug 'tpope/vim-fugitive'
Plug 'yssl/vim-fugitive'
"Plug 'tpope/vim-dispatch'
Plug 'yssl/vim-dispatch'


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
Plug 'vim-scripts/molokai'
Plug 'vim-scripts/Wombat'
Plug 'vim-scripts/obsidian'
Plug 'vim-scripts/inkpot'
Plug 'vim-scripts/werks.vim'
Plug 'vim-scripts/xoria256.vim'
Plug 'vim-scripts/jellybeans.vim'
Plug 'vim-scripts/Zenburn'
Plug 'vim-scripts/Gummybears'
Plug 'vim-scripts/rdark'
Plug 'vim-scripts/neverland.vim--All-colorschemes-suck'
Plug 'vim-scripts/Sorcerer'
Plug 'vim-scripts/Lucius'
Plug 'vim-scripts/buttercream.vim'
Plug 'vim-scripts/Blueshift'
Plug 'NLKNguyen/papercolor-theme'
Plug 'fugalh/desert.vim'
Plug 'junegunn/seoul256.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'noahfrederick/vim-hemisu'

call plug#end()

" favorite
"colorscheme xoria256
"colorscheme obsidian
"colorscheme sorcerer
"colorscheme rdark
"colorscheme gummybears
"colorscheme lucius | LuciusBlack
colorscheme lucius | LuciusBlackLowContrast

" light background
"colorscheme buttercream
"colorscheme lucius | LuciusWhite
"colorscheme lucius | LuciusLight
"colorscheme solarized | set background=light
"colorscheme PaperColor | set background=light
"colorscheme hemisu | set background=light
"colorscheme blueshift

" high contrast
"colorscheme jellybeans
"colorscheme molokai
"colorscheme neverland
"colorscheme wombat
"colorscheme lucius | LuciusBlackHighContrast

" mid contrast
"colorscheme werks
"colorscheme desert
"colorscheme inkpot

" low contrast
"colorscheme seoul256
"colorscheme zenburn
"colorscheme lucius | LuciusDarkLowContrast
"colorscheme solarized | set background=dark

" cursor shape & color for xterm
" http://vim.wikia.com/wiki/Configuring_the_cursor
if &term =~ "xterm\\|rxvt"
	" insert mode cursor shape
	let &t_SI .= "\<Esc>[5 q"
	" other modes cursor shape
	let &t_EI .= "\<Esc>[2 q"
	" 1 or 0 -> blinking block
	" 2 -> solid block
	" 3 -> blinking underscore
	" 4 -> solid underscore
	" Recent versions of xterm (282 or above) also support
	" 5 -> blinking vertical bar
	" 6 -> solid vertical bar

	" cursor color
	if &background=="light"
	  silent !echo -ne "\033]12;grey39\007"
	else
	  silent !echo -ne "\033]12;grey62\007"
	endif
endif

"""""""""""""""""""""""""""""""""""""""""""""
" vim options - common
"""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

" Fixing Vim's Background Color Erase for 256-color tmux and GNU screen
" https://sunaku.github.io/vim-256color-bce.html
set t_ut=

" search, highlighting
syntax on    " syntax highlighting on
set hlsearch " switch on highlighting the last used search pattern
set incsearch  " do incremental searching
set ignorecase    " ignore case when search

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

" etc
set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set fdm=indent    " code folding using indentation
set noswapfile    " no swap file
let mapleader="," " change <leader> key

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

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

	" Without this line, following makeprg_post results in open a new buffer named "<ESC>:CWindowDisplayErrorReturnFocus<CR>" on Ubuntu.
	" Don't know why, but figured out sourcing .vimrc one time prevents such behavior.
	" let s:makeprg_post = ';\ echo\ \"ERROREND\ \";\ vim\ --servername\ '.v:servername.'\ --remote-send\ \\<ESC\\>:CWindowDisplayErrorReturnFocus\\<CR\\>'
	autocmd VimEnter * source $MYVIMRC
	autocmd VimEnter * :CSApprox	|" Rerun CSApprox because it does not work properly with the above line (sourcing .vimrc)

	" disable auto commenting with new line
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

	" all folds open when opening a file except NerdTree
	autocmd BufWinEnter * normal! zR
	autocmd FileType nerdtree setlocal foldlevel=99

	" enter key in normal mode
	autocmd BufEnter * if &modifiable==1| nnoremap <buffer> <CR> o<Esc>| endif

	" highlight current window cursor line
	" autocmd BufEnter,WinEnter * if getbufvar(bufnr('%'), '&buftype')!=#'quickfix' | set cursorline | endif
	autocmd BufEnter,WinEnter * set cursorline
	autocmd WinLeave * set nocursorline |"nocursorcolumn

	" reset cursor when vim exits
	autocmd VimLeave * silent !echo -ne "\033]112\007"

	" automatically resize split windows to be equal after vim window was resized
	autocmd VimResized * wincmd =

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
set errorformat+=ERROREND\ 

" default: blank,buffers,curdir,folds,help,options,tabpages,winsize
set sessionoptions=curdir,folds,help,tabpages,winpos,winsize

"""""""""""""""""""""""""""""""""""""""""""""
" python luancher command

" In general, assume vim is in a virtualenv (thus launches any versions of python just by 'python' command)
let s:python_launcher = 'python'
let s:dml3_python_launcher = '~/DATA/Code/Research/DML3/singularity-python-gui.sh'

let s:artimo_path = '~/DATA/Code/Research/artimo/'
let s:artimo_python_launcher = s:artimo_path.'singularity/artimo-python-exec-python.sh'

let s:artimo_pip_install_cmd = 'time\ CMAKE_BUILD_PARALLEL_LEVEL=16\ '.s:artimo_path.'singularity/artimo-python-exec.sh\ pip3\ install\ -e\ '.s:artimo_path.'code/python\ --user\ -v'
let s:artimo_pip_uninstall_cmd = 'time\ '.s:artimo_path.'singularity/artimo-python-exec.sh\ pip3\ uninstall\ -y\ -v\ artimo'.';rm\ -rf\ '.s:artimo_path.'code/python/build'

let s:artimo_test_cppfuncs_pip_install_cmd = 'time\ CMAKE_BUILD_PARALLEL_LEVEL=16\ '.s:artimo_path.'singularity/artimo-python-exec.sh\ pip3\ install\ -e\ '.s:artimo_path.'tests/python\ --user\ -v'
let s:artimo_test_cppfuncs_pip_uninstall_cmd = 'time\ '.s:artimo_path.'singularity/artimo-python-exec.sh\ pip3\ uninstall\ -y\ -v\ artimo_test_cppfuncs'.
												\';'.s:artimo_path.'singularity/artimo-python-exec.sh\ pip3\ uninstall\ -y\ -v\ artimo_test_cppfuncs_builtin_casters'.
												\';rm\ -rf\ '.s:artimo_path.'tests/python/build'

let s:artimo_all_pip_install_cmd = s:artimo_pip_install_cmd.';'.s:artimo_test_cppfuncs_pip_install_cmd
let s:artimo_all_pip_uninstall_cmd = s:artimo_pip_uninstall_cmd.';'.s:artimo_test_cppfuncs_pip_uninstall_cmd

" speicial cases without using a virtualenv
"let s:python_launcher = 'py\ -2'		|" python2 with py launcher on Windows
"let s:python_launcher = 'py\ -3'		|" python3 with py launcher on Windows
"let s:python_launcher = 'python3'		|" python3 on Ubuntu

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
	" unbuffered output should be done by each makeprg, because MS windows inherently does not have something like 'stdbuf'.
	" for example, use 'python -u' for a python script

	" temp file to write stdout of program
	let s:tempfile = tempname()
	"let s:tempfile = 'c:/Users/yoonsang/temp.txt'

	let s:makeprg_pre = 'start\ cmd\ /c\ \"('
	let s:makeprg_post = '\ &\ echo\ ERROREND)\ 2>&1\ \\|\ tee\ '.s:tempfile.'\ &\ gvim\ --servername\ '.v:servername.'\ --remote-send\ ^<ESC^>:FillQuickfixWithTempFile^<CR^>\"'

	" 'makeprg='.s:makeprg_pre.s:python_launcher.'\ -u\ %'.s:makeprg_post
	" ->
	" 'makeprg=start\ cmd\ /c\ \"(python\ -u\ %\ &\ echo\ ERROREND)\ 2>&1\ \\|\ tee\ '.s:tempfile.'\ &\ gvim\ --server-name\ '.v:servername.'\ --remote-send\ ^<ESC^>:FillQuickfixWithTempFile^<CR^>\"'
	" ->
	" start cmd /c "(python -u test.py & echo ERROREND) 2>&1 | tee temp.txt & gvim --servername GVIM --remote-send ^<ESC^>:FillQuickfixWithTempFile^<CR^>"

	func! s:FillQuickfixWithTempFile()
		exec 'cgetfile '.s:tempfile
		call delete(s:tempfile)
		call CWindowDisplayErrorReturnFocus()
	endfun

	command! FillQuickfixWithTempFile call s:FillQuickfixWithTempFile()

else
	"""""""""""""""""""""""""""""""""""""""""
	" linux version
	" : no delay, unbuffered screen output for any program
	let s:makeprg_pre = 'stdbuf\ -i0\ -o0\ '

	" use vim's server feature to call :CWindowDisplayErrorReturnFocus command to move focus to the previously focused window
	" you need to enable servername feature for non-GUI vim
	" refer http://vim.wikia.com/wiki/Enable_servername_capability_in_vim/xterm
	" sleep 100m is required otherwise CWindowDisplayErrorReturnFocus is executed before the make output is filled into quickfix, thus display the last error of PREVIOUS quickfix contents.
	let s:makeprg_post = ';\ echo\ \"ERROREND\ \";\ vim\ --servername\ '.v:servername.'\ --remote-send\ \\<ESC\\>:sleep\\\ 100m\\<CR\\>:CWindowDisplayErrorReturnFocus\\<CR\\>'

	" 'makeprg='.s:makeprg_pre.s:python_launcher.'\ -u\ %'.s:makeprg_post
	" ->
	" stdbuf -i0 -o0 python -u test.py; echo ERROREND ; vim --servername VIM --remote-send <ESC>::CWindowDisplayErrorReturnFocus<CR>

	"" a little inconvenient version - window focus will be still on the quickfix window when building is done.
	"let s:makeprg_post = ';\ echo\ \"ERROREND\ \"'

	" 'makeprg='.s:makeprg_pre.s:python_launcher.'\ -u\ %'.s:makeprg_post
	" ->
	" stdbuf -i0 -o0 python -u test.py; echo ERROREND 
endif

"""""""""""""""""""""""""""""""""""""""""""""
" local settings for file path

" build & run shortcut
" F9 : build only
" A-F9 : build & run 
" C-F9 : run only
" C-A-S-F9 : build all & run
" S-F9 : debugger run (conquegdb)
" F12 : toggle release/debug
" A-S-F12 : clean
" S-F12 : configure

let g:autosettings_settings = [
	\[['*.py','*.cpp','*.c','*.h','*.hpp','*.bat'],{
		\'setLocals':[
			\'expandtab',
			\'tw=0',
		\],
	\}],
	\[['*.tex','*.txt','*.md','*.html','*.htm'],{
		\'setLocals':[
			\'wrap',
		\],
	\}],
	\[['*.cpp','*.c','*.h','*.hpp'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:makeprg_pre.s:python_launcher.'\ -u\ make.py\ dbuild\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':setlocal makeprg='.s:makeprg_pre.s:python_launcher.'\ -u\ make.py\ dbuildrun\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':setlocal makeprg='.s:makeprg_pre.s:python_launcher.'\ -u\ make.py\ drun\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:makeprg_pre.s:python_launcher.'\ -u\ make.py\ dclean\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
		\],
	\}],
	\[['*.py','*.bat'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':silent Make<CR>']
		\],
	\}],
	\[['*.py'],{
		\'setLocals':[
			\'makeprg='.s:makeprg_pre.s:python_launcher.'\ -u\ %'.s:makeprg_post,
		\],
	\}],
	\[['*.bat'],{
		\'setLocals':[
			\'makeprg='.s:makeprg_pre.'%'.s:makeprg_post,
		\],
	\}],
	\[['*/DML3/*/*.py', '*/Code-ImprovingDDC/*.py', '*/Code-SimbiconRL/*.py'],{
		\'setLocals':[
			\'makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ %'.s:makeprg_post,
		\],
	\}],
	\[['*/DML3/DMLcpp/*'],{
		\'buildConfigNames':['release','debug'],
		\'buildConfigs':{
			\'release':{
				\'localMaps':[
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ make.py\ rbuild\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ make.py\ rbuildrun\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ make.py\ rrun\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ make.py\ rclean\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
				\],
			\},
			\'debug':{
				\'localMaps':[
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ make.py\ dbuild\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ make.py\ dbuildrun\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ make.py\ drun\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
					\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ make.py\ dclean\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
				\],
			\},
		\},
	\}],
	\[['*/DML3/DMLpy/setup.py','*/DML3/DMLcpp/setup.py','*/DML3/DMLcpp/*/*_py.cpp'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ setup.py\ build_ext'.s:makeprg_post.'<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ setup.py\ clean'.s:makeprg_post.'<CR>:silent Make<CR>'],
		\],
	\}],
	\[['*/DML3/*/dart*/*'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ make.py\ rbuild\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-F9>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ make.py\ rbuildrun\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ make.py\ rrun\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:makeprg_pre.s:dml3_python_launcher.'\ -u\ make.py\ rclean\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
		\],
	\}],
	\[['*/artimo/*'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-A-S-F9>', ':setlocal makeprg='.s:artimo_all_pip_install_cmd.s:makeprg_post.'<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-A-S-F12>', ':setlocal makeprg='.s:artimo_all_pip_uninstall_cmd.s:makeprg_post.'<CR>:silent Make<CR>'],
		\],
	\}],
	\[['*/artimo/code/*'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:artimo_pip_install_cmd.s:makeprg_post.'<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:artimo_pip_uninstall_cmd.s:makeprg_post.'<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':setlocal makeprg='.s:artimo_python_launcher.'\ -u\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
		\],
	\}],
	\[['*/artimo/tests/python/*'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:artimo_python_launcher.'\ -m\ pytest\ -v\ -s\ %'.s:makeprg_post.'<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<C-F9>', ':setlocal makeprg='.s:artimo_python_launcher.'\ -m\ pytest\ -v\ -s\ '.s:artimo_path.'/tests/python/'.s:makeprg_post.'<CR>:silent Make<CR>'],
		\],
	\}],
	\[['*/artimo/tests/python/*.cpp', '*/artimo/tests/python/*/CMakeLists.txt', '*/artimo/tests/python/setup.py'],{
		\'localMaps':[
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<F9>', ':setlocal makeprg='.s:artimo_test_cppfuncs_pip_install_cmd.s:makeprg_post.'<CR>:silent Make<CR>'],
			\[['nnoremap', 'inoremap', 'cnoremap', 'vnoremap'], '<A-S-F12>', ':setlocal makeprg='.s:artimo_test_cppfuncs_pip_uninstall_cmd.s:makeprg_post.'<CR>:silent Make<CR>'],
		\],
	\}],
\]

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
			\'tw=0',
			\'makeprg='.s:makeprg_pre.'latexmk\ -pdf\ -latexoption=\"-synctex=1\"\ index.tex'.s:makeprg_post,
		\],
	\}])
			"\'makeprg='.s:makeprg_pre.'latexmk\ -pdf\ -latexoption=\"-synctex=1\"\ %'.s:makeprg_post,

if has('win32')
	fun! OpenCurrentPDF()
		exec 'silent !start cmd /K "start '.fnamemodify(expand('%'), ":p:r").'.pdf && exit"'
	endfun
else
	fun! OpenCurrentPDF()
		"exec 'silent !gnome-open '.fnamemodify(expand('%'), ":p:r").'.pdf'
		"exec 'silent !evince '.fnamemodify(Tex_GetMainFileName(), ":p:r").'.pdf '.v:servername.' &'
		exec 'silent !evince '.fnamemodify(Tex_GetMainFileName(), ":p:r").'.pdf &'
	endfun

	fun! Tex_ForwardSearchLaTeX()
	let cmd = 'evince_forward_search ' . fnamemodify(Tex_GetMainFileName(), ":p:r") . '.pdf ' . line(".") . ' ' . expand("%:p")
	let output = system(cmd)
	endfun

	fun! Tex_GetMainFileName()
		"return expand('%')
		return expand('index.tex')
	endfun
endif


"""""""""""""""""""""""""""""""""""""""""""""
" key mappings
"""""""""""""""""""""""""""""""""""""""""""""

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
" useful advanced feature
"
" diff
" window
" tab
" quickfix
" grep
" shortcut
" plugin

"""""""""""""""""""""""""""""""""""""""""""""
" basic mappings

nnoremap <silent> <Space> :normal! za<CR>	|"Map toggle function to Space key. 
nnoremap <Leader><CR> O<Esc>				|"insert one line above cursor
call s:nnoreicmap('','<C-s>',':w<CR>')		|"save. works only when "stty -ixon" is defined in .bashrc
nnoremap <silent> <C-c> <C-c>:noh<CR>		|"<C-c> in normal model removes search highlighting.

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
" quickfix mappings

call s:nnoreicmap('','<F2>',':call COpenReturnFocusThenMoveFocus()<CR>')
call s:nnoreicmap('','<S-F2>',':cclose<CR>')
call s:nnoreicmap('','<F8>',':VScnextc<CR>')
call s:nnoreicmap('','<S-F8>',':VScprevc<CR>')
call s:nnoreicmap('','<C-F8>',':call COpenFindErrorString(1)<CR>')
call s:nnoreicmap('','<C-S-F8>',':call COpenFindErrorString(0)<CR>')
call s:nnoreicmap('','<A-1>',':cold<CR>')
call s:nnoreicmap('','<A-2>',':cnew<CR>')

func! COpenReturnFocus()
	botright copen
	wincmd p
endfunc

" first call : just open quickfix
" second call : jump to quickfix
func! COpenReturnFocusThenMoveFocus()
	let qfwinnr = GetWinNrByBuftype('quickfix')
	if qfwinnr==-1
		call COpenReturnFocus()
	else
		exec qfwinnr.'wincmd w'
	endif
endfunc

" first call : just open quickfix
" second call : jump to quickfix and display the last error
" third call : find next/prev 'error' string
func! COpenFindErrorString(isNext)
	let qfwinnr = GetWinNrByBuftype('quickfix')
	if qfwinnr==-1
		call COpenReturnFocus()
	else
		if winnr()!=qfwinnr
			execute "silent! cla"
			exec qfwinnr.'wincmd w'
		else
			if a:isNext
				execute "silent! normal! /error\<CR>"
			else
				execute "silent! normal! ?error\<CR>"
			endif
		endif
	endif
endfunc

" Open Quickfix and display the last error if exists (and the editing window has the focus)
" If there is no error, Quickfix window is not opened and the editing window still has the focus.
func! CWindowDisplayErrorReturnFocus()
	botright cwindow
	execute "silent! cla"
	let qfwinnr = GetWinNrByBuftype('quickfix')
	if qfwinnr!=-1
		exec qfwinnr.'wincmd w'
		wincmd p
	endif
endfunc

command! CWindowDisplayErrorReturnFocus call CWindowDisplayErrorReturnFocus()

func! GetWinNrByBuftype(type)
	for i in range(1, winnr('$'))
		let bufnr = winbufnr(i)
		let buftype = getbufvar(bufnr, '&buftype')
		if buftype==#a:type
			return i
		endif
	endfor
	return -1
endfunc

func! GetWinNrByBufSubname(subname)
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
		vim.command('return %d'%(i+1))
		exist = True
		break
if not exist:
	vim.command('return -1')
EOF
endfunc

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
nmap <expr> <Leader>sc ":call ToggleSpellChecker()<CR>"
fun! ToggleSpellChecker()
	if &spell
		exec "set nospell"
	else
		exec "set spell spelllang=en_us"
	endif
endfun

" refresh all files in buffer (:bufdo e) without prompt 'Load(Y/N)'
nmap <Leader>be :call RefreshAllBuffers()<CR><CR><CR>
fun! RefreshAllBuffers()
  set noconfirm
  bufdo e
  set confirm
endfun

"""""""""""""""""""""""""""""""""""""""""""""
" plugin mappings

" vim-autocomplpop
if has('win32')
	let g:acp_behaviorPythonOmniLength = -1
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" twcmd.vim

" test for g:twcmd_focus_after_closing
"let g:twcmd_focus_after_closing = 'prev_win_curr_tab'
"let g:twcmd_focus_after_closing = 'none'

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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
call s:nnoreicmap('','<F3>',':NERDTree<CR>')
call s:nnoreicmap('','<S-F3>',':NERDTreeClose<CR>')
call s:nnoreicmap('','<C-F3>',':NERDTreeFind<CR>')

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
	\['*/DML2/DMLcpp/*/*_py.cpp', '*REPO*/DMLpy'],
	\['*/DML3/DMLcpp/*/*_py.cpp', '*REPO*/DMLcpp'],
	\['*/DMLcpp/*', '*REPO*/DMLcpp'],
	\['*/DMLpy/*', '*REPO*/DMLpy'],
	\['*dali*', '*REPO*'],
	\['*/dart*/*', '*REPO*'],
	\['*.cpp', '%:p:h*'],
	\['*.c', '%:p:h*'],
	\['*.hpp', '%:p:h*'],
	\['*.h', '%:p:h*'],
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
		\ ['*.c','*.cpp','*.h','*.hpp','*.inl','*.py','*.lua','*.vim','*.js','*.css','*.scss',
		\'*.md','*.txt','*.tex','*.sh',
		\'*.html','*.htm','*.doxy','*.doxy.in',
		\'*file.list','*configure.ac','*Makefile.am','*.spec']
"let g:vintsearch_includepatterns =
	"\ ['*.c','*.cpp','*.h','*.hpp','*.inl']
let g:vintsearch_excludepatterns =
	\ ['*automated-tests*','*release*','*optresult*', '*evalresult*', '*video*', '*test-assignments*', 
	\  '*CMakeFiles*', '*output*', '*build*', '*egg-info*', '*sandbox*']

"""""""""""""""""""""""""""""
" QFEnter
let g:qfenter_cc_cmd = 'VScc ##'
let g:qfenter_exclude_filetypes = ['nerdtree', 'tagbar']

"" test for g:qfenter_prevtabwin_policy
"let g:qfenter_prevtabwin_policy = 'qf'
"let g:qfenter_prevtabwin_policy = 'none'
"let g:qfenter_prevtabwin_policy = 'legacy'
"let g:qfenter_prevtabwin_policy = 'test'

"" test for g:qfenter_enable_autoquickfix
"let g:qfenter_enable_autoquickfix = 0

"" test for switchbuf option
"set switchbuf=useopen,usetab
"set switchbuf=

"" test for g:qfenter_custom_map_list
"let g:qfenter_custom_map_list = []
"call add(g:qfenter_custom_map_list, {
			"\'tabwinfunc': 'QFEnter#GetTabWinNR_Open',
			"\'qfopencmd': 'cn',
			"\'keepfocus': 1,
			"\'keys': ['<Leader>n'],
			"\})
"call add(g:qfenter_custom_map_list, {
			"\'tabwinfunc': 'TestTab1Win1_Open',
			"\'qfopencmd': 'cc',
			"\'keepfocus': 0,
			"\'keys': ['<Leader>t'],
			"\})
"func! TestTab1Win1_Open()
	"return [1, 1, 0, '']
"endfunc
"""""""""""""""""""""""""""""

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

" vim-startify
let g:startify_session_persistence = 1
let g:startify_lists = [
	  \ { 'type': 'sessions',  'header': ['   Sessions']       },
	  \ { 'type': 'files',     'header': ['   MRU']            },
	  \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
	  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
	  \ { 'type': 'commands',  'header': ['   Commands']       },
	  \ ]
if has('win32')
	let g:startify_session_dir = '~/DATA/ResearchEnv-Sync/VimSessions-win'
else
	let g:startify_session_dir = '~/DATA/ResearchEnv-Sync/VimSessions-ubt'
endif

" a.vim
nnoremap <Leader>a :A<CR>

" ConqueGdb
let g:ConqueGdb_Leader = '\'

" vim-virtualenv
if has('win32')
	let g:virtualenv_directory = 'C:\Users\yoonsang\Envs'
endif
