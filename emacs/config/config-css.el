
(defun tung/setup-css-mode ()
  (interactive)
  (tung/setup-programming-environment)
  (setq css-indent-offset 2
        imenu-generic-expression
        `(("Selector"
           ,(concat "^\\([ \t]*[^@:{}\n][^:{}]+\\(?::"
                    (regexp-opt css-pseudo-ids t)
                    "\\(?:([^)]+)\\)?[^:{\n]*\\)*\\)\\(?:\n[ \t]*\\)*{")
           1)))
  (tung/fill-keymap css-mode-map "C-c C-s" #'css-helper-explain)
  (rainbow-mode t))

(add-hook 'css-mode-hook #'tung/setup-css-mode)

(eval-after-load 'which-func
  '(progn
     (add-to-list 'which-func-modes 'css-mode)
     (add-to-list 'which-func-modes 'scss-mode)))

(eval-after-load 'auto-complete
  '(progn
     (add-to-list 'ac-modes 'css-mode)
     (add-hook 'css-mode-hook
               (lambda ()
                 (tung/append-ac-sources '(ac-source-css-property))))))




(provide 'config-css)