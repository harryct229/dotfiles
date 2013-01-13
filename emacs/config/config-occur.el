
(defun multi-occur-buffers-this-mode ()
  "Show all matching REGEX in buffers with this major mode"
  (interactive)
  (multi-occur
   (tung/buffers-of-mode major-mode)
   (car (occur-read-primary-args))))


(provide 'config-occur)
