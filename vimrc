"----------------------------------------------------------------------------
" VIM configuration file
" Author: Carles Barrobés
"----------------------------------------------------------------------------

" Change mapleader
let mapleader=","

"----------------------------------------------------------------------------
" Vundle: {{{

set nocompatible              " be iMproved
filetype off                  " required!
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle required!
Plugin 'gmarik/vundle'

" -- original repos on github
Plugin 'thisivan/vim-bufexplorer'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
" Plugin 'Lokaltog/vim-powerline'
" Plugin 'Lokaltog/powerline'
Plugin 'bling/vim-airline'           " Improved status line
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'kien/ctrlp.vim'              " Search file name with Ctrl-P
Plugin 'Shougo/unite.vim'            " Search across multiple sources
Plugin 'scrooloose/nerdtree'         " Navigate files in a tree
Plugin 'scrooloose/syntastic'        " Syntax highlighting
Plugin 'scrooloose/nerdcommenter'    " Shortcuts to comment code in and out
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'klen/python-mode'
Plugin 'tpope/vim-surround'
Plugin 'majutsushi/tagbar'
Plugin 'sjl/gundo.vim'               " browse the undo history (F9)
Plugin 'mileszs/ack.vim'             " :Ack - grep replacement
" Work in web, with JS, HTML and CSS/LESS...
Plugin 'maksimr/vim-jsbeautify'
Plugin 'elzr/vim-json'
Plugin 'groenewege/vim-less'
" CSS color plugins seem nice but are very slow
Plugin 'ap/vim-css-color'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'othree/html5.vim'
" color schemes
Plugin 'altercation/vim-colors-solarized'
" Useful shortcuts for quick edit of HTML files
" Plugin 'mattn/zencoding-vim'
" -- vim-scripts repos
" Plugin 'L9'
" Other file types
Plugin 'gisraptor/vim-lilypond-integrator'

filetype plugin indent on     " Required by Vundle.
                              " Enables uploading plugin and indent files for filetypes

" Brief Vundle help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"}}}
"----------------------------------------------------------------------------
" Personalised settings: {{{

colorscheme txels-dark

set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set backup                      " keep a backup file
set backupdir=.backup,~/.backup,.,/tmp   " places where to save backup files, in given order
if $TMUX == ''
    set clipboard+=unnamed
endif
set colorcolumn=80              " Add a visible end-of-line column
set cpoptions+=$                " 'cw' etc put $ at end instead of deleting/replacing text
set cursorcolumn                " Show a highlighted column for cursor position
set cursorline                  " Show a highlighted row for cursor position
set directory=.,.backup,~/.backup,/tmp
set encoding=utf8
set expandtab                   " Tab key will always be expanded to spaces
"set foldmethod=marker           " Fold on markers (as used in this VIMRC file)
set foldlevel=99                " Maximum fold level means all folds will be open
set hidden                      " Hide buffers when abandoned, instead of unloading
set history=50                  " keep 50 lines of command line history
set incsearch                   " do incremental searching
set laststatus=2                " always put a status line, even if there is only one window
set number                      " always show line numbers
set ignorecase                  " ignore case for search
set ruler                       " show the cursor position all the time
set scrolloff=4                 " minimal number of screen lines above and below cursor
set shiftround                  " > and < will round indent to multiple of shiftwidth
set shiftwidth=4                " Spaces to use for each step of autoindent
set showcmd                     " display incomplete commands on lower right corner
set smartcase                   " override ignorecase if pattern includes uppercase
set tabstop=4                   " Number of spaces a tab in the file counts for
set termencoding=utf8
set textwidth=0                 " when set to 0, do not auto-wrap lines
set wildmenu                    " Enhanced command-line completion with a menu
set wildmode=longest:full       " Complete only till longest common string


" Status line (when not using powerline):
" %f relative path name - %m modified flag
" %l line - %L total lines - %p percentage - %v virtual column
" %n buffer number - %b char under cursor - %B said char in hex
" Commented out in favour of powerline
" set statusline=%f\ %m\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Set cursor color in gnome or xterm
if &term =~ "xterm\\|rxvt"
    " use an orange cursor in insert mode
    let &t_SI = "\<Esc>]12;orange\x7"
    " use a white cursor otherwise
    let &t_EI = "\<Esc>]12;white\x7"
    silent !echo -ne "\033]12;white\007"
    " reset cursor when vim exits (gnome-terminal)
    autocmd VimLeave * silent !echo -ne "\033]12;white\007"
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78
        autocmd FileType vim setlocal foldmethod=marker
        autocmd BufNewFile,BufReadPost *.md set filetype=markdown

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif
    augroup END
