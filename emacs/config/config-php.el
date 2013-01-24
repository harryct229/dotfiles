
(tung/add-auto-mode 'php-mode
                    '("\\.php$" "\\.tpl$" "\\.ctp$"))

(defun tung/setup-php-mode ()
  (interactive)
  (tung/setup-programming-environment)
  (php-enable-pear-coding-style)
  (zencoding-mode t))

(add-hook 'php-mode-hook #'tung/setup-php-mode)

(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'php-mode))

(eval-after-load 'which-func
  '(add-to-list 'which-func-modes 'php-mode))

(defun tung/php-doc-function ()
  "Lookup PHP documentation"
  (interactive)
  (when (user-variable-p 'php-manual-path)
    (let* ((func (thing-at-point 'symbol))
           (file (replace-regexp-in-string "_" "-" func))
           (path (symbol-value 'php-manual-path))
           (command (format "cat %sfunction.%s.html" path file))
           (buf (shell-command-to-string command))
           (prototype (when (string-match "<div class=\"methodsynopsis dc-description\">\\(\\(.\\|\n\\)*?\\)</div>" buf)
                        (tung/strip-tags (match-string 1 buf))))
           (usage (when (string-match "<p class=\"para rdfs-comment\">\\(\\(.\\|\n\\)*?\\)</p>" buf)
                    (concat "\n\n" (tung/strip-tags (match-string 1 buf))))))
      (concat prototype usage))))


(provide 'config-php)
