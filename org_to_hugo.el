(require 'org-roam)
(require 'citeproc-org-setup)

(citeproc-org-setup)

(remove-hook! 'find-file-hook #'+org-roam-open-buffer-maybe-h)

(defadvice! +editorconfig--inhibit-in-org-exports-a (orig-fn &rest args)
  :around '(org-export-to-file org-babel-tangle)
  (let ((editorconfig-exclude-regexps '(".")))
    (apply orig-fn args)))

(defun benmezger/org-roam-export-all ()
  "Re-exports all Org-roam files to Hugo markdown."
  (interactive)
  (dolist (f (org-roam--list-all-files))
    (with-current-buffer (find-file f)
      (when (s-contains? "SETUPFILE" (buffer-string))
        (org-hugo-export-wim-to-md)))))
