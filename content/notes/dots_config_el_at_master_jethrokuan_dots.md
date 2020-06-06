+++
title = "dots/config.el at master · jethrokuan/dots"
author = ["Ben Mezger"]
type = "posts"
draft = false
bookCollapseSection = true
+++

Source: <https://github.com/jethrokuan/dots/blob/0064ea2aab667f115a14ce48292731db46302c53/.doom.d/config.el#L488>

The following exports all roam files to Hugo and includes backlinks
pre-processor.

```emacs-lisp
 (defun jethro/org-roam-export-all ()
    "Re-exports all Org-roam files to Hugo markdown."
    (interactive)
    (dolist (f (org-roam--list-all-files))
      (with-current-buffer (find-file f)
        (when (s-contains? "SETUPFILE" (buffer-string))
          (org-hugo-export-wim-to-md)))))
  (defun jethro/org-roam--backlinks-list (file)
    (when (org-roam--org-roam-file-p file)
      (mapcar #'car (org-roam-db-query [:select :distinct [from]
                                        :from links
                                        :where (= to $s1)
                                        :and from :not :like $s2] file "%private%"))))
  (defun jethro/org-export-preprocessor (_backend)
    (when-let ((links (jethro/org-roam--backlinks-list (buffer-file-name))))
      (insert "\n** Backlinks\n")
      (dolist (link links)
        (insert (format "- [[file:%s][%s]]\n"
                        (file-relative-name link org-roam-directory)
                        (org-roam--get-title-or-slug link))))))
  (add-hook 'org-export-before-processing-hook #'jethro/org-export-preprocessor))
```