endif " has("autocmd")

"}}}
"----------------------------------------------------------------------------
" Plugins: specific configuration {{{

" --- Powerline
" newer version:  set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
" let g:Powerline_symbols = 'fancy'
"let g:Powerline_colorscheme = 'default'

" --- airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#branch#enabled = 0

" --- NERDTree and NERDTreeTabs
let NERDTreeIgnore=['\.pyc$', 'Session.vim', '\~$' ]
" let g:nerdtree_tabs_open_on_console_startup = 1
" show tree only if invoked with no file
autocmd VimEnter * if argc() == 0 | NERDTree | endif

" --- Python mode:
let g:pymode_folding = 1
let g:pymode_rope = 0

" --- Gundo:
let g:gundo_right = 1

" --- Syntastic
let g:syntastic_auto_loc_list = 0
autocmd BufNewFile,BufRead,BufEnter *.js SyntasticCheck

" --- ctrl-p and nerdtree
set wildignore+=*~,/static/*,*.pyc,/envs/*,/.venv/*
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|envs|\.venv|lib|node_modules|coverage|tools|data|htmlcov)$'


"}}}
"----------------------------------------------------------------------------
" Functions: {{{

"Buffer selection by matching pattern in buffer name
function! BufSel(pattern)
    let bufcount = bufnr("$")
    let currbufnr = 1
    let nummatches = 0
    let firstmatchingbufnr = 0
    while currbufnr <= bufcount
        if(bufexists(currbufnr))
            let currbufname = bufname(currbufnr)
            if(match(currbufname, a:pattern) > -1)
                echo currbufnr . ": ". bufname(currbufnr)
                let nummatches += 1
                let firstmatchingbufnr = currbufnr
            endif
        endif
        let currbufnr = currbufnr + 1
    endwhile
    if(nummatches == 1)
        execute ":buffer ". firstmatchingbufnr
    elseif(nummatches > 1)
        let desiredbufnr = input("Enter buffer number: ")
        if(strlen(desiredbufnr) != 0)
            execute ":buffer ". desiredbufnr
        endif
    else
        echo "No matching buffers"
    endif
endfunction

"}}}
"----------------------------------------------------------------------------
" Commands: {{{

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")
command! B :call BufSel(".")

" Write open file with sudo
command! Wsudo w !sudo dd of=%
"nmap <C-S-D> :Wsudo<CR><CR>l

" Format XML
command! Xformat %!xmllint --format -

" See the difference between the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

"}}}
"----------------------------------------------------------------------------
" Mappings: {{{

" no ex mode, use Q for quitting
nmap Q :q<CR>

nnoremap <F8> :buffers<CR>:buffer<Space>
nnoremap <silent> <S-F8> :BufExplorer<CR>
nnoremap <F9> :GundoToggle<CR>

"Buffers - explore/next/previous: Alt-F12, F12, Shift-F12.
nnoremap <silent> <F7> :bn<CR>
nnoremap <silent> <S-F7> :bp<CR>

" find tag
nmap TC :!ctags --languages=python -R<CR>
nmap TF :tag<Space>
" yank from cursor to end of line
nmap Y y$

" Beautify
nmap BJ :call JsBeautify()<CR>
nmap BH :call HtmlBeautify()<CR>

"Switch between windows and maximize
set wmh=0
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_

" Move current line(s) up or down
nmap <C-J> :m -2<CR>
nmap <C-K> :m +1<CR>

" Navigate quickfix list
nnoremap <C-Y> :cprevious<CR>
nnoremap <C-U> :cnext<CR>

" Navigate location list
nmap gy :lprevious<CR>
nmap gu :lnext<CR>

" Toggle line numbers
map <leader>n :set invnumber number?<CR>
" Paste toggle (,p)
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>
" Find file from open buffer in NERDTree
map <leader>f :NERDTreeFind<CR>
" Search word under cursor
nnoremap <Leader>s :Ack <C-r><C-w><CR>
" Toggle NERDTree in all tabs
map <leader>t <plug>NERDTreeTabsToggle<CR>
" remove trailing spaces from all lines (without search highlighting)
map <leader>w :%s/ *$//g<CR>:let @/ = ""<CR>
"}}}
"----------------------------------------------------------------------------
