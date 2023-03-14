setlocal spell

" Do not split words when wrapping
setlocal linebreak

" Append tex as the filetype, to enable snippets and vimtex fun
" https://germaniumhq.com/2019/02/06/2019-02-06-Vim-Ultimate-Editing:-Multiple-File-Types/
function! Mdtex()
    if &filetype =~ 'tex'
        let l:newType = substitute(&filetype, 'tex\.', '', '')
    else
        let l:newType =  'tex.' . &filetype
    endif

    execute 'set filetype=' . l:newType
endfunction
command Mdtex call Mdtex()
