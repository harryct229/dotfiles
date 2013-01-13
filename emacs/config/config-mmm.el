
(require 'mmm-auto)
(eval-after-load 'mmm-mode
 '(progn
    (setq mmm-global-mode 'maybe)
    (mmm-add-mode-ext-class 'html-mode "\\.php\\'" 'html-php)))


(provide 'config-mmm)
