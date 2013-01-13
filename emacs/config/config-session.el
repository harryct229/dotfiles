
(require 'minimal-session-saver)
(setq minimal-session-saver-less-feedback t
      minimal-session-saver-data-file (expand-file-name "~/.emacs.d/data/sessions.el"))

(eval-after-load 'minimal-session-saver
  '(tung/fill-keymap (current-global-map)
                  "C-c s" 'minimal-session-saver-store
                  "C-c l" 'minimal-session-saver-load))

(add-hook 'kill-emacs-hook
          (lambda ()
            (when (delq nil (mapcar 'buffer-file-name (buffer-list)))
              (minimal-session-saver-store))))

(provide 'config-session)
