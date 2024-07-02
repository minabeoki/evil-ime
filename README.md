# evil-ime.el

## What?

When using Evil in Emacs to write in Japanese, you need to be mindful of
both the mode switching in Evil (normal, insert, etc.) and the ON/OFF
state of the IME.

To input Japanese text starting from Evil's normal mode and then return to
normal mode, you need to following steps:

1. Switch to Evil's insert mode with `i`.
2. Turn ON the IME.
3. Input Japanese text.
4. Turn OFF the IME.
5. Return to Evil's normal mode with `ESC`.

For example, if you forget step 4 and return to normal mode, trying to
move the cursor with `j`, `k`, will result in the input being taken by
the IME, which is undesirable.

This evil-ime automatically turns OFF the IME in Evil's normal mode and
restores the previous IME state when switching to insert mode.

1. Switch to Evil's insert mode with `i`
   (if the IME was ON in the previous insert mode, it will automatically turn ON)
2. Input Japanese text.
3. Return to Evil's normal mode with `ESC`
   (the IME will automatically turn OFF)

You don't need to change the IME state when changing modes in Evil.

## Install

Place the .el file in a directory included in the load-path and add the
following to your ~/.emacs.d/init.el:

```
(require 'evil-ime)
```

Or

```
(use-package evil-ime)
```

## Limitations

It is only supported in the Emacs Mac Port for macOS.

https://bitbucket.org/mituharu/emacs-mac/
https://github.com/railwaycat/homebrew-emacsmacport

-----

## What?

Emacsで[Evil](https://github.com/emacs-evil/evil)を使いながら日本語を
書く場合、Evilのモード切り替え(normal, insertなど)と、IMEのON/OFFの
両方を意識して、入力操作をする必要があります。

Evilのnormalモードの状態から日本語テキストを入力して、その後normalモードに
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
insert modeになった場合は以前のinsert mode時のIME状態を復元します。

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

または

```
(use-package evil-ime)
```

## Limitations

macOSのEmacs Mac PortのEmacsのみに対応しています。

https://bitbucket.org/mituharu/emacs-mac/
https://github.com/railwaycat/homebrew-emacsmacport
