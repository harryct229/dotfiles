
(tung/add-auto-mode 'coffee-mode
                    '("\\.coffee$" "Cakefile"))

(defun tung/setup-coffee-mode ()
  (interactive)
  (tung/setup-programming-environment))

(add-hook 'coffee-mode-hook #'tung/setup-coffee-mode)

;; TODO: adapt to skewer-mode
(eval-after-load 'slime-js
  '(progn
     (defadvice slime-js-eval-region
       (around slime-js-coffee-eval-region (beg end &optional func) activate)
       (if (eq major-mode 'coffee-mode)
           (let ((current-buffer (buffer-name)))
             (setq coffee-args-compile
                   (append coffee-args-compile '("-b")))
             (coffee-compile-region beg end)
             (switch-to-buffer coffee-compiled-buffer-name)
             (slime-js-eval-buffer)
             (delete "-b" coffee-args-compile)
             (switch-to-buffer current-buffer)
             (slime-flash-region beg end))
         ad-do-it))))


(provide 'config-coffee)
