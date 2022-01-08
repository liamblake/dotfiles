" Enable spellchecking
setlocal spell

setlocal textwidth=0
setlocal wrap

" Tab settings
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" Do not split words when wrapping
setlocal linebreak

" Toggle table of contents
nnoremap <localleader>sc <cmd>VimtexTocToggle<CR>

" Toggle preview
nnoremap <localleader>sp <cmd>VimtexView<CR>
