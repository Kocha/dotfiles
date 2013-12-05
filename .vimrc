" vim: set ts=4 sw=4 sts=0 foldmethod=marker:
" -------------------------------------------------------------------
"
" 環境変数
if !exists("$VIMHOME")
  let $VIMHOME=$HOME
endif

augroup MyVimrc
  autocmd!
augroup END
" -------------------------------------------------------------------
" System関連
"
"vi互換の動きにしない
" set nocompatible
"左右のカーソル移動で行間移動可能にする。
"set whichwrap=b,s,<,>,[,],h,l
set whichwrap=b,s,<,>,[,]
" 選択した文字をクリップボードに入れる(自動)
set clipboard=unnamed,autoselect
" コメント行にてEnterキー入力後コメントになる動作を解除
" ft=vimでは効果なし() "set fo-=ro
autocmd MyVimrc FileType * setlocal formatoptions-=ro
" backspaceの拡張
set backspace=start,eol,indent

" -------------------------------------------------------------------
" Display関連
"
" テーマ色
"colorscheme evening "colorscheme
colorscheme ron "colorscheme
" 色数
set t_Co=256
" ステータスバーを常に表示
set laststatus=2
" 行数の表示
set number
" ステータスバーに表示
" set ruler
" 折り返し文字数指定
"set textwidth=70
set linespace=0
" 閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
" シフト移動幅
set shiftwidth=4
" 閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
" 新しい行を作ったときに高度な自動インデントを行う
" set smartindent
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
" ファイル内の <Tab> が対応する空白の数
set tabstop=4
" ステータスラインに文字コードと改行文字を表示する
" set statusline=%<%f\%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P
" ステータスラインに日時を追加表示する
" function! g:Date()
"   return strftime("%x %H:%M")
" endfunction
" set statusline+=\ \%{g:Date()}
" ステータスラインに補完候補を表示
set wildmenu
" タブ文字を可視化
set list
set listchars=tab:>\ 
" :split時の挙動を変更
set splitbelow
set splitright
" ディレクトリ閲覧時のツリー表示
let g:netrw_liststyle=3
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
" 連結時のコメント削除&日本語の行の連結時には空白を入力しない
set formatoptions+=jM
" 全角スペースの表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=red gui=underline guifg=red
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
    autocmd ColorScheme   * call ZenkakuSpace()
    " 全角スペースのハイライト指定
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

" 行数の横の文字列を変更(オリジナル)
" set numberchar=\|
" set fillchars=num:\|

" -------------------------------------------------------------------
" syntax color
"
syntax on

" -------------------------------------------------------------------
" 検索関連
"
" 検索時に大/小文字を区別しない
set ignorecase
" 検索時に大文字を含んでいたら大/小を区別
set smartcase
" 検索をファイルの先頭へループしない
" set nowrapscan
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索結果文字列のハイライトを有効にする
set hlsearch

" -------------------------------------------------------------------
" Edit関連
"
" オートインデントしない(default:ON)
"set noautoindent
" TABキーを押した際にタブ文字の代わりにスペースをいれる
" set expandtab
"バックアップを取らない
set nobackup
" 隠れバッファを利用する
set hidden
" 最後に編集した部分にカーソルを移動
autocmd MyVimrc BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" 文字がない部分でも矩形選択可能にする
set virtualedit=block
" Undo拡張
set undofile
set undodir=$VIMHOME/.undo
" ウィンドウを閉じずにバッファを閉じる
command! Ebd call EBufdelete()
function! EBufdelete()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if buflisted(l:currentBufNum)
    execute "silent bwipeout".l:currentBufNum
    " bwipeoutに失敗した場合はウインドウ上のバッファを復元
    if bufloaded(l:currentBufNum) != 0
      execute "buffer " . l:currentBufNum
    endif
  endif
endfunction
" -------------------------------------------------------------------
" キーマップ関連
"
" AllMaps
command! -nargs=* -complete=mapping
  \ AllMaps map <args> | map! <args> | lmap <args>
