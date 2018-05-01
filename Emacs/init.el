;; 対応する括弧のハイライト
(show-paren-mode 1)
;; カーソル行をハイライトする
(global-hl-line-mode t)
;; C-hをdeleteに割り当てる
(keyboard-translate ?\C-h ?\C-?)
;; バックアップファイルを作成させない
(setq make-backup-files nil)
;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)
;; シフト＋矢印で範囲選択
(setq pc-select-selection-keys-only t)
(pc-selection-mode 1)
;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-max "(CR)")
(setq eol-mnemonic-unix "(LF)")
;; 列数を表示する
(column-number-mode t)
;; "yes or no"を"y or n"にする
(fset 'yes-or-no-p 'y-or-n-p)