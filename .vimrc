set nocompatible
set clipboard=unnamedplus

" Set variable used to identify which system we are on
if !exists("g:os")
    " Set variable used to identify which system we are on    
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" Download vim-plug if not already installed
if has('unix')
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    silent !curl -fLo ~/.vim/colors/Microsoft-Night.vim --create-dirs
          \ https://raw.githubusercontent.com/brentmcconnell/msft-night.vim/master/Microsoft-Night.vim 
    autocmd VimEnter * PlugInstall | source $MYVIMRC
    silent !git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    silent !~/.fzf/install
  endif
elseif has('win32')
  if empty(glob('~/vimfiles/autoload/plug.vim'))
    echom "Install vim-plug!"
  endif
endif

""" Plugins
call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'                   " Tmux Integration
Plug 'jlanzarotta/bufexplorer'                          " BufExplorer
Plug 'tpope/vim-commentary'                             " Comments
Plug 'tpope/vim-eunuch'                                 " UNIX commands
Plug 'tpope/vim-fugitive'                               " Git interface
Plug 'tpope/vim-surround'                               " Surrounding
Plug 'tpope/vim-obsession'                              " mksession goodies
Plug 'vim-airline/vim-airline'                          " Status line
Plug 'vim-airline/vim-airline-themes'                   " Status line themes
Plug 'scrooloose/nerdtree'                              " NERDTree
Plug 'junegunn/fzf.vim'                                 " FZF
Plug 'junegunn/limelight.vim'                           " Limelight
Plug 'leafgarland/typescript-vim'                       " Typescript syntax
Plug 'michaeljsmith/vim-indent-object'                  " Indent object
Plug 'timakro/vim-searchant'                            " Better search highlighting
Plug 'benmills/vimux'                                   " Better command handling with tmux
Plug 'mhinz/vim-signify'                                " Diff styling
Plug 'hashivim/vim-packer'                              " Packer syntax
Plug 'hashivim/vim-terraform'                           " Terraform Syntax
Plug 'christoomey/vim-system-copy'                      " Copy Paste mechanism to system clipboard
Plug 'wincent/scalpel'                                  " Scalpel for search/replace:w
Plug 'mg979/vim-visual-multi',{'branch': 'master'}      " Multiple cursors
call plug#end()

syntax on
filetype plugin indent on

"BHset background=light
let g:mapleader="\\"                " Set leader key
let g:maplocalleader=","            " Set leader key

"Multicursor modifications so that <C-n> is NERDTree
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n

set encoding=utf-8
set backspace=2
set history=200                     " Commands to save in history
set ruler                           " Show the cursor position all the time
set laststatus=2                    " Always display the status line
set noshowmode                      " Don't show mode as airline plugin does
set ttyfast                         " should make scrolling faster
set lazyredraw                      " should make scrolling faster
set mouse=a                         " Enable mouse (selection, resizing windows)
set visualbell                      " Show errors
set nowrap                          " No line wrapping
set formatoptions-=t                " No line wrapping
set listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
set list
set expandtab                       " Tabs are spaces
set tabstop=2                       " Tab is 4 spaces
set shiftwidth=2                    " > is 4 spaces
set hidden
set number relativenumber           " Set relativelinenumbers
set smarttab
set wildmenu                        " Turn on wildmenu
set backspace=indent,eol,start
set formatprg=par\ -w80
"set clipboard=unnamed
set guifont=Monaco:h10
set background=dark

au BufRead,BufNewFile *.md,*.txt setlocal textwidth=80 

" Custom color settings
" {{{
    set cursorline
    highlight clear CursorLine
    " Make sure cursorline is only in the active window
    highlight CursorLine ctermbg=238
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
    highlight Directory ctermfg=147
" }}}

" LimeLight Settings 
" {{{
    let g:limelight_conceal_ctermfg = 444
    let g:limelight_priority = -1
    let g:limelight_default_coefficient = 0.7
" }}}

" My random keybindings... Mostly
" {{{
  vmap <C-c> :'<,'>!pbcopy<CR><CR>                            " Copy visual selection 
  imap ff <esc>
  nnoremap 9 <esc>^
  nnoremap <esc>^[ <esc>^[                                     " Fix bug related to tmux
  nnoremap q <Nop>
  nnoremap <localleader>s <Nop>                                " Nop for ,s
  nnoremap Y y$                                                " Yank to end of line
  nnoremap <localleader>d :bd<CR>                              " Remove current buffer
  nnoremap <localleader>dd :bd!<CR>                            " Remove current buffer without saving
  nnoremap <localleader>n :enew<CR>                            " Open a new empty buffer
"  nnoremap <C-p> :bp <CR>
"  nnoremap <C-o> :bn <CR>
" Command below for <C-n> fixes issue with BufExplorer so that buffers aren't
" opened under it
  nnoremap <silent><expr> <C-n> bufname(winbufnr(0))=='[BufExplorer]' ? ":ToggleBufExplorer\<CR>:NERDTreeFocus\<CR>" : (winnr()==g:NERDTree.GetWinNum() ? ":NERDTreeClose\<CR>" : ":NERDTreeFocus\<CR>")
  nnoremap <localleader>L :Limelight!!<CR>                     " Toggle Limelight
  nnoremap <leader>v :source ~/.vimrc<CR>
" Command below for ; makes sure that BufExplorer doesn't open in NERDTree
" window
  nnoremap <silent><expr> ; winnr()==g:NERDTree.GetWinNum() ? ":NERDTreeClose\<CR>:ToggleBufExplorer<CR>" : ":ToggleBufExplorer<CR>" 
  nnoremap J :%!jq .<CR>
"	nnoremap / /\v
  nnoremap <localleader>vp :VimuxPromptCommand<CR>
  nnoremap <localleader>vl :VimuxRunLastCommand<CR>
    " remap arrow keys
  nnoremap <Left> :bprev<CR>
  nnoremap <Right> :bnext<CR>
    "	inoremap <silent><expr> <c-space> coc#refresh()<Paste>
    "autocmd BufWinLeave *.* mkview                              
    "autocmd BufWinEnter *.* silent loadview                    
"}}}

" BufExplorer Settings
" {{{
    augroup my_bufexplorer
        autocmd!
        autocmd FileType bufexplorer call s:bufexplorer_my_settings()
            function! s:bufexplorer_my_settings() abort
              " Define mappings
              nmap <silent><esc> q
            endfunction
    augroup END
    let g:bufExplorerShowNoName = 1
    let g:bufExplorerSortBy = 'mru'
    "let g:bufExplorerSplitBelow = 1
    "let g:bufExplorerSplitHorzSize = 15
    let g:bufExplorerShowDirectories = 1
    let g:bufExplorerDefaultHelp = 0
    let g:bufExplorerFindActive = 1
" }}}


" ====================================
" Airline
" ====================================
" {{{
    let g:airline_theme='molokai'                   " Airline theme
"    let g:airline_theme='violet'
    let g:airline#extensions#coc#enabled = 1 
    let g:airline#extensions#branch#enabled = 0
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    let g:airline_powerline_fonts = 1
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline_statusline_ontop=0
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 1
" }}}


" FZF Settings
" {{{
    if g:os == "Darwin"
        set rtp+=/usr/local/opt/fzf
        "set FZF_DEFAULT_COMMAND in .zshrc
        "let $FZF_DEFAULT_COMMAND = 'fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --type f'
    else
        set rtp+=~/.fzf
        let $FZF_DEFAULT_COMMAND = 'fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --type f --hidden'
    endif

    let g:fzf_nvim_statusline = 1 " disable statusline overwriting

    nnoremap <silent> <localleader>w :Windows<CR>
    nnoremap <silent> <localleader>l :Locate ~<CR>
    nnoremap <silent> <localleader>/ :Locate /<CR>
    nnoremap <silent> <localleader>b :Buffers<CR>
    nnoremap <silent> <leader>? :History<CR>
    nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
    nnoremap <silent> <leader>. :AgIn 
    nnoremap <silent> K :call SearchWordWithAg()<CR>
    vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
    nnoremap <silent> <leader>gl :Commits<CR>
    nnoremap <silent> <leader>ga :BCommits<CR>
    nnoremap <silent> <leader>ft :Filetypes<CR>
    " Search from where vim is located
    nnoremap <silent> <localleader>f :Files<CR>
    " Search ~Repos
    nnoremap <silent> <localleader>r :ProjectFiles<CR>
    nnoremap <silent> <localleader>h :HomeFiles<CR>
    nnoremap <silent> <localleader>s :mksession! ~/my.vim<CR>
    nnoremap <silent> <leader>r :NERDTreeFind<CR>

    imap <C-x><C-f> <plug>(fzf-complete-file-ag)
    imap <C-x><C-l> <plug>(fzf-complete-line)

    function! SearchWordWithAg()
        execute 'Ag' expand('<cword>')
    endfunction

    function! SearchVisualSelectionWithAg() range
        let old_reg = getreg('"')
        let old_regtype = getregtype('"')
        let old_clipboard = &clipboard
        set clipboard&
        normal! ""gvy
        let selection = getreg('"')
        call setreg('"', old_reg, old_regtype)
        let &clipboard = old_clipboard
        execute 'Ag' selection
    endfunction

    function! SearchWithAgInDirectory(...)
        call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
    endfunction
    command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)
    command! HomeFiles call fzf#vim#files('~') 
    command! ProjectFiles call fzf#vim#files('~/Repos') 
" }}}

"{{{ NERDTree
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    let g:NERDTreeQuitOnOpen = 1
    let g:NERDTreeAutoDeleteBuffer = 1
    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeWinSize = 40
    let g:fzf_layout = { 'window': 'let g:launching_fzf = 1 | keepalt topleft 100split enew' }

    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

    autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')
    autocmd BufWinEnter * call PreventBuffersInNERDTree()

    function! PreventBuffersInNERDTree()
      if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree'
        \ && exists('t:nerdtree_winnr') && bufwinnr('%') == t:nerdtree_winnr
        \ && &buftype == '' && !exists('g:launching_fzf')
        let bufnum = bufnr('%')
        close
        exe 'b ' . bufnum
      endif
      if exists('g:launching_fzf') | unlet g:launching_fzf | endif
    endfunction

"}}}

