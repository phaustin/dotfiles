; snippet to allow insertion of a string in a marked region
(defun highlight-region (string)
  "Inserts STRING at the beginning of every line in the region."
  (interactive "sString to insert: ")
  (save-excursion
    (if (bolp)
	(forward-line -1))
    (save-restriction 
      (narrow-to-region (point) (mark))
      (goto-char (point-min))
      (replace-regexp "^" string))))

(provide 'highlight-region)
