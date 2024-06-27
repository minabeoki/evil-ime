# evil-ime.el

## What?

Emacsで[Evil](https://github.com/emacs-evil/evil)を使いながら日本語を
書く場合、Evilのモード切り替え(normal, insertなど)と、IMEのON/OFFの
両方を意識して、入力操作をする必要があります。

Evilのnormalモードから日本語テキストを入力して、その後normalモードに
戻るには、

1. `i`でEvilのinsert modeにする
2. IMEをONにする
3. 日本語を入力する
4. IMEをOFFにする
5. `ESC`でEvilのnormal modeに戻る

という手順が必要です。例えば上記の4.をせずにnormal modeに戻ると、
`j`, `k`とかでカーソル移動しようとして、IMEに入力が取られて残念な
ことになります。

このevil-imeは、Evilのnormal modeでは自動でIMEをOFFにして、
insert modeになった場合は以前のinsert mode時のIME状態に戻します。

1. `i`でEvilのinsert modeにする
   (以前のinsert modeでIME ONだったら、自動でIME ONになる)
2. 日本語を入力する
3. `ESC`でEvilのnormal modeに戻る
   (IMEは自動でOFFになる)

つまり、Evilのモード変更時にはIME変更しなくて良いということです。

## Install

.elファイルをload-pathの通ったディレクトリに置いて、
~/.emacs.d/init.elに以下を書いてください。

```
(require 'evil-ime)
```

## Bugs

現状、バッファ切り替えなどすると、うまくいきません。
`buffer-list-update-hook`とか`window-configuration-change-hook`とかで
対処しようとしたけど、誤動作したりする…
