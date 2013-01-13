
(defun tung/setup-haskell-mode ()
  (interactive)
  (tung/setup-programming-environment)
  (turn-on-haskell-indentation))

(add-hook 'haskell-mode-hook #'tung/setup-haskell-mode)

(provide 'config-haskell)
