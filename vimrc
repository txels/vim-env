" VIM configuration file
" Author: Carles Barrobés

" Vundle:
"
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on     " required!

"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"

" Powerline

" newer version:  set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'

"----------------------------------------------------------------------------
" Default VIMRC options: Bram Moolenaar <Bram@vim.org>
" Last change:  2008 Dec 17

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
    set nobackup    " do not keep a backup file, use versions instead
else
    set backup      " keep a backup file
endif
set history=50      " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

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
" Derek Wyatt's settings

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions+=$

" Set the status line
set stl=%f\ %m\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

"----------------------------------------------------------------------------
" Personalised by CBA

colorscheme txels-dark

set backspace=indent,eol,start
set backupdir=.backup,~/.backup,.,/tmp
set clipboard+=unnamed
set colorcolumn=80
set commentstring=\ #\ %s
set cursorcolumn
set cursorline
set directory=.,~/.backup,/tmp
set encoding=utf8
set expandtab
set foldlevel=0
set hidden
set noignorecase
"set paste
set scrolloff=2
set shiftwidth=4
set softtabstop=4
set tabstop=4
"set textwidth=0
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


" Taglist variables
" Display function name in status bar:
let g:ctags_statusline = 1
" Automatically start script
let generate_tags = 1
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window = 0
" Shorter commands to toggle Taglist display
nnoremap TT :TlistToggle<CR>
map <F4> :TlistToggle<CR>
map <F5> :TlistUpdate<CR>
" Various Taglist diplay config:
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1

" py diction (python dictionary for keyword completion)
let g:pydiction_location='/home/carles/dev/linux-env/vim/pydict/complete-dict'
"set dict=/home/carles/dev/linux-env/vim/pydict/complete-dict

" personal keyboard mappings and commands
" remove trailing spaces from all lines
map <C-S-M> :%s/ *$//g<CR>
" Write open file with sudo
command Wsudo w !sudo dd of=%
"nmap <C-S-D> :Wsudo<CR><CR>l
" Format XML
command Xformat %!xmllint --format -

" Syntax highlight JSON files
autocmd BufNewFile,BufRead *.json set ft=javascript


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

"Switch between windows and maximize
set wmh=0
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <M-F11> <C-W>_
"-----------------------------------------------------------
