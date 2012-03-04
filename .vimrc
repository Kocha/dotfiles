" vim: set ts=4 sw=4 sts=0:
" -------------------------------------------------------------------
" System関連

"vi互換の動きにしない
set nocompatible
"左右のカーソル移動で行間移動可能にする。
"set whichwrap=b,s,<,>,[,],h,l
set whichwrap=b,s,<,>,[,]
" 選択した文字をクリップボードに入れる
set clipboard=unnamed
" コメント行にてEnterキー入力後コメントになる動作を解除
" ft=vimでは効果なし() "set fo-=ro
autocmd FileType * setlocal formatoptions-=ro
" backspaceの拡張
set backspace=start,eol,indent

" -------------------------------------------------------------------
" Display関連
" 
" テーマ色
"colorscheme evening "colorscheme
colorscheme ron "colorscheme
" ステータスバーを常に表示
set laststatus=2
" 行数の表示
set number
" ステータスバーに表示
set ruler
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
set smartindent
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
" ファイル内の <Tab> が対応する空白の数
set tabstop=4
" ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P
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
if exists('&ambiwidth')
  set ambiwidth=double
endif
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
set numberchar=\|

" -------------------------------------------------------------------
" syntax color
" 
syntax on
"highlight LineNr ctermfg=darkgrey

" -------------------------------------------------------------------
" 検索関連
" 
" 検索時に大/小文字を区別しない
set ignorecase
" 検索時に大文字を含んでいたら大/小を区別
set smartcase
" 検索をファイルの先頭へループしない
set nowrapscan
" 検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch
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
" 最後に編集した部分にカーソルを移動
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" 文字がない部分でも矩形選択可能にする
set virtualedit=block

" -------------------------------------------------------------------
" キーマップ関連
" 
"================================================
" Normal+Virtualモード関係
"================================================
" バッファ移動用キーマップ
" F2: 前のバッファ
" F3: 次のバッファ
" F4: バッファ削除
noremap <F2> <ESC>:bp<CR>
noremap <F3> <ESC>:bn<CR>
noremap <F4> <ESC>:bw<CR>
" 行頭/行末へ移動
noremap <C-A> 0
noremap <C-E> $
"================================================
" Normalモード関係
"================================================
" 表示行単位で行移動する
nnoremap j gj
nnoremap k gk
" ESC2回押しで検索ハイライトを消去
nnoremap <ESC><ESC> :nohlsearch<CR>
"================================================
" Insertモード関係
"================================================
" 挿入モード時に、行頭/行末へ移動
inoremap <C-E> <ESC>A
inoremap <C-A> <ESC>0i
" <C-V> Clipboad copy
inoremap <C-V> <ESC>"*pa
" 挿入モード時に、カーソル移動
inoremap <C-H> <Left>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-L> <Right>
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
" <C-A>で先頭へ
cnoremap <C-A> <Home>

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
augroup grepopen
    autocmd!
    autocmd QuickFixCmdPost vimgrep cw
augroup END
" -------------------------------------------------------------------
" 標準プラグイン関連
"
source $VIMRUNTIME/macros/matchit.vim

" -------------------------------------------------------------------
" プラグイン管理(NeoBundle)
" 
set nocompatible           " be iMproved
filetype plugin indent off " required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" Plugins 
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache' 
NeoBundle 'Shougo/neocomplcache-snippets-complete' 
NeoBundle 'Shougo/vimfiler' 
NeoBundle 'Shougo/vinarise' 
NeoBundle 'ZenCoding.vim'
NeoBundle 'DrawIt'
NeoBundle 'thinca/vim-fontzoom'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-rtputil'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'taku-o/vim-toggle'
NeoBundle 'tyru/eskk.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'Lokaltog/vim-powerline'
" NeoBundle 'jceb/vim-hier'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'mattn/webapi-vim'
" NeoBundle 'mattn/calendar-vim'
NeoBundle 'gregsexton/VimCalc'
" NeoBundle 'houtsnip/vim-emacscommandline'
" NeoBundle 'vim-scripts/SingleCompile'
NeoBundle 'vim-scripts/errormarker.vim'
NeoBundle 'vim-jp/vimdoc-ja'

" NeoBundle 'Kocha/vim-systemc'
"" NeoBundleの処理が終わってから再度ON
filetype plugin indent on

" -------------------------------------------------------------------
" プラグイン管理(rtputil)
" 
"call rtputil#bundle()
call rtputil#helptags()
" call rtputil#append('~/.vim/plugins/systemc_syntax')
call rtputil#append('~/.vim/plugins/systemverilog_syntax')
" call rtputil#append('~/.vim/plugins/systemverilog_snippets')
call rtputil#append('~/.vim/plugins/tcomment')
call rtputil#append('~/.vim/plugins/DirDiff')
call rtputil#append('~/.vim/plugins/vim-systemc')
" call rtputil#append('~/.vim/plugins/vim-divination')

" -------------------------------------------------------------------
" 以下プラグイン設定
" -------------------------------------------------------------------
" neocomplcache関連
" 
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
" IMEがおかしくなる問題回避
" let g:neocomplcache_enable_prefetch = 1

" ===============================================
" Plugin key-mappings.
imap <C-P>     <Plug>(neocomplcache_snippets_expand)
smap <C-P>     <Plug>(neocomplcache_snippets_expand)
" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
" inoremap <expr><C-e>  neocomplcache#cancel_popup()

" For cursor moving in insert mode(Not recommended)
" inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
" inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
" inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
" inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"

" -------------------------------------------------------------------
" ZenCoding関連
" 
" TABインデントをスペースに変更する。
let g:user_zen_settings = { 'indentation':'    ' }

" -------------------------------------------------------------------
" unite.vim関連
" 
" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" -------------------------------------------------------------------
" vim-quickrun関連
"
" コンフィグを全クリア
let g:quickrun_config = {}
" 横分割をするようにする
let g:quickrun_config['*'] = {'split': ''}
" :QuickRun -outputter my_outputter
" プロセスの実行中は、buffer に出力し、
" プロセスが終了したら、quickfix へ出力を行う
" http://d.hatena.ne.jp/osyo-manga/20110729/1311934261
" http://d.hatena.ne.jp/osyo-manga/20110921/1316605254
" 既存の outputter をコピーして拡張
let my_outputter = quickrun#outputter#multi#new()
let my_outputter.config.targets = ["buffer", "quickfix"]

function! my_outputter.init(session)
    " quickfix を閉じる
    :cclose
    " 元の処理を呼び出す
    call call(quickrun#outputter#multi#new().init, [a:session], self)
endfunction

function! my_outputter.finish(session)
    call call(quickrun#outputter#multi#new().finish, [a:session], self)
    " 出力バッファの削除
    bwipeout [quickrun
    " vim-hier を使用している場合は、ハイライトを更新
    :HierUpdate
    " quickfix への出力後に quickfixstatus を有効に
    :QuickfixStatusEnable
endfunction
" quickrun に outputter を登録
call quickrun#register_outputter("my_outputter", my_outputter)
" <leader>r を再定義
nmap <silent> <leader>r :QuickRun -outputter my_outputter<CR>

" -------------------------------------------------------------------
" vim-hier関連
" 
" 波線で表示する場合は、以下の設定を行う
" エラーを赤字の波線で
" execute "highlight qf_error_ucurl cterm=undercurl ctermfg=Red gui=undercurl guisp=Red"
" let g:hier_highlight_group_qf  = "qf_error_ucurl"
" 警告を青字の波線で
" execute "highlight qf_warning_ucurl cterm=undercurl ctermfg=Blue gui=undercurl guisp=Blue"
" let g:hier_highlight_group_qfw = "qf_warning_ucurl"

" -------------------------------------------------------------------
" Vimfiler関連
" 
" Vimfilerをデフォルトのファイラーにする。
let g:vimfiler_as_default_explorer = 1

" -------------------------------------------------------------------
" matchit.vim関連
" 
let b:match_words = "begin:end,if:end if,if:end,case:endcase,function:endfunction"

