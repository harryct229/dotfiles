
(eval-after-load 'deft
  '(progn
     (setq deft-directory "~/Dropbox/Notes"
           deft-extension "md"
           deft-text-mode 'markdown-mode
           deft-use-filename-as-title t)))

(eval-after-load 'evil-leader
  '(progn
     (evil-leader/set-key
       "n" 'deft)
     (evil-set-initial-state 'deft-mode 'emacs)))


(provide 'config-deft)
