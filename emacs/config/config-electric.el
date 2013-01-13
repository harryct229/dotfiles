
;; (electric-layout-mode t)
(electric-pair-mode t)
(electric-indent-mode t)

(eval-after-load 'evil
  '(progn
     (defun tung/electric-layout ()
       (when (and (looking-at "}") t)
         (evil-open-above 0)))
     (defadvice evil-ret (after tung/electric-layout activate)
       (tung/electric-layout))
     (defadvice js2-enter-key (after tung/electric-layout activate)
       (tung/electric-layout))))

(provide 'config-electric)
