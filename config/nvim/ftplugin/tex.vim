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

" Determine the appropriate action when pressing ctrl+enter based on the environment.
" e.g. in an itemize environment, start a new line with \item
"      in an align environment, end the current line with \\
function! AutoItem()
    let env_name = vimtex#env#get_inner()["name"]
    if match(env_name, '\(itemize\|enumerate\|description\|alpharate\|romanate\)') != -1
        return "\<CR>\\item "
    elseif match(env_name, '\(align\|align*\|bmatrix\|pmatrix|tabular\)') != -1
	return "\\\\\<CR>"
    else
        return ''
    endif
endfunction

" Return either 'textbf' or 'bm' depending on whether the cursor is in a math
" environment or not.
function! SmartBold()
	if vimtex#syntax#in_mathzone() == 1
		return 'bm'
	else
		return 'textbf'
	endif
endfunction

" Restart compiler
nnoremap <localleader>lr <cmd>VimtexStop<CR><cmd>VimtexCompile<CR>

" Insert display math environment
inoremap <M-M> \[<CR><CR>\]<ESC>ki

" Insert inline math environment
inoremap <M-m> \(\)<ESC>hi

" Insert bold environment
" TODO
" inoremap <C-b> \:call SmartBold

" Auto item on ctrl_enter
inoremap <buffer><expr> <C-CR> AutoItem()
