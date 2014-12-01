" Vim color file based on 256-jungle
" Maintainer:    Carles Barrobes <carles@barrobes.com>

set background=dark
set t_Co=256
let g:colors_name="txels-dark"

let python_highlight_all = 1
let c_gnu = 1

hi ColorColumn    ctermfg=None     ctermbg=17       cterm=None
hi Comment        ctermfg=243      ctermbg=None     cterm=None
hi Constant       ctermfg=69       ctermbg=None     cterm=None
hi Cursor         ctermfg=253      ctermbg=57       cterm=None
hi CursorColumn   ctermfg=None     ctermbg=237      cterm=None
" hi CursorLine     ctermfg=None     ctermbg=235      cterm=None
hi CursorLine     term=bold        ctermbg=237      cterm=bold
hi DiffText       ctermfg=165      ctermbg=244      cterm=None
hi Directory      ctermfg=184      ctermbg=None     cterm=Bold
hi Error          ctermfg=None     ctermbg=196      cterm=Bold
hi ErrorMsg       ctermfg=160      ctermbg=245      cterm=None
hi FoldColumn     ctermfg=132      ctermbg=None     cterm=None
hi Folded         ctermfg=None     ctermbg=23       cterm=Bold
hi Identifier     ctermfg=142      ctermbg=None     cterm=Bold
hi Ignore         ctermfg=221      ctermbg=None     cterm=Bold
hi LineNr         ctermfg=233      ctermbg=238      cterm=None
hi NonText        ctermfg=105      ctermbg=None     cterm=Bold
hi Normal         ctermfg=252      ctermbg=232      cterm=None
hi Pmenu          ctermfg=62       ctermbg=233      cterm=None
hi PmenuSbar      ctermfg=247      ctermbg=233      cterm=Bold
hi PmenuSel       ctermfg=69       ctermbg=232      cterm=Bold
hi PmenuThumb     ctermfg=248      ctermbg=233      cterm=None
hi PreProc        ctermfg=243      ctermbg=None     cterm=Bold
hi Search         ctermfg=232      ctermbg=221      cterm=Bold
hi Special        ctermfg=172      ctermbg=None     cterm=Bold
hi SpecialKey     ctermfg=70       ctermbg=None     cterm=None
hi Statement      ctermfg=172      ctermbg=None     cterm=Bold
hi StatusLine     ctermfg=231      ctermbg=65       cterm=None
hi StatusLineNC   ctermfg=16       ctermbg=239      cterm=None
hi String         ctermfg=77       ctermbg=None     cterm=None
hi TabLine        ctermfg=251      ctermbg=239      cterm=None
hi TabLineFill    ctermfg=232      ctermbg=None
hi TabLineSel     ctermfg=233      ctermbg=69       cterm=None
hi Todo           ctermfg=162      ctermbg=None     cterm=Bold
hi Type           ctermfg=166      ctermbg=None     cterm=Bold
hi Underline      ctermfg=147      ctermbg=None     cterm=Italic
hi VertSplit      ctermfg=239      ctermbg=239      cterm=None
hi Visual         ctermfg=248      ctermbg=238      cterm=None
"vim: sw=4
