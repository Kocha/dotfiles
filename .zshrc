# Colors
autoload colors
colors
export CLICOLOR=true
# Prompt setting
# PROMPT="%{$fg[green]%}%n%(!.#.$) %{$reset_color%}"
PROMPT="%{$fg[green]%}kocha %(!.#.$) %{$reset_color%}"
PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]? %{$reset_color%}"
RPROMPT="%{$fg[cyan]%}[%~]%{$reset_color%}"
#
setopt auto_menu # tabで補完候補を選択
setopt auto_pushd # cdで勝手にpushd
setopt auto_list # 補完候補がある場合は一覧表示

