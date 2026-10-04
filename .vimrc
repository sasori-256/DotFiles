"==============================================================================
" vimrc
"   方針: Vim 8.0+ / sudo 不要 / 低スペックでも軽快 / tomisuke・qwerty 両対応
"   端末ごとの差分は ~/.vimrc.local に書く（例: let g:default_layout = 'qwerty'）
"==============================================================================

"------------------------------------------------------------------------------
" 0. 初期化
"------------------------------------------------------------------------------
if &compatible
  set nocompatible
endif
set encoding=utf-8
scriptencoding utf-8

augroup vimrc
  autocmd!
augroup END

" ~/.vim (Unix) / ~/vimfiles (Windows)
let s:vimdir = split(&runtimepath, ',')[0]

let mapleader = "\<Space>"

" 端末ごとの設定（存在すれば先に読む）
let s:local = expand('~/.vimrc.local')
if filereadable(s:local)
  execute 'source ' . fnameescape(s:local)
endif

"------------------------------------------------------------------------------
" 1. 基本
"------------------------------------------------------------------------------
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp932,euc-jp
set fileformats=unix,dos,mac
set ambiwidth=double
set backspace=indent,eol,start
set hidden
set autoread
set updatetime=300
set ttimeout ttimeoutlen=50      " <Esc> の反応を速く
set timeoutlen=500               " jj / hh の待ち時間

autocmd vimrc FocusGained,BufEnter * silent! checktime

"------------------------------------------------------------------------------
" 2. クリップボード
"   +clipboard があればそれを使い、無ければ OSC 52 で端末経由コピー（SSH 先向け）
"------------------------------------------------------------------------------
if has('clipboard')
  set clipboard^=unnamed,unnamedplus
elseif executable('base64') && exists('##TextYankPost')
  function! s:Osc52Yank() abort
    if v:event.operator !=# 'y' || v:event.regname !=# ''
      return
    endif
    let l:text = join(v:event.regcontents, "\n")
    if len(l:text) > 100000
      return
    endif
    let l:b64 = substitute(system('base64', l:text), '\n', '', 'g')
    let l:seq = "\e]52;c;" . l:b64 . "\x07"
    if exists('*echoraw')
      call echoraw(l:seq)
    else
      call writefile([l:seq], '/dev/tty', 'b')
    endif
  endfunction
  autocmd vimrc TextYankPost * call s:Osc52Yank()
endif

