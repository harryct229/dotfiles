
(defvar tung/he-base-sources
  '(try-expand-dabbrev
    try-expand-dabbrev-all-buffers
    try-expand-dabbrev-from-kill
    try-expand-line))

(setq hippie-expand-try-functions-list tung/he-base-sources
      hippie-expand-verbose nil)

(defun tung/append-he-sources (mode-sources)
  (set (make-local-variable 'hippie-expand-try-functions-list)
       (append tung/he-base-sources mode-sources)))


(eval-after-load 'evil
  '(progn
     (setq evil-complete-next-func 'hippie-expand
           evil-complete-previous-func 'hippie-expand)
     (defun tung/sane-tab (arg)
       (interactive "*P")
       (if (looking-at "\\_>")
           (hippie-expand arg)
         (tab-to-tab-stop)))
     (tung/fill-keymap evil-insert-state-map
                       "<tab>" 'tung/sane-tab
                       "<backtab>" (icalled he-reset-string))))


(provide 'config-hippie-expand)
