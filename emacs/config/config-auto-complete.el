
(require 'auto-complete-config)

(defvar tung/ac-base-sources
  '(ac-source-filename
    ac-source-yasnippet
    ac-source-dictionary
    ac-source-words-in-buffer
    ac-source-words-in-same-mode-buffers))

(eval-after-load 'auto-complete
  '(progn
     (ac-config-default)
     (setq-default ac-sources tung/ac-base-sources)
     (setq ac-auto-start nil
           ac-show-menu nil
           ac-use-menu-map t
           ac-candidate-limit 100
           ac-disable-inline t
           ac-quick-help-delay 0.2
           ac-use-fuzzy t
           ac-trigger-key "M-/"
           ac-comphist-file "~/.emacs.d/data/ac-comphist.dat")

     (setq tab-always-indent 'complete)
     (add-to-list 'completion-styles 'initials t)
     (add-hook 'auto-complete-mode-hook
               (lambda ()
                 (setq completion-at-point-functions '(auto-complete))))

     (tung/fill-keymap ac-complete-mode-map
                       "C-n" 'ac-next
                       "C-p" 'ac-previous
                       "C-l" 'ac-expand-common
                       "ESC" 'ac-stop)

     (defadvice linum-update
       (around tung/suppress-linum-update-when-popup activate)
       (unless (ac-menu-live-p)
         ad-do-it))))

(defun tung/append-ac-sources (mode-sources)
  (setq ac-sources (append mode-sources tung/ac-base-sources)))


(provide 'config-auto-complete)