"================================================
" Normal+Virtualモード関係
"================================================
" 行頭/行末へ移動
" noremap <C-a> ^
noremap <C-e> $
"================================================
" Normalモード関係
"================================================
" 表示行単位で行移動する
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
" ESC2回押しで検索ハイライトを消去
" nnoremap <ESC><ESC> :nohlsearch<CR>
" 検索後画面の中心に。
" nnoremap n nzz
" nnoremap N Nzz
" カーソル部分から行末までコピー
nnoremap Y y$
" 行の二重化
" nnoremap <C-Enter> yypk
" 行削除
nnoremap <S-Enter> dd
" 行番号表示の切り替え
nnoremap <C-x><C-n> :setlocal nu!<CR>
" Blog用
nnoremap ,re :%s/<\(p\\|\/p\\|br\s*\/*\)>//g<CR>:%s/\n<hr/<hr/g<CR>:%s/<hr\s\/>\n/<hr \/>/g<CR>
"縦画面分割後に連携
nnoremap ,vp :<C-u>vsp<CR>z+ :set scrollbind<CR><C-w><C-w>:set scrollbind<CR>
"================================================
" Insertモード関係
"================================================
" 挿入モード時に、行頭/行末へ移動
inoremap <C-e> <ESC>A
inoremap <C-a> <ESC>^i
" <C-V> Clipboardから貼り付け
inoremap <C-v> <ESC>"*pa
" 挿入モード時に、カーソル移動(Emacs)
" inoremap <C-h> <Left>
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-l> <Right>
inoremap <C-b> <Left>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-f> <Right>
" ()などの入力時の補助
inoremap () ()<Left>
inoremap [] []<Left>
inoremap {} {}<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap <> <><Left>
"================================================
" コマンドライン関係
"================================================
" <C-a>で先頭へ
cnoremap <C-a> <Home>
" %% を入力すると現在編集中のファイルのフォルダのパスを展開
if has('win32')
  cnoremap %% <C-r>=expand('%:p:h').'\'<cr>
else
  cnoremap %% <C-r>=expand('%:p:h').'/'<cr>
endif
" クリップボードから貼り付け
cnoremap <C-v> <C-r>+
" / と ? の入力を補助
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
" -------------------------------------------------------------------
" ファイル別指定
"
"================================================
" Help {{{
"================================================
" q で閉じる
autocmd MyVimrc FileType help nnoremap <buffer> q :q<CR>
" }}}
"================================================
" Markdown {{{
"================================================
" 拡張子設定[*.md, *.mkd]
autocmd MyVimrc BufRead,BufNewFile *.md,*.mkd call <SID>file_markdown()
function! s:file_markdown()
  setfiletype markdown
  setlocal fileencoding=UTF-8
endfunction
" Shift+Enterにて<br>タグ挿入
autocmd MyVimrc FileType markdown inoremap <buffer> <S-Enter> <br /><CR>
" }}}
"================================================
" Template {{{
"================================================
" 新規ファイルの際に挿入する。
autocmd MyVimrc BufNewFile *.h,*.c,*.cpp 0r $HOME/.vim/template/template.h
autocmd MyVimrc BufNewFile *.vim 0r $HOME/.vim/template/template.vim
" }}}

" -------------------------------------------------------------------
" ToHTML関連
"
" 行番号をつける
let html_number_lines = 1
" CSSを利用したHTMLを生成する。(0:生成しない。1:生成する。)
let html_use_css = 0
" <pre>タグを使用しないHTMLを生成する。
" let html_no_pre = 1
" -------------------------------------------------------------------
" VimGrep関連
"
" :vimgrep検索後に QuickFixウィンドウを開く
autocmd MyVimrc QuickFixCmdPost vimgrep cw
" -------------------------------------------------------------------
" HelpGrep関連
"
" :helpgrep検索後に unite-quickfixを開く
autocmd MyVimrc QuickFixCmdPost helpgrep Unite quickfix
" -------------------------------------------------------------------
" QuickFix関連
"
" QuickFixウィンドウだけの場合に自動で閉じる
autocmd MyVimrc WinEnter * 
  \ if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
" -------------------------------------------------------------------
" 標準プラグイン関連
"
" source $VIMRUNTIME/macros/matchit.vim

" -------------------------------------------------------------------
" プラグイン管理(NeoBundle) {{{
"
if exists("$USER_GIT_PROTOCOL")
  let g:neobundle_default_git_protocol = $USER_GIT_PROTOCOL
endif

filetype plugin indent off " required!

if has('vim_starting')
  set runtimepath+=$VIMHOME/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('$VIMHOME/.vim/bundle/'))

" Plugins List
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', { 'build': {
  \ 'windows': 'make -f make_mingw32.mak',
  \ 'cygwin' : 'make -f make_cygwin.mak',
  \ 'mac'    : 'make -f make_mac.mak',
  \ 'unix'   : 'make -f make_unix.mak',
  \ } }
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vinarise'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'tyru/caw.vim'
NeoBundle 'tyru/eskk.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/coolgrep.vim'
" NeoBundle 'kana/vim-smartinput'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'osyo-manga/unite-quickrun_config'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'osyo-manga/unite-qfixhowm'
NeoBundle 'osyo-manga/quickrun-outputter-replace_region'
NeoBundle 'osyo-manga/vim-textobj-multiblock'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'osyo-manga/vim-over'
" NeoBundle 'jceb/vim-hier'
" NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'mattn/webapi-vim'
" NeoBundle 'mattn/multi-vim'
NeoBundle 'mattn/excitetranslate-vim'
" NeoBundle 'gregsexton/VimCalc'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'godlygeek/tabular'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'tpope/vim-surround'
" NeoBundle 'yonchu/accelerated-smooth-scroll'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'deris/vim-rengbang'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-scripts/DrawIt'
NeoBundle 'vim-scripts/Colour-Sampler-Pack'
NeoBundle 'vim-jp/vimdoc-ja'

NeoBundle 't9md/vim-textmanip'
NeoBundle 'modsound/gips-vim'

" Vim Version Check
function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction
" neocomplete/neocomplcache install
if s:meet_neocomplete_requirements()
  NeoBundle 'Shougo/neocomplete.vim'
  NeoBundleFetch 'Shougo/neocomplcache.vim'
else
  NeoBundleFetch 'Shougo/neocomplete.vim'
  NeoBundle 'Shougo/neocomplcache.vim'
endif
"================================================
" NeoBundleLazy List {{{
"================================================
NeoBundleLazy 'Shougo/vimshell', {
\   'autoload' : { 'commands' : [ 'VimShell' ] }
\}
" Markdown, Textile
NeoBundleLazy "hallison/vim-markdown",  {"autoload" : { "filetypes" : ["markdown"] }}
NeoBundleLazy "joker1007/vim-markdown-quote-syntax",  {"autoload" : { "filetypes" : ["markdown"] }}
NeoBundleLazy "timcharper/textile.vim", {"autoload" : { "filetypes" : ["textile"] }}
" haskell
NeoBundleLazy "dag/vim2hs",                  {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy "eagletmt/ghcmod-vim",         {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy "eagletmt/unite-haddock",      {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy "ujihisa/neco-ghc",            {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy "ujihisa/unite-haskellimport", {"autoload" : { "filetypes" : ["haskell"] }}

" gvim用 {{{
NeoBundleLazy 'thinca/vim-fontzoom'
NeoBundleLazy 'vim-scripts/errormarker.vim'
NeoBundleLazy 'ujihisa/unite-colorscheme'
"}}}
"}}}

" 個別プラグイン
" systemverilog_syntax,DirDiff,vim-systemc,gtags,vim-rtl
NeoBundleLocal $VIMHOME/.vim/plugins

"================================================
" .vimrc_local_bundle {{{
if filereadable(expand('$VIMHOME/.vimrc_local_bundle'))
  source $VIMHOME/.vimrc_local_bundle
endif
"}}}

" NeoBundleの処理が終わってから再度ON
filetype plugin on
" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
    \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif
"}}}

" -------------------------------------------------------------------
" 以下プラグイン設定
" -------------------------------------------------------------------
" neocomplete/neocomplcache関連 {{{
"
if s:meet_neocomplete_requirements()
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Use camel case completion.
  " let g:neocomplete#enable_camel_case_completion = 1
  " Use underbar completion.
  " let g:neocomplete#enable_underbar_completion = 1
  " Set minimum syntax keyword length.
  " let g:neocomplete#min_syntax_length = 3
  " let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  " Define dictionary.
  let g:neocomplete#dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }
  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'
  " ===============================================
  " Plugin key-mappings.
  " <CR>: close popup and save indent.
  inoremap <expr><CR>  neocomplete#close_popup() . "\<CR>"
  " <TAB>: completion.
  " inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y> neocomplete#close_popup()
  " inoremap <expr><C-e>  neocomplete#cancel_popup()
else
  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Use camel case completion.
  " let g:neocomplcache_enable_camel_case_completion = 1
  " Use underbar completion.
  " let g:neocomplcache_enable_underbar_completion = 1
  " Set minimum syntax keyword length.
  " let g:neocomplcache_min_syntax_length = 3
  " let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
  " Define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }
  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
  " ===============================================
  " Plugin key-mappings.
  " <CR>: close popup and save indent.
  inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
  " <TAB>: completion.
  " inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  " inoremap <expr><C-e>  neocomplcache#cancel_popup()
endif
"}}}

" -------------------------------------------------------------------
" neosnippet関連
"
" previewウィンドウを表示させない
set completeopt-=preview
" キーマップ
imap <C-p>     <Plug>(neosnippet_expand_or_jump)
smap <C-p>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" -------------------------------------------------------------------
" unite.vim関連 {{{
"
" 入力モードで開始する
" let g:unite_enable_start_insert = 1
" statuslineの上書きを行わない
let g:unite_force_overwrite_statusline = 0
" Bookmark一覧
nnoremap <silent> ,ub :<C-u>Unite bookmark<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register -direction=botright register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ヘルプ
nnoremap <silent> ,uh :<C-u>Unite -start-insert help<CR>
" ウィンドウを分割して開く
autocmd MyVimrc FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
autocmd MyVimrc FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
autocmd MyVimrc FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
autocmd MyVimrc FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
autocmd MyVimrc FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
autocmd MyVimrc FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
"}}}

" -------------------------------------------------------------------
" unite-tig関連 {{{
"
" ,ut に unite-tigマッピング
nnoremap <silent> ,ut :<C-u>Unite tig -no-split<CR>
"}}}

" -------------------------------------------------------------------
" vim-quickrun関連 {{{
"
" コンフィグを全クリア
let g:quickrun_config = {}
" 横分割をするようにする
" let g:quickrun_config['*'] = {'split': ''}
" コンフィグ設定
" http://d.hatena.ne.jp/osyo-manga/20120919/1348054752
let g:quickrun_config = {
    \ "_" : {
    \   "hook/close_unite_quickfix/enable_hook_loaded" : 1,
    \   "hook/unite_quickfix/enable_failure" : 1,
    \   "hook/close_quickfix/enable_exit" : 1,
    \   "hook/close_buffer/enable_failure" : 1,
    \   "hook/close_buffer/enable_empty_data" : 1,
    \   "outputter" : "multi:buffer:quickfix",
    \   "hook/shabadoubi_touch_henshin/enable" : 1,
    \   "hook/shabadoubi_touch_henshin/wait" : 20,
    \   "outputter/buffer/split" : ":botright 8sp",
    \   "outputter/buffer/into" : 1,
    \   "outputter/buffer/running_mark" : "",
    \   "outputter/quickfix/open_cmd" : '',
    \   "runner" : "vimproc",
    \   "runner/vimproc/updatetime" : 40,
    \ },
    \ "make" : {
    \   "command"   : "make",
    \   "exec"      : "%c %o %a",
    \   "outputter" : "error:buffer:quickfix",
    \   "runner"    : "vimproc",
    \ },
    \}
" Textile記法設定
let g:quickrun_config['textile'] = {
    \ 'command' : 'redcloth',
    \ 'exec'    : '%c  %s',
    \ }
    " \ 'outputter': 'browser'
" Markdown記法設定
let g:quickrun_config['markdown'] = {
    \ 'command' : 'bluefeather',
    \ 'exec'    : 'cat %s | %c -',
    \ }

"================================================
" -outputter-replace_region関連 {{{
"================================================
" 失敗した場合にエラーメッセージで置き換えられるので
" 成功した場合のみ置き換えるようなコマンドを定義
command! -nargs=* -range=0 -complete=customlist,quickrun#complete
  \ ReplaceRegion
  \ QuickRun
  \   -mode v
  \   -outputter error
  \   -outputter/success replace_region
  \   -outputter/error message
  \   -outputter/message/log 1
  \   -hook/unite_quickfix/enable 0
  \   <args>
"}}}
"}}}

" -------------------------------------------------------------------
" vim-watchdogs関連 {{{
"
" Setting
call watchdogs#setup(g:quickrun_config)
" 書き込み後にシンタックスチェックを行う
" let g:watchdogs_check_BufWritePost_enable = 1
" }}}

" -------------------------------------------------------------------
" vim-textobj-multiblock関連 {{{
"
" キーマップ設定
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
xmap ab <Plug>(textobj-multiblock-a)
xmap ib <Plug>(textobj-multiblock-i)
" 「」、（）に対応
let g:textobj_multiblock_blocks = [
  \ [ "(", ")" ],
  \ [ "[", "]" ],
  \ [ "{", "}" ],
  \ [ '<', '>' ],
  \ [ '"', '"' ],
  \ [ "'", "'" ],
  \ [ "「", "」" ],
  \ [ "（", "）" ],
  \]
" }}}

" -------------------------------------------------------------------
" vim-hier関連 {{{
"
" 波線で表示する場合は、以下の設定を行う
" エラーを赤字の波線で
" execute "highlight qf_error_ucurl cterm=undercurl ctermfg=Red gui=undercurl guisp=Red"
" let g:hier_highlight_group_qf  = "qf_error_ucurl"
" 警告を青字の波線で
" execute "highlight qf_warning_ucurl cterm=undercurl ctermfg=Blue gui=undercurl guisp=Blue"
" let g:hier_highlight_group_qfw = "qf_warning_ucurl"
"}}}

" -------------------------------------------------------------------
" Vimfiler関連 {{{
"
" Vimfilerをデフォルトのファイラーにする。
let g:vimfiler_as_default_explorer = 1
" safe_modeを解除する。
let g:vimfiler_safe_mode_by_default = 0
" タブで開くようにする。
let g:vimfiler_edit_action = 'tabopen'
" 引数なしの場合は VimFilerを起動
if has("gui_macvim")
  if has('vim_starting')
    if expand("%") == ""
      autocmd MyVimrc VimEnter * VimFiler -status
    endif
  endif
endif
" q で VimFilerを閉じる
autocmd MyVimrc FileType vimfiler nmap <buffer> q <Plug>(vimfiler_close)
" statuslineの上書きを行わない
let g:vimfiler_force_overwrite_statusline = 0

 " VimFiler の読み込みを遅延しつつデフォルトのファイラに設定 {{{
" イマイチだったので削除
"
" augroup LoadVimFiler
"     autocmd!
"     autocmd BufEnter,BufCreate,BufWinEnter * call <SID>load_vimfiler(expand('<amatch>'))
" augroup END
" " :edit {dir} や unite.vim などでディレクトリを開こうとした場合
" function! s:load_vimfiler(path)
"     if exists('g:loaded_vimfiler')
"         autocmd! LoadVimFiler
"         return
"     endif
"
"     let path = a:path
"     " for ':edit ~'
"     if fnamemodify(path, ':t') ==# '~'
"         let path = expand('~')
"     endif
"
"     if isdirectory(path)
"         NeoBundleSource vimfiler
"     endif
"
"     autocmd! LoadVimFiler
" endfunction
" " 起動時にディレクトリを指定した場合
" for arg in argv()
"     if isdirectory(getcwd().'/'.arg)
"         NeoBundleSource vimfiler
"         autocmd! LoadVimFiler
"         break
"     endif
" endfor
"}}}
" '/'カレントディレクトリ検索時に unite.vimを使用する。
" autocmd MyVimrc FileType vimfiler nnoremap <buffer><silent>/
"         \ :<C-u>Unite file -default-action=vimfiler<CR>
" unite bookmark->Enterにて移動
autocmd MyVimrc FileType vimfiler call unite#custom_default_action('directory', 'cd')
"}}}

" -------------------------------------------------------------------
" autodate.vim関連 {{{
"
let autodate_keyword_pre  = "Last Modified:"
let autodate_keyword_post = "."
"}}}

" -------------------------------------------------------------------
" caw.vim関連 {{{
"
" 行の2重化してコメントアウト
nmap <C-Enter> yy<Plug>(caw:i:comment)p
"}}}

" -------------------------------------------------------------------
" QFixHowm関連 {{{
"
" キーマップリーダー
let g:QFixHowm_Key = 'g'

let g:QFixHowm_HowmMode = 0
let g:QFixHowm_Title    = '#='
let g:QFixHowm_UserFileType = 'markdown'
let g:QFixHowm_UserFileExt  = 'md'

let g:qfixmemo_template = [ '%TITLE% ', '[%Y-%m-%d %H:%M]', ""]

let g:howm_filename     = '%Y/%m/%Y-%m-%d-%H%M%S.md'
let g:howm_fileencoding = 'utf-8'
let g:howm_fileformat   = 'unix'
" プレビューの無効
let g:QFix_PreviewEnable = 0

"================================================
" unite-qfixhowm 設定
"================================================
" 更新日順で表示する場合
call unite#custom_source('qfixhowm', 'sorters', 'sorter_qfixhowm_updatetime')
" 新規作成時の開き方
let g:unite_qfixhowm_new_memo_cmd = "tabnew"
" 起動
nnoremap <silent> ,u<Space> :<C-u>Unite qfixhowm/new qfixhowm:nocache
                             \ -hide-source-names -no-split<CR>

call unite#custom_default_action('qfixhowm' , 'tabopen')
"}}}

" -------------------------------------------------------------------
" vim-markdown-quote-syntax関連 {{{
"
" syntax追加
let g:markdown_quote_syntax_filetypes = {
  \ "vhdl" : {
  \   "start" : "vhdl",
  \},
  \ "verilog" : {
  \   "start" : "verilog",
  \},
  \ "systemverilog" : {
  \   "start" : "systemverilog",
  \},
\}
"}}}

" -------------------------------------------------------------------
" vim-anzu関連 {{{
"
" キーマップ設定
" nmap n <Plug>(anzu-n)
" nmap N <Plug>(anzu-N)
" nmap n nzz<Plug>(anzu-update-search-status)
" nmap N Nzz<Plug>(anzu-update-search-status)
nmap n <Plug>(anzu-jump-n)zz
nmap N <Plug>(anzu-N)zz
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)
" ESC2回押しで検索ハイライトを消去
nmap <silent> <ESC><ESC> :<C-u>nohlsearch<CR><Plug>(anzu-clear-search-status)
" format = (該当数/全体数)
let g:anzu_status_format = "(%i/%l)"
"}}}

" -------------------------------------------------------------------
" vim-over関連 {{{
"
" プロンプトの変更
let g:over_command_line_prompt = ">:"
"}}}

" -------------------------------------------------------------------
" lightline.vim関連 {{{
"
let g:lightline = {
  \ 'mode_map': {'c': 'NORMAL'},
  \ 'active' : {
  \   'left' : [ [ 'mode', 'paste' ], [ 'bufnum' ], [ 'filename' ] ],
  \   'right': [ [ 'lineinfo' ],
  \            [ 'percent' ],
  \            [ 'filetype', 'fileencoding', 'fileformat' ] ]
  \ },
  \ 'component': {
  \   'bufnum' : '#%n'
  \ },
  \ 'component_function': {
  \   'mode'         : 'MyMode',
  \   'modified'     : 'MyModified',
  \   'readonly'     : 'MyReadonly',
  \   'filename'     : 'MyFilename',
  \   'fileformat'   : 'MyFileformat',
  \   'filetype'     : 'MyFiletype',
  \   'fileencoding' : 'MyFileencoding'
  \ },
\ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '[+]' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ?  unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%') ? expand('%') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '') .
        \ anzu#search_status()
endfunction

function! MyFileformat()
  return &ft !~? 'vimfiler\|unite\|vimshell' ?
        \ winwidth('.') > 70 ? &fileformat : '' : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return &ft !~? 'vimfiler\|unite\|vimshell' ?
       \ winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : '' : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

"}}}

" -------------------------------------------------------------------
" vim-smartinput関連 {{{
"
" " 括弧内でのスペース入力補助
" call smartinput#map_to_trigger('i', '<Space>', '<Space>', '<Space>')
" """ ( )
" call smartinput#define_rule({
"      \ 'at'    : '(\%#)', 'char' : '<Space>',
"      \ 'input' : '<Space><Space><Left>',
"      \ })
" call smartinput#define_rule({
"      \ 'at'    : '( \%# )', 'char' : '<BS>',
"      \ 'input' : '<Del><BS>',
"      \ })
" """ [ ]
" call smartinput#define_rule({
"      \ 'at'    : '[\%#]', 'char' : '<Space>',
"      \ 'input' : '<Space><Space><Left>',
"      \ })
" call smartinput#define_rule({
"      \ 'at'    : '[ \%# ]', 'char' : '<BS>',
"      \ 'input' : '<Del><BS>',
"      \ })
" """ { }
" call smartinput#define_rule({
"      \ 'at'    : '{\%#}', 'char' : '<Space>',
"      \ 'input' : '<Space><Space><Left>',
"      \ })
" call smartinput#define_rule({
"      \ 'at'    : '{ \%# }', 'char' : '<BS>',
"      \ 'input' : '<Del><BS>',
"      \ })
" """ < >
" call smartinput#define_rule({
"      \ 'at'    : '<\%#>', 'char' : '<Space>',
"      \ 'input' : '<Space><Space><Left>',
"      \ })
" call smartinput#define_rule({
"      \ 'at'    : '< \%# >', 'char' : '<BS>',
"      \ 'input' : '<Del><BS>',
"      \ })
" " 改行時に行末スペースの除去
" call smartinput#define_rule({
"      \ 'at'    : '\s\+\%#', 'char': '<CR>',
"      \ 'input' : "<C-o>:call setline('.', substitute(getline('.'), '\\s\\+$', '', ''))<CR><CR>",
"      \ })
"}}}

" -------------------------------------------------------------------
" .vimrc_local {{{
if filereadable(expand('$VIMHOME/.vimrc_local'))
  source $VIMHOME/.vimrc_local
endif
"}}}

