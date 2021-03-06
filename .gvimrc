" vim: set ts=4 sw=4 sts=0:
" -------------------------------------------------------------------
" System関連
"
" 選択しただけでクリップボードにコピー
set guioptions+=a

" -------------------------------------------------------------------
" Display関連
"
" テーマ色
colorscheme koehler
" タブを常に表示
set showtabline=2 "タブを常に表示
" 選択行にアンダーラインを引く
highlight CursorLine gui=underline guifg=NONE guibg=NONE
" Windowサイズ指定
if has('gui_macvim')
  set columns=100
  set lines=150
endif
" GUIフォント設定
if has("gui_running")
  if has("gui_gtk2")
    " set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
    " set guifont=Liberation\ Mono\ for\ Powerline\ 11
    set guifont=Ricty\ for\ Powerline\ 12
  elseif has("x11")
  " Also for GTK 1
    set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
  elseif has("gui_win32")
    set guifont=Luxi_Mono:h12:cANSI
  endif
endif
" 半透明設定
if has("gui_win32")
  " kaoriya版限定
  set transparency=220
elseif has("gui_macvim")
  set transparency=35
endif

" -------------------------------------------------------------------
" キーマップ関連
"
"================================================
" Normalモード関係
"================================================
" Tab作成
" nnoremap <C-t> <ESC>:tabnew<CR>
" Tab移動
nnoremap <C-TAB> <ESC>:tabnext<CR>
nnoremap <S-C-TAB> <ESC>:tabNext<CR>
"================================================
" コマンドライン関係
"================================================
" クリップボードから貼り付け
cnoremap <RightMouse> <C-r>+

" -------------------------------------------------------------------
" マウスに関する設定:
"
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide

" -------------------------------------------------------------------
" プラグイン管理(NeoBundle)
"
NeoBundleSource vim-fontzoom
NeoBundleSource errormarker.vim
NeoBundleSource unite-colorscheme

" -------------------------------------------------------------------
" .gvimrc_local {{{
if filereadable(expand('$VIMHOME/.gvimrc_local'))
  source $VIMHOME/.gvimrc_local
endif
"}}}
