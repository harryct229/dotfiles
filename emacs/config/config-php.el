
(tung/add-auto-mode 'php-mode
                    '("\\.php$" "\\.tpl$" "\\.ctp$"))

(defun tung/setup-php-mode ()
  (interactive)
  (tung/setup-programming-environment)
  ;; (tung/set-doc-function #'tung/php-doc-function)
  (c-set-offset 'case-label '+)
  (c-set-offset 'arglist-intro #'tung/php-lineup-arglist-intro)
  (c-set-offset 'arglist-close #'tung/php-lineup-arglist-close)
  (zencoding-mode t))

(add-hook 'php-mode-hook #'tung/setup-php-mode)

(eval-after-load 'php-mode
  '(progn
     (setq php-manual-path "~/build/php-chunked-xhtml/"
           php-basic-offset 2
           php-blank-line-at-end-of-class t
           php-blank-line-at-start-of-class t)))

(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'php-mode))

(eval-after-load 'which-func
  '(add-to-list 'which-func-modes 'php-mode))


(defun tung/php-lineup-arglist-intro (langelem)
  (save-excursion
    (goto-char (cdr langelem))
    (vector (+ (current-column) c-basic-offset))))

(defun tung/php-lineup-arglist-close (langelem)
  (save-excursion
    (goto-char (cdr langelem))
    (vector (current-column))))

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
