"--------------------------------------
"nvim基本設定
"--------------------------------------
let g:ruby_host_prog = '/Users/y_gunji/.rbenv/versions/3.0.0/bin/neovim-ruby-host'
"let g:python3_host_prog ='/Users/y_gunji/.pyenv/versions/py3/bin/python'
let g:python3_host_prog ='/Users/y_gunji/.anyenv/envs/pyenv/versions/py3/bin/python'
"let g:python_host_prog ='/Users/y_gunji/.pyenv/versions/py2/bin/python'
let g:python_host_prog ='/Users/y_gunji/.anyenv/envs/pyenv/versions/py2/bin/python'
let g:node_host_prog = '/Users/y_gunji/.anyenv/envs/nodenv/versions/15.9.0/bin/neovim-node-host'

"--------------------------------------
"dein.vim
"--------------------------------------

" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'
  let s:toml_lazy = s:rc_dir . '/dein_lazy.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:toml_lazy, {'lazy': 1})

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}

"--------------------------------------
"一般設定
"--------------------------------------

"文字コード
set fenc=utf-8

"backup fileを作らない
"set nobuckup
"swap fileを作らない
"set noswapfile
"編集中のfileが変更されたら自動で読み直す
"set autoread
"バッファが編集中でもその他のファイルを開けるように
set hidden

"表示
"行番号を表示
set number

"colorscheme
set termguicolors
" set background=light
set background=dark
colorscheme iceberg
" set transparency
highlight Normal ctermbg=none guibg=none
highlight NonText ctermbg=none guibg=none
highlight LineNr ctermbg=none guibg=none
highlight Folded ctermbg=none guibg=none
highlight EndOfBuffer ctermbg=none guibg=none
" augroup TransparentBG
"  	autocmd!
" 	autocmd Colorscheme * highlight Normal ctermbg=none guibg=none
" 	autocmd Colorscheme * highlight NonText ctermbg=none guibg=none
" 	autocmd Colorscheme * highlight LineNr ctermbg=none guibg=none
" 	autocmd Colorscheme * highlight Folded ctermbg=none guibg=none
" 	autocmd Colorscheme * highlight EndOfBuffer ctermbg=none guibg=none
" augroup END


"入力
"日本語入力後ESCでcommand modeに戻る際IEMをOFFに
inoremap <silent> <Esc> <Esc>:set iminsert=0<CR>
"行末の1文字先までカーソル移動できるように
set virtualedit=onemore
"smart indent
set smartindent
"ビープ音の可視化
set visualbell
"括弧入力時に対応する括弧を表示
set showmatch
"statuslineを常に表示
set laststatus=2
"command lineの補完
set wildmode=list:longest
"折り返し時に表示行単位での移動を可能に
nnoremap j gj
nnoremap k gk
"OSのクリップボードをレジスタ指定なしでYank, Putできるように
set clipboard=unnamed,unnamedplus

"tab
"tab文字を半角スペースに
set expandtab
"行頭以外のtab文字の表示幅
set tabstop=2
"行頭(自動インデント)のtab文字の表示幅
set shiftwidth=2

"検索
"検索文字列が小文字の場合は大文字小文字の区別なく検索
set ignorecase
"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
"検索文字入力時に順次対象文字にヒットさせる
set incsearch
"検索時に最後まで行ったら最初に戻る
set wrapscan
"検索ワードをハイライト
set hlsearch
"ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc> 

"拡張子が.texでもlatexとして認識できるように
let g:tex_flavor='latex'

"
"Terminal mode
"
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif
":Tで現在のwindow下部にterminal windowを表示
command! -nargs=* T split | wincmd j | resize 20 | terminal <args>
"Terminal使用時insert modeでwindowを開く
autocmd TermOpen * startinsert
"Terminalで行数非表示
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber

"python実行
autocmd Filetype python nnoremap <buffer> <C-t> :w<CR>:!python3 %<CR>

"Esc to jj
inoremap <silent> jj <ESC>
"日本語入力で”っj”と入力してもEnterキーで確定させればインサートモードを抜ける
inoremap <silent> っｊ <ESC>
inoremap <silent> っj <ESC>
