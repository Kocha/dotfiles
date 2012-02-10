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
" MacVim限定にしとかないと端末Windowが変化する "
if has('gui_macvim')
  set columns=100
  set lines=150
endif

" GUIフォント設定
if has("gui_running")
  if has("gui_gtk2")
    :set guifont=DejaVu\ Sans\ Mono\ 11
  elseif has("x11")
  " Also for GTK 1
    :set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
  elseif has("gui_win32")
    :set guifont=Luxi_Mono:h12:cANSI
  endif
endif

" -------------------------------------------------------------------
" キーマップ関連
" 
" Tab作成
nnoremap <C-T> <ESC>:tabnew<CR>
" Tab移動
nnoremap <C-TAB> <ESC>:tabNext<CR>

