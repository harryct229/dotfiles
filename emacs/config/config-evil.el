
(evil-mode t)
(surround-mode t)

(eval-after-load 'evil
  '(progn
     (require 'sackspace)
     (sack/install-in-evil)

     (setq evil-move-cursor-back nil
           evil-mode-line-format nil
           evil-find-skip-newlines nil

           evil-shift-width 2
           evil-flash-delay 1
           evil-echo-state nil
           evil-complete-all-buffers nil

           evil-emacs-state-cursor '("orange" box))

     (evil-set-toggle-key "<f12>")
     ;; (evil-set-initial-state 'nrepl-mode 'emacs)
     (evil-set-initial-state 'nrepl-popup-buffer-mode 'emacs)
     (evil-set-initial-state 'epa-key-list-mode 'emacs)
     (evil-set-initial-state 'ack-mode 'emacs)

     (tung/fill-keymap evil-normal-state-map
                       "C-j" (icalled (next-line 10))
                       "C-k" (icalled (previous-line 10))
                       "<tab>" 'evil-jump-item
                       "j" 'evil-next-visual-line
                       "k" 'evil-previous-visual-line
                       "M-=" 'cleanup-buffer

                       "gp" 'x-clipboard-yank

                       "C-:" 'eval-expression

                       "C-e" 'end-of-line

                       "SPC" 'evil-toggle-fold
                       "zc" 'evil-close-folds
                       "zo" 'evil-open-folds

                       "RET" 'evil-ex-nohighlight)

     (tung/fill-keymap evil-insert-state-map
                       "C-a" 'back-to-indentation
                       "C-e" 'end-of-line
                       "C-h" 'delete-backward-char

                       "M-h" " => "
                       "M-a" "@"
                       "M-q" 'balance-tags)

     (tung/fill-keymap evil-visual-state-map
                       "Y" (lambda (beg end)
                             (interactive "r")
                             (let ((x-select-enable-clipboard t))
                               (kill-ring-save beg end)))
                       "<tab>" (kbd ">gv")
                       "<backtab>" (kbd "<gv")
                       "C-a" 'align-regexp)

     (evil-add-hjkl-bindings ibuffer-mode-map)

     ;; Fix for input state
     (add-hook 'evil-insert-state-exit-hook
               (lambda () (setq evil-input-method nil)))
     ))


(provide 'config-evil)