"------------------------------------------------------------------------------
" 3. 表示
"------------------------------------------------------------------------------
set number
set ruler
set title
set cursorline
set colorcolumn=
set showmatch matchtime=1
set matchpairs+=<:>,（:）,「:」,『:』,【:】,［:］,＜:＞
set visualbell t_vb=
set virtualedit=onemore
set whichwrap=b,s,h,l,<,>,[,],~
set wrap linebreak breakindent
set showbreak==>>>
set display=lastline
set list listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
set nospell
set laststatus=2 cmdheight=2
set wildmenu wildmode=longest:full,full
set statusline=%f\ %m%r%h%w%=%{&fenc!=#''?&fenc:&enc}\ %{&ff}\ %y\ [%{get(g:,'layout','')}]\ %l:%c\ %p%%

if has('packages')
  packadd! matchit
else
  runtime macros/matchit.vim
endif

"------------------------------------------------------------------------------
" 4. 軽量化
"------------------------------------------------------------------------------
set lazyredraw
set synmaxcol=300                " 長い行はハイライトを途中で打ち切る
set redrawtime=1500
set foldmethod=indent            " syntax より軽い
set foldlevelstart=99

" 大きいファイルはハイライト等を切る（既定 2MB、.vimrc.local で変更可）
let g:largefile_size = get(g:, 'largefile_size', 2 * 1024 * 1024)
function! s:LargeFilePre() abort
  let l:size = getfsize(expand('<afile>'))
  if l:size > g:largefile_size || l:size == -2
    let b:largefile = 1
    setlocal noundofile
  endif
endfunction
autocmd vimrc BufReadPre * call s:LargeFilePre()
autocmd vimrc BufWinEnter * if get(b:, 'largefile', 0)
      \ | setlocal syntax=OFF nocursorline foldmethod=manual | endif

"------------------------------------------------------------------------------
" 5. インデント
"------------------------------------------------------------------------------
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent                   " smartindent は filetype indent と競合するので外す

"------------------------------------------------------------------------------
" 6. バックアップ / Undo
"------------------------------------------------------------------------------
set nobackup nowritebackup noswapfile
if has('persistent_undo')
  let &undodir = s:vimdir . '/undo'
  if !isdirectory(&undodir)
    call mkdir(&undodir, 'p', 0700)
  endif
  set undofile
endif

"------------------------------------------------------------------------------
" 7. 検索 / 分割
"------------------------------------------------------------------------------
set hlsearch incsearch ignorecase smartcase wrapscan
set splitbelow splitright

"------------------------------------------------------------------------------
" 8. 共通マッピング
"------------------------------------------------------------------------------
nnoremap Y y$
nnoremap U <C-r>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
" 全選択（数値インクリメントの <C-a> は使えなくなる）
nnoremap <C-a> ggVG

" --- 簡易オートペア（閉じ括弧の上書き・ペア削除付き） ---
function! s:NextChar() abort
  return getline('.')[col('.') - 1]
endfunction
function! s:PrevChar() abort
  return col('.') > 1 ? getline('.')[col('.') - 2] : ''
endfunction
function! s:Close(c) abort
  return s:NextChar() ==# a:c ? "\<Right>" : a:c
endfunction
function! s:Quote(q) abort
  if s:NextChar() ==# a:q
    return "\<Right>"
  endif
  if s:PrevChar() =~# '\w'       " don't などでは補完しない
    return a:q
  endif
  return a:q . a:q . "\<C-g>U\<Left>"
endfunction
function! s:BS() abort
  let l:pair = s:PrevChar() . s:NextChar()
  return index(['()', '[]', '{}', '""', "''"], l:pair) >= 0 ? "\<Del>\<BS>" : "\<BS>"
endfunction

inoremap ( ()<C-g>U<Left>
inoremap [ []<C-g>U<Left>
inoremap { {}<C-g>U<Left>
inoremap <expr> ) <SID>Close(')')
inoremap <expr> ] <SID>Close(']')
inoremap <expr> } <SID>Close('}')
inoremap <expr> " <SID>Quote('"')
inoremap <expr> ' <SID>Quote("'")
inoremap <expr> <BS> <SID>BS()

"------------------------------------------------------------------------------
" 9. 配列切り替え
"   優先度: g:default_layout (.vimrc.local) > $VIM_LAYOUT > 'tomisuke'
"   コマンド: :Tomisuke / :Qwerty / :LayoutToggle (<Leader>l)
"------------------------------------------------------------------------------
" [mode, lhs, rhs]
let s:layouts = {
      \ 'qwerty': [
      \   ['n', 'j', 'gj'], ['n', 'k', 'gk'],
      \   ['x', 'j', 'gj'], ['x', 'k', 'gk'],
      \   ['n', 'n', 'nzz'], ['n', 'N', 'Nzz'],
      \   ['i', 'jj', '<Esc>'],
      \   ['i', '<C-h>', '<Left>'], ['i', '<C-j>', '<Down>'],
      \   ['i', '<C-k>', '<Up>'],   ['i', '<C-l>', '<Right>'],
      \ ],
      \ 'tomisuke': [
      \   ['n', 'n', 'h'], ['n', 't', 'gj'], ['n', 's', 'gk'], ['n', 'k', 'l'],
      \   ['x', 'n', 'h'], ['x', 't', 'gj'], ['x', 's', 'gk'], ['x', 'k', 'l'],
      \   ['n', 'j', 's'],
      \   ['n', 'h', 'nzz'], ['n', 'H', 'Nzz'],
      \   ['i', 'hh', '<Esc>'],
      \   ['i', '<C-n>', '<Left>'], ['i', '<C-t>', '<Down>'],
      \   ['i', '<C-s>', '<Up>'],   ['i', '<C-k>', '<Right>'],
      \ ],
      \ }

let s:current_layout = ''

function! s:SetLayout(name, verbose) abort
  if !has_key(s:layouts, a:name)
    echohl ErrorMsg | echo 'Unknown layout: ' . a:name | echohl None
    return
  endif
  " 前の配列のマッピングを消してから適用する
  if !empty(s:current_layout)
    for [m, lhs, rhs] in s:layouts[s:current_layout]
      execute 'silent! ' . m . 'unmap ' . lhs
    endfor
  endif
  for [m, lhs, rhs] in s:layouts[a:name]
    execute m . 'noremap <silent> ' . lhs . ' ' . rhs
  endfor
  let s:current_layout = a:name
  let g:layout = a:name
  if a:verbose
    redrawstatus | echo 'layout: ' . a:name
  endif
endfunction

command! Tomisuke     call s:SetLayout('tomisuke', 1)
command! Qwerty       call s:SetLayout('qwerty', 1)
command! LayoutToggle call s:SetLayout(s:current_layout ==# 'tomisuke' ? 'qwerty' : 'tomisuke', 1)
nnoremap <silent> <Leader>l :<C-u>LayoutToggle<CR>

call s:SetLayout(get(g:, 'default_layout', empty($VIM_LAYOUT) ? 'tomisuke' : $VIM_LAYOUT), 0)

"------------------------------------------------------------------------------
" 10. プラグイン (vim-plug)
"   初回: :PlugSetup → Vim 再起動 → :PlugInstall
"   起動時の自動ダウンロードはしない（オフライン環境で固まるため）
"   $VIM_NOPLUG=1 で無効化
"------------------------------------------------------------------------------
let s:plug_path = s:vimdir . '/autoload/plug.vim'
let s:plug_url  = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

function! s:PlugSetup() abort
  if !executable('curl') || !executable('git')
    echohl ErrorMsg | echo 'curl と git が必要です' | echohl None
    return
  endif
  call system('curl -fLo ' . shellescape(s:plug_path) . ' --create-dirs ' . s:plug_url)
  if v:shell_error
    echohl ErrorMsg | echo 'vim-plug のダウンロードに失敗しました' | echohl None
    return
  endif
  echo 'vim-plug を導入しました。Vim を再起動して :PlugInstall を実行してください'
endfunction
command! PlugSetup call s:PlugSetup()

if filereadable(s:plug_path) && empty($VIM_NOPLUG)
  call plug#begin(s:vimdir . '/plugged')
  " gcc / gc{motion} でコメント切替
  Plug 'tpope/vim-commentary'
  " ds / cs / ys で囲み操作
  Plug 'tpope/vim-surround'
  " 配色
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  call plug#end()
endif

"------------------------------------------------------------------------------
" 11. 配色 / シンタックス
"------------------------------------------------------------------------------
filetype plugin indent on
syntax enable

if has('termguicolors') && ($COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit')
  set termguicolors
endif
try
  colorscheme catppuccin_frappe
catch
  " Vim 9 同梱。Vim 8 では既定配色のまま
  silent! colorscheme habamax
endtry

