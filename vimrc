" VIM configuration file
" Author: Carles Barrobés

"----------------------------------------------------------------------------
" Vundle:

set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
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
" -- vim-scripts repos
Bundle 'L9'

filetype plugin indent on     " required!

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"----------------------------------------------------------------------------

" Powerline
" newer version:  set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
" disabled as I could not get patched fonts to work
let g:Powerline_symbols = 'fancy'

"----------------------------------------------------------------------------

if has("vms")
    set nobackup    " do not keep a backup file, use versions instead
else
    set backup      " keep a backup file
endif


" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

"----------------------------------------------------------------------------

colorscheme txels-dark

" Make 'cw' and like put $ at the end instead of just deleting/replacing text
set cpoptions+=$

" Set the status line (if not using powerline)
set stl=%f\ %m\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]


set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set backupdir=.backup,~/.backup,.,/tmp
set clipboard+=unnamed
set colorcolumn=80              " Add a visible end-of-line column
set commentstring=\ #\ %s
set cursorcolumn                " Show a highlighted column for cursor position
set cursorline                  " Show a highlighted row for cursor position
set directory=.,~/.backup,/tmp
set encoding=utf8
set expandtab                   " Tab key will always be expanded to spaces
set hidden                      " Hide buffers when abandoned, instead of unloading
set history=50                  " keep 50 lines of command line history
set incsearch                   " do incremental searching
set laststatus=2                " always put a status line, even if there is only one window
set noignorecase
set ruler                       " show the cursor position all the time
set scrolloff=2
set shiftwidth=4
set showcmd                     " display incomplete commands
set softtabstop=4
set tabstop=4
set textwidth=0
set wildmenu

" Copy and paste to system clipboard in Ubuntu - not needed if +clipboard
" which is the default for vim-gnome
"vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

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


" Syntax highlight JSON files
autocmd BufNewFile,BufRead *.json set ft=javascript

" NERDTree-tabs
map <Leader>n <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup = 1


"-----------------------------------------------------------
" Python mode:
let g:pymode_folding = 0

"-----------------------------------------------------------
" BUFFERS

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

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")
command! B :call BufSel(".")

nnoremap <F8> :buffers<CR>:buffer<Space>

"Buffers - explore/next/previous: Alt-F12, F12, Shift-F12.
nnoremap <silent> <M-F12> :BufExplorer<CR>
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>

" personal keyboard mappings and commands
" remove trailing spaces from all lines
map <C-S-M> :%s/ *$//g<CR>
" find tag
nmap FT :tag

" tagbar
nmap <F7> :TagbarToggle<CR>

" Write open file with sudo
command Wsudo w !sudo dd of=%
"nmap <C-S-D> :Wsudo<CR><CR>l
" Format XML
command Xformat %!xmllint --format -

"Switch between windows and maximize
set wmh=0
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <M-F11> <C-W>_

" Navigate quickfix list
nmap <C-Y> :cn<CR>
nmap <C-U> :cprev<CR>
