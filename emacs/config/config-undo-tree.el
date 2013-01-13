
(global-undo-tree-mode t)

(eval-after-load 'undo-tree
  '(progn
     ;; This is currently broken
     ;(setq undo-tree-auto-save-history t
     ;      undo-tree-history-directory-alist
     ;      '(("." . "~/.emacs.d/data/undos/")))
     ;(defadvice undo-tree-make-history-save-file-name
     ;  (after undo-tree activate)
     ;  (setq concat ad-return-value ".gz"))
     ))


(provide 'config-undo-tree)
