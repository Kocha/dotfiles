" vim: set ts=4 sw=4 sts=0 foldmethod=marker:
" -------------------------------------------------------------------
" System関連

"vi互換の動きにしない
set nocompatible
"左右のカーソル移動で行間移動可能にする。
"set whichwrap=b,s,<,>,[,],h,l
set whichwrap=b,s,<,>,[,]
" 選択した文字をクリップボードに入れる(自動)
set clipboard=unnamed,autoselect
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
" set smartindent
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
" ファイル内の <Tab> が対応する空白の数
set tabstop=4
" ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P
" ステータスラインに日時を追加表示する
function! g:Date()
  return strftime("%x %H:%M")
endfunction
set statusline+=\ \%{g:Date()}
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
set fillchars=num:\|

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
" Undo拡張
set undofile
set undodir=~/.undo
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
\   AllMaps map <args> | map! <args> | lmap <args>
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
noremap <C-a> 0
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
nnoremap <ESC><ESC> :nohlsearch<CR>
" 検索後画面の中心に。
nnoremap n nzz
nnoremap N Nzz
" カーソル部分から行末までコピー
nnoremap Y y$
" 行の二重化
nnoremap <C-Enter> yypk
" 行削除
nnoremap <S-Enter> dd
" Blog用
nnoremap ,re :%s/<\(p\\|\/p\\|br\s*\/*\)>//g<CR>:%s/\n<hr/<hr/g<CR>:%s/<hr\s\/>\n/<hr \/>/g<CR>
"================================================
" Insertモード関係
"================================================
" 挿入モード時に、行頭/行末へ移動
inoremap <C-e> <ESC>A
inoremap <C-a> <ESC>0i
" <C-V> Clipboardから貼り付け
inoremap <C-v> <ESC>"*pa
" 挿入モード時に、カーソル移動
" inoremap <C-H> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
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
cnoremap <C-a> <Home>
" %% を入力すると現在編集中のファイルのフォルダのパスを展開
if has('win32')
  cnoremap %% <C-r>=expand('%:p:h').'\'<cr>
else
  cnoremap %% <C-r>=expand('%:p:h').'/'<cr>
endif
" クリップボードから貼り付け
cnoremap <C-v> <C-r>+
" -------------------------------------------------------------------
" ファイル別指定
" 
"================================================
" Help {{{
"================================================
" q で閉じる
au FileType help nnoremap q :q<CR>
" }}}
"================================================
" Markdown {{{
"================================================
" 拡張子設定[*.md, *.mkd]
augroup FileMarkdown
  autocmd!
  autocmd BufRead,BufNewFile *.md,*.mkd call <SID>file_markdown()
augroup END
function! s:file_markdown()
  setfiletype markdown
  set fileencoding=UTF-8
  autocmd! FileMarkdown
endfunction
" Shift+Enterにて<br>タグ挿入
au FileType markdown inoremap <S-Enter> <br /><CR>
" }}}
"================================================
" Template {{{
"================================================
" 新規ファイルの際に挿入する。
autocmd BufNewFile *.h,*.c,*.cpp 0r $HOME/.vim/template/template.h
autocmd BufNewFile *.vim 0r $HOME/.vim/template/template.vim
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
augroup vimgrepopen
  autocmd!
  autocmd QuickFixCmdPost vimgrep cw
augroup END
" -------------------------------------------------------------------
" HelpGrep関連
"
" :helpgrep検索後に unite-quickfixを開く
augroup helpgrepopen
  autocmd!
  autocmd QuickFixCmdPost helpgrep Unite quickfix
augroup END
" -------------------------------------------------------------------
" QuickFix関連
"
" Quickfixウィンドウだけの場合に自動で閉じる
augroup qfautoclose
  autocmd!
  " Auto-close quickfix window
  autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
augroup END
" -------------------------------------------------------------------
" 標準プラグイン関連
"
" source $VIMRUNTIME/macros/matchit.vim

" -------------------------------------------------------------------
" プラグイン管理(NeoBundle) {{{
" 
set nocompatible           " be iMproved
filetype plugin indent off " required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

" Plugins List
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vinarise' 
NeoBundle 'Shougo/neocomplcache' 
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
NeoBundle "osyo-manga/shabadou.vim"
NeoBundle "osyo-manga/vim-watchdogs"
NeoBundle "osyo-manga/unite-qfixhowm"
NeoBundle "osyo-manga/quickrun-outputter-replace_region"
NeoBundle "osyo-manga/vim-textobj-multiblock"
" NeoBundle 'jceb/vim-hier'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/multi-vim'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'mattn/excitetranslate-vim'
" NeoBundle 'gregsexton/VimCalc'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'godlygeek/tabular'
NeoBundle 'tsukkee/unite-help'
NeoBundle "kana/vim-textobj-user"
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'tpope/vim-surround'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'vim-scripts/DrawIt'
NeoBundle 'vim-scripts/Colour-Sampler-Pack'
NeoBundle 'vim-jp/vimdoc-ja'

NeoBundle 'supermomonga/shaberu.vim'
NeoBundle 't9md/vim-textmanip'
"================================================
" NeoBundleLazy List {{{
"================================================
NeoBundleLazy 'Shougo/vimfiler', {
\   'autoload' : { 'commands' : [ "VimFilerTab", "VimFiler", "VimFilerExplorer" ] }
\}
NeoBundleLazy 'Shougo/vimshell', {
\   'autoload' : { 'commands' : [ 'VimShell' ] }
\}
" Markdown, Textile
NeoBundleLazy "hallison/vim-markdown",  {"autoload" : { "filetypes" : ["markdown"] }}
NeoBundleLazy "timcharper/textile.vim", {"autoload" : { "filetypes" : ["textile"] }}
" haskell
NeoBundleLazy "dag/vim2hs",                  {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy "eagletmt/ghcmod-vim",         {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy "eagletmt/unite-haddock",      {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy "ujihisa/neco-ghc",            {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy "ujihisa/unite-haskellimport", {"autoload" : { "filetypes" : ["haskell"] }}

" gvim用 {{{
NeoBundleLazy 'thinca/vim-fontzoom'
NeoBundleLazy 'Lokaltog/vim-powerline'
NeoBundleLazy 'vim-scripts/errormarker.vim'
NeoBundleLazy 'ujihisa/unite-colorscheme'
"}}}
"}}}

" 個別プラグイン
" systemverilog_syntax,DirDiff,vim-systemc,gtags,vim-rtl
NeoBundleLocal ~/.vim/plugins

"" NeoBundleの処理が終わってから再度ON
" filetype plugin indent on
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
" neocomplcache関連 {{{
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
" ===============================================
" Plugin key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
" inoremap <expr><C-e>  neocomplcache#cancel_popup()
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
" ZenCoding関連
" 
" TABインデントをスペースに変更する。
let g:user_zen_settings = { 'indentation':'    ' }

" -------------------------------------------------------------------
" unite.vim関連 {{{
" 
" 入力モードで開始する
" let g:unite_enable_start_insert = 1
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
" ヘルプ
nnoremap <silent> ,uh :<C-u>Unite -start-insert help<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
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
let g:quickrun_config['*'] = {'split': ''}
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
    \   "runner" : "vimproc",
    \   "runner/vimproc/updatetime" : 40,
    \ },
    \ "make" : {
    \   "command"   : "make",
    \   "exec"      : "%c %o",
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
  \     -mode v
  \     -outputter error
  \     -outputter/success replace_region
  \     -outputter/error message
  \     -outputter/message/log 1
  \     -hook/unite_quickfix/enable 0
  \     <args>
"}}}
"}}}

" -------------------------------------------------------------------
" vim-watchdogs関連
" 
" Setting
call watchdogs#setup(g:quickrun_config)
" 書き込み後にシンタックスチェックを行う
" let g:watchdogs_check_BufWritePost_enable = 1

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
      autocmd VimEnter * VimFiler -status
    endif
  endif
endif
" q で VimFilerを閉じる
autocmd FileType vimfiler nmap <buffer> q <Plug>(vimfiler_close)
" VimFiler の読み込みを遅延しつつデフォルトのファイラに設定 {{{
augroup LoadVimFiler
    autocmd!
    autocmd BufEnter,BufCreate,BufWinEnter * call <SID>load_vimfiler(expand('<amatch>'))
augroup END
" :edit {dir} や unite.vim などでディレクトリを開こうとした場合
function! s:load_vimfiler(path)
    if exists('g:loaded_vimfiler')
        autocmd! LoadVimFiler
        return
    endif

    let path = a:path
    " for ':edit ~'
    if fnamemodify(path, ':t') ==# '~'
        let path = expand('~')
    endif

    if isdirectory(path)
        NeoBundleSource vimfiler
    endif

    autocmd! LoadVimFiler
endfunction
" 起動時にディレクトリを指定した場合
for arg in argv()
    if isdirectory(getcwd().'/'.arg)
        NeoBundleSource vimfiler
        autocmd! LoadVimFiler
        break
    endif
endfor
"}}}
" '/'カレントディレクトリ検索時に unite.vimを使用する。
" autocmd FileType vimfiler nnoremap <buffer><silent>/ 
"         \ :<C-u>Unite file -default-action=vimfiler<CR>
"}}}

" -------------------------------------------------------------------
" memolist.vim関連 {{{
" 
" let g:memolist_path = "$HOME/Blog"
" let g:memolist_memo_suffix = "md"
" " tag/categoryを入力
" let g:memolist_prompt_tags = 1
" let g:memolist_prompt_categories = 1
" " MemolistでVimFilerを使用する
" let g:memolist_vimfiler = 1
" let g:memolist_template_dir_path = "$HOME/.vim/template/memolist"
"}}}

" -------------------------------------------------------------------
" autodate.vim関連 {{{
"
let autodate_keyword_pre  = "Last Modified:"
let autodate_keyword_post = "."
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

"================================================
" unite-qfixhowm 設定
"================================================
" 更新日順で表示する場合
call unite#custom_source('qfixhowm', 'sorters', 'sorter_qfixhowm_updatetime')
" 新規作成時の開き方
let g:unite_qfixhowm_new_memo_cmd = "tabnew"
" 起動
nnoremap <silent> ,u<Space> :<C-u>Unite qfixhowm/new qfixhowm:nocache 
                             \ -hide-source-names -auto-preview -no-split<CR>

call unite#custom_default_action('qfixhowm' , 'tabopen')
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

