" Enable spellchecking
setlocal spell

setlocal textwidth=0
setlocal wrap

" Tab settings
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" Start continuous compiler
:VimtexCompile<CR>

" Overwrite SymbolOutline key with Vimtex table of contents
nnoremap <C-x> :VimtexToc<CR>
