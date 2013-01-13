
(define-fringe-bitmap 'hs-marker [0 24 24 126 126 24 24 0])
(define-fringe-bitmap 'hideshowvis-hideable-marker [0 0 0 124 56 16 0 0])

(defun tung/hsvis-overlay (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (let* ((marker-string "*fringe-dummy*")
           (marker-length (length marker-string))
           (display-string " ..."))
      (put-text-property 0 marker-length 'display
                         (list 'left-fringe 'hs-marker 'hs-fringe-face)
                         marker-string)
      (overlay-put ov 'before-string marker-string)
      (put-text-property 0 (length display-string) 'face 'hs-face display-string)
      (overlay-put ov 'display display-string))))

(eval-after-load 'hideshowvis
  '(progn
     ;; (set-face-attribute 'hs-face nil :box nil :foreground "#deae3e")
     (setq hs-hide-comments-when-hiding-all nil
           hs-set-up-overlay 'tung/hsvis-overlay
           hs-isearch-open t)))

(defadvice imenu (after unfold-it activate)
  (hs-show-block))


(provide 'config-hideshow)
