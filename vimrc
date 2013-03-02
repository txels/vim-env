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
Bundle 'gmarik/vundle'

" -- original repos on github
Bundle 'thisivan/vim-bufexplorer'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
" Bundle 'Lokaltog/powerline'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'klen/python-mode'
Bundle 'tpope/vim-surround'
Bundle 'majutsushi/tagbar'
Bundle 'sjl/gundo.vim'
" Beautify JS, HTML and CSS
" Bundle 'michalliu/jsruntime.vim'
" Bundle 'michalliu/jsoncodecs.vim'
" Bundle 'michalliu/sourcebeautify.vim'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'vim-scripts/sonoma.vim'
" -- vim-scripts repos
" Bundle 'L9'

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
set clipboard+=unnamed
set colorcolumn=80              " Add a visible end-of-line column
set cpoptions+=$                " 'cw' etc put $ at end instead of deleting/replacing text
set cursorcolumn                " Show a highlighted column for cursor position
set cursorline                  " Show a highlighted row for cursor position
set directory=.,.backup,~/.backup,/tmp
set encoding=utf8
set expandtab                   " Tab key will always be expanded to spaces
set foldmethod=marker           " Fold on markers (as used in this VIMRC file)
set hidden                      " Hide buffers when abandoned, instead of unloading
set history=50                  " keep 50 lines of command line history
set incsearch                   " do incremental searching
set laststatus=2                " always put a status line, even if there is only one window
set noignorecase                " do not ignore case for search
set ruler                       " show the cursor position all the time
set scrolloff=4                 " minimal number of screen lines above and below cursor
set shiftround                  " > and < will round indent to multiple of shiftwidth
set shiftwidth=4                " Spaces to use for each step of autoindent
set showcmd                     " display incomplete commands on lower right corner
set smartcase                   " override ignorecase if pattern includes uppercase
set tabstop=4                   " Number of spaces a tab in the file counts for
set textwidth=0                 " when set to 0, do not auto-wrap lines
set wildmenu                    " Enhanced command-line completion with a menu
" set wildmode=longest:full       " Complete till longest common string

" Status line (when not using powerline):
" %f relative path name - %m modified flag
" %l line - %L total lines - %p percentage - %v virtual column
" %n buffer number - %b char under cursor - %B said char in hex
set statusline=%f\ %m\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

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

" File type (and syntax highlight) JSON files as javascript
autocmd BufNewFile,BufRead *.json set ft=javascript

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

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
" disabled as I could not get patched fonts to work
let g:Powerline_symbols = 'fancy'
"let g:Powerline_colorscheme = 'default'

" --- NERDTree-tabs
let g:nerdtree_tabs_open_on_console_startup = 1

" --- Python mode:
let g:pymode_folding = 0

" --- Gundo:
let g:gundo_right = 1

" --- Syntastic
let g:syntastic_auto_loc_list=1
autocmd BufNewFile,BufRead,BufEnter * SyntasticCheck

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

nnoremap <F7> :TagbarToggle<CR>
nnoremap <F8> :buffers<CR>:buffer<Space>
nnoremap <F9> :GundoToggle<CR>

"Buffers - explore/next/previous: Alt-F12, F12, Shift-F12.
nnoremap <silent> <M-F12> :BufExplorer<CR>
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>

" find tag
nmap FT :tag
" yank from cursor to end of line
nmap Y y$

"Switch between windows and maximize
set wmh=0
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <M-F11> <C-W>_

" Navigate quickfix list
nmap <C-Y> :cprevious<CR>
nmap <C-U> :cnext<CR>

" Navigate location list
nmap gy :lprevious<CR>
nmap gu :lnext<CR>

" Toggle line numbers
map <leader>n :set invnumber number?<CR>
" Paste toggle (,p)
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>
" Toggle NERDTree in all tabs
map <Leader>t <plug>NERDTreeTabsToggle<CR>
" remove trailing spaces from all lines
map <leader>w :%s/ *$//g<CR>
"}}}
"----------------------------------------------------------------------------
