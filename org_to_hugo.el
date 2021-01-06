#!/usr/local/bin/emacs --script

(setq gc-cons-threshold 134217728)   ; 128mb
(setenv "EMACSDIR" "~/.emacs.d")

;; Prioritize non-byte-compiled source files in non-interactive sessions to
;; prevent loading stale byte-code.
(setq load-prefer-newer t)

;; Ensure Doom runs out of this file's parent directory, where Doom is
;; presumably installed. EMACSDIR is set in the shell script preamble earlier in
;; this file.
(setq user-emacs-directory
      (if (getenv "EMACSDIR")
          (file-name-as-directory (expand-file-name (getenv "EMACSDIR")))
        (expand-file-name
         "../" (file-name-directory (file-truename load-file-name)))))

(message user-emacs-directory)

;; Small ugly temporary hack.
;; Load only required lisps from emacs doom packages
(mapc 'load (file-expand-wildcards "~/.emacs.d/.local/straight/repos/dash.el/dash.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/.local/straight/repos/s.el/s.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/.local/straight/repos/f.el/f.el"))

(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/helm/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/emacs-async/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/emacsql-sqlite3/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/emacsql/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/org-roam/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/org-roam-protocol/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/ox-hugo/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/org/")

(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/biblio.el/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/queue/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/org-ref/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/helm/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/citeproc-el/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/citeproc-org/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/emacs-htmlize/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/hydra/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/parsebib/")
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/helm-bibtex/")


(require 'org)
(require 'ox)
(require 'org-roam)
(require 'org-protocol)
(require 'ox-hugo)
(require 'org-ref)
(require 'citeproc-org-setup)

;; dont backup on exporting
(setq make-backup-files nil)
(setq org-directory "~/workspace/org/")
(setq org-roam-directory "~/workspace/org/roam")

(setq org-ref-default-bibliography `,(list (concat org-directory "/bibliography.bib")))
(setq reftex-default-bibliography org-ref-default-bibliography)

(citeproc-org-setup)

(defun benmezger/org-roam-export-all ()
  "Re-exports all Org-roam files to Hugo markdown."
  (interactive)
  (dolist (f (org-roam--list-all-files))
    (with-current-buffer (find-file f)
      (when (s-contains? "SETUPFILE" (buffer-string))
        (org-hugo-export-wim-to-md)))))

(defun benmezger/org-roam--backlinks-list (file)
  (when (org-roam--org-roam-file-p file)
    (mapcar #'car (org-roam-db-query
                   [:select :distinct [from]
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

(benmezger/org-roam-export-all)
