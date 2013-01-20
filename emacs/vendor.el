
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor"))

(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
(autoload 'hideshowvis-minor-mode "hideshowvis"
  "Will indicate regions foldable with hideshow in the fringe."
  'interactive)

(autoload 'slime-js "slime-js")
(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurence of CHAR")

(provide 'tung-vendor)
