" Enable spellchecking
setlocal spell

setlocal textwidth=0
setlocal wrap

" Tab settings
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" Toggle table of contents
nnoremap <localleader>sc <cmd>VimtexTocToggle<CR>

" Lines are often folded, so move the cursor by display lines when using hjkl
onoremap <silent> j gj
onoremap <silent> k gk
