+++
title = "Org-roam export backlinks on Hugo"
author = ["Ben Mezger"]
date = 2020-06-04T08:29:00-03:00
slug = "org_roam_export_backlinks_on_hugo"
tags = ["orgmode", "emacs"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Org-mode]({{<relref "2020-06-04--11-35-15Z--org_mode.md#" >}})
    -   [Emacs]({{<relref "2020-06-04--11-36-43Z--emacs.md#" >}})
    -   [Org-roam]({{<relref "2020-06-04--11-51-18Z--org_roam.md#" >}})
    -   [dots/config.el at master · jethrokuan/dots]({{<relref "dots_config_el_at_master_jethrokuan_dots.md#" >}})
    -   [Export org-roam backlinks with Gohugo]({{<relref "2021-03-07--17-40-57Z--export_org_roam_backlinks_with_gohugo.md#" >}})

---

> ❗️\*Note:\* This no longer applies (probably due to an upstream update). See the
> following note for another approach: [Export org-roam backlinks with Gohugo]({{<relref "2021-03-07--17-40-57Z--export_org_roam_backlinks_with_gohugo.md#" >}})

Insert roam backlinks URL when exporting orgmode to HTML

From: [jethrokuan/dots](https://github.com/jethrokuan/dots/blob/0064ea2aab667f115a14ce48292731db46302c53/.doom.d/config.el#L495)

```emacs-lisp
 (defun benmezger/org-roam-export-all ()
    "Re-exports all Org-roam files to Hugo markdown."
    (interactive)
    (dolist (f (org-roam--list-all-files))
      (with-current-buffer (find-file f)
        (when (s-contains? "SETUPFILE" (buffer-string))
          (org-hugo-export-wim-to-md)))))
  (defun benmezger/org-roam--backlinks-list (file)
    (when (org-roam--org-roam-file-p file)
      (mapcar #'car (org-roam-db-query [:select :distinct [from]
                                        :from links
                                        :where (= to $s1)
                                        :and from :not :like $s2] file "%private%"))))
  (defun benmezger/org-export-preprocessor (_backend)
    (when-let ((links (benmezger/org-roam--backlinks-list (buffer-file-name))))
      (insert "\n** Backlinks\n")
      (dolist (link links)
        (insert (format "- [[file:%s][%s]]\n"
                        (file-relative-name link org-roam-directory)
                        (org-roam--get-title-or-slug link))))))
  (add-hook 'org-export-before-processing-hook #benmezger/org-export-preprocessor))
```