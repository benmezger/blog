+++
title = "Ox-hugo export all roam to Hugo"
author = ["Ben Mezger"]
date = 2020-06-04T08:39:00
slug = "ox_hugo_export_all_roam_to_hugo"
tags = ["emacs", "orgmode", "hugo", "orgroam", "roam"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Emacs]({{<relref "2020-06-04--11-36-43Z--emacs.md#" >}})
    -   [Org-mode]({{<relref "2020-06-04--11-35-15Z--org_mode.md#" >}})
    -   [Org-roam]({{<relref "2020-06-04--11-51-18Z--org_roam.md#" >}})
    -   [Export org-roam backlinks with Gohugo]({{<relref "2021-03-07--17-40-57Z--export_org_roam_backlinks_with_gohugo.md#" >}})

---

Export all org-roam files to Hugo markdown (this might take some time)

From: [jethrokuan/dots](https://github.com/jethrokuan/dots/blob/0064ea2aab667f115a14ce48292731db46302c53/.doom.d/config.el#L488)

```emacs-lisp
(defun benmezger/org-roam-export-all ()
  "Re-exports all Org-roam files to Hugo markdown."
  (interactive)
  (dolist (f (org-roam--list-all-files))
    (with-current-buffer (find-file f)
      (when (s-contains? "SETUPFILE" (buffer-string))
        (org-hugo-export-wim-to-md)))))
```

Adding an empty `#+SETUPFILE:` forces `benmezger/org-roam-export-all` to export
the file.
