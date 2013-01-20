
(eval-after-load 'multiple-cursors
  '(progn
     (setq mc/list-file "~/.emacs.d/data/mc-lists.el")
     (add-to-list 'mc/unsupported-minor-modes 'autopair-mode)
     (add-to-list 'mc/unsupported-minor-modes 'evil-mode)

     (global-set-key (kbd "C-d") 'mc/mark-next-like-this)
     (global-set-key (kbd "C-S-d") 'mc/mark-all-like-this)))

;; (eval-after-load 'evil
;;   '(progn
;;      (add-hook 'multiple-cursors-mode-enabled-hook #'evil-insert-state)
;;      (add-hook 'multiple-cursors-mode-disabled-hook #'evil-normal-state)))

(provide 'config-multiple-cursors)
