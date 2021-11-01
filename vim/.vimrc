set hidden
set showmatch
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set backspace=2

" execute pathogen#infect()
call plug#begin('~/.vim/plugged')


Plug 'https://github.com/moll/vim-bbye.git'
Plug 'https://github.com/AndrewRadev/linediff.vim.git'
Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim'
" Plug 'https://github.com/scrooloose/nerdcommenter.git'
" Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/bling/vim-bufferline'
Plug 'https://github.com/teoljungberg/vim-grep.git'
" Plug 'https://github.com/easymotion/vim-easymotion'
" Plug 'https://github.com/jceb/vim-orgmode.git'
" Plug 'https://github.com/terryma/vim-smooth-scroll.git'
call plug#end()

syntax enable

if has("gui_running")
    set background=dark
    colorscheme solarized
else
    colorscheme monokai
endif

set encoding=utf-8
set fileencoding=utf-8

map <Leader>dark :colorscheme solarized<CR>:set background=dark<CR>
map <Leader>light :colorscheme solarized<CR>:set background=light<CR>
map <Leader>monokai :colorscheme monokai<CR>


set cursorline

" don't select line numbers with mouse
set mouse=a

set number
set relativenumber
set hlsearch

set ignorecase
set smartcase
set incsearch
set nowrapscan
nnoremap * :keepjumps normal! mi*`i<CR> """ * highlights words but doesn't jump.
                                        """ also don't put jump into jump list

map <Space> <Leader>

set foldmethod=syntax
set foldlevelstart=100

set scrolloff=3


"set winheight=30
"set winminheight=5


set rtp+=/usr/local/opt/fzf " homebrew
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf/  " linuxbrew

filetype plugin on " NERDCommenter

"""""
""""" NERDCommenter
"""""

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

"""""
""""" NERDCommenter
"""""





"""""
"""""  EASY MOTION PLUGIN
"""""

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <Leader>s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

map <Leader>w <Plug>(easymotion-bd-w)


"""
"""  =====END=====
"""


" map <silent> <F11>                                                                      """ gvim F11 toggles fullscrenn
" \    :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>             """


" https://vi.stackexchange.com/questions/663/quickly-switch-between-fonts-at-runtime?rq=1
" https://vi.stackexchange.com/questions/3093/how-can-i-change-the-font-size-in-gvim
" Define a list of the fonts you want to use, and the index in the 
" list of the default font. See :help Lists
let g:fc_list = [
\   "Meslo LG M Regular for Powerline:h9",
\   "Meslo LG M Regular for Powerline:h10",
\   "Meslo LG M Regular for Powerline:h12",
\   "Meslo LG M Regular for Powerline:h13"
\   ]
let g:fc_current = 1

" Set default font
let &guifont = g:fc_list[g:fc_current]

" function! FontCycle()
"   " Increment circular list. See :help expr-%
"   let g:fc_current = (g:fc_current + 1) % len(g:fc_list)
"   let &guifont = g:fc_list[g:fc_current]
" endfunction
" 
" noremap <leader>fc :call FontCycle()<cr>


" set guifont=Monospace\ Bold\ 8
" set guifont=Menlo\ Bold:h13
" set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h13

" set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar

set laststatus=2  " fixes bug when airline shows only on splitted vim
set statusline+=%F " add full path to status line

let g:XkbSwitchEnabled = 1



""" move around window splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright


" buubling text up and down with vim-unimpaired
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" copy filename and line to clipboard
nnoremap <Leader>cfn :let @+=expand("%").":".line(".")

" NERDTree toggle
map <Leader>tre :NERDTreeToggle<CR>
nmap <Leader>trr :NERDTreeFind<CR>
let NERDTreeIgnore = ['\.pyc$']                                                        """ filter out .pyc files. (comma-separated list)
let g:NERDTreeWinSize = 40

" search visually selected text
vnoremap // "vy/<C-R>v<CR>
" vnoremap // "vy/\<<C-R>v\><CR>

noremap <Leader>/ /qwertyu____never_encoutered_string____asdjfklasdkjflaslhdkf<CR>

set tags=tags;/

nnoremap <C-n> :bnext<CR>
nnoremap <C-m> :bprevious<CR>

nmap <Leader>n :tn<CR>
nmap <Leader>m :tp<CR>

"""
"""
""" remove trailing spaces from c++ and python files
" autocmd BufWritePre *.c :%s/\s\+$//e
" autocmd BufWritePre *.cpp :%s/\s\+$//e
" autocmd BufWritePre *.h :%s/\s\+$//e
" autocmd BufWritePre *.hpp :%s/\s\+$//e
" autocmd BufWritePre *.py :%s/\s\+$//e

" assumes vim-better-whitespace been installed
"let g:better_whitespace_enabled=0
let g:show_spaces_that_precede_tabs=1

"""
""" YouCOmpletMe
"""
let g:ycm_largefile = 1
let g:ycm_confirm_extra_conf = 0                                                        """ disable confirmation of configuration file found
let g:ycm_autoclose_preview_window_after_completion = 0                                 """
set completeopt-=preview                                                                """ disable preview window
let g:ycm_add_preview_to_completeopt = 0                                                """ disable preview window


let g:ycm_show_diagnostics_ui = 0


"""
""" close buffer by ctrl-q
"""

nnoremap <Leader>q  :Bdelete<CR>

"""
""" copy paste for gvim
"""
" vmap <C-c> "+yi
" vmap <C-x> "+c
" vmap <C-v> c<ESC>"+p
" imap <C-v> <ESC>"+pa

""let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co'] "" https://news.ycombinator.com/item?id=4470283
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:15'


"""
""" fugitive
"""
set diffopt+=vertical

"""
""" smooth scrolling
"""

"nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 2)<CR>
"nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 2)<CR>
"nnoremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 4)<CR>
"nnoremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 4)<CR>

"""
""" Tagbar
"""
nmap <F8> :TagbarToggle<CR>
let g:tagbar_show_linenumbers = 2 """ show relative line numbers in tagbar window
set updatetime=4000 """
highlight TagbarHighlight guibg=Green guifg=Yellow ctermfg=Green

"""
""" Ag (silver search)
"""

" bind K to grep word under cursor
cabbrev Ag Ag!
" map K :Ag <C-R><C-W><CR>
" map K :Ag -w "<C-R><C-W>"<CR>:cw<CR>
let g:ag_highlight=1

" moved to ripgrep!
nnoremap K :FindExact <C-R><C-W><CR>
vnoremap K "vy :FindExact <C-R>v<CR>
nnoremap <Leader>find :Find 
nnoremap <Leader>/ :BLines<CR>
vnoremap <Leader>/ "vy :BLines '<C-R>v<CR>




"""
"""
""" Powerline fonts
"""
"""

" air-line

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>= <Plug>AirlineSelectNextTab

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


nnoremap  <leader>b<CR>     :Buffers<CR>
nnoremap  <leader>f<CR>     :Files ./<CR>
vnoremap  <leader>f<CR> "vy :Files ./<CR>
nnoremap  <leader>fe<CR>    :Files ./projects/china_feed/feeder<CR>
nnoremap  <leader>fr<CR>    :Files ./projects/china_feed/frontend<CR>
nnoremap  <leader>t<CR>  :Tags '<C-R><C-W> <CR>
vnoremap  <leader>t<CR> "vy :Tags '<C-R>v <CR>


" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
" I changed FZF_DEFAULT_COMMAND, see .profile
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --smart-case  --hidden --follow  --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FindExact call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case  --hidden --follow  --color "always" '.shellescape(<q-args>), 1, <bang>0)

command! Draft :vsplit ~/draft


"""
"""
""" END
"""
"""




command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

