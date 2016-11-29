" these options did not work and is overridden
" autocmd FileType markdown
"     \ set formatoptions-=q |
"     \ set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*\[\-\*\+]\\s\\+\\\|
" 	\ set mmp=5000 " attempt to fix problem - pattern uses more memory than 'maxmempattern', the default is 1000

function! RemoveExistingMarkdownHeader()
	:let l:readyForInsert = "normal! 0"
	:let l:cmd = "normal! daw"
	:execute join([l:readyForInsert], "")
	:if getline('.')[col('.')-1] =~ "#"
	:	execute join([l:cmd], "")
	:endif
endfunction

function! AddMarkdownHeader(level)
	:let l:readyForInsert = "normal! m9I"
	:let l:spaceAndReturnToOriginalPosition = "\<space>\<esc>`9"
	:let l:header = repeat("#", a:level)
	:let l:adjustment = repeat("l", a:level + 1)
	:execute join([l:readyForInsert, l:header, l:spaceAndReturnToOriginalPosition, l:adjustment], "")
endfunction

nnoremap <leader>h1 :call RemoveExistingMarkdownHeader()<CR>:call AddMarkdownHeader(1)<CR>
nnoremap <leader>h2 :call RemoveExistingMarkdownHeader()<CR>:call AddMarkdownHeader(2)<CR>
nnoremap <leader>h3 :call RemoveExistingMarkdownHeader()<CR>:call AddMarkdownHeader(3)<CR>
nnoremap <leader>h4 :call RemoveExistingMarkdownHeader()<CR>:call AddMarkdownHeader(4)<CR>
nnoremap <leader>h5 :call RemoveExistingMarkdownHeader()<CR>:call AddMarkdownHeader(5)<CR>
nnoremap <leader>h6 :call RemoveExistingMarkdownHeader()<CR>:call AddMarkdownHeader(6)<CR>

" add a code block
nnoremap <leader>co I```<cr>```<esc>kA

" make visual selection as a code block
xnoremap <leader>co dO```<cr>```<esc>PkA

" surround a character with tag "kbd"
nnoremap <leader>k i<kbd><esc>la</kbd><esc>l

xnoremap <leader>t :Tabularize /<bar><cr>

" latex math
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" indentation (default: 4)
let g:vim_markdown_new_list_item_indent = 2

" folding
let g:vim_markdown_folding_level = 5

" syntax highlight
let g:vim_markdown_fenced_languages = ['csharp=cs']

" strikethrough
let g:vim_markdown_strikethrough = 1

" ========= vim-markdown ==================
" disable folding
let g:vim_markdown_folding_disabled = 0

" Allow for the TOC window to auto-fit when it's possible for it to shrink.
" It never increases its default size (half screen), it only shrinks.
let g:vim_markdown_toc_autofit = 1

" Disable conceal
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" Allow the ge command to follow named anchors in links of the form
" file#anchor or just #anchor, where file may omit the .md extension as usual
let g:vim_markdown_follow_anchor = 1

" highlight frontmatter
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

