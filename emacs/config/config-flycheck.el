
(dolist (mode-hook '(js-mode-hook
                     ruby-mode-hook
                     php-mode-hook
                     coffee-mode-hook
                     emacs-lisp-mode-hook))
  (add-hook mode-hook 'flycheck-mode-on))
