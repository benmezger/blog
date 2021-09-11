+++
title = "Chezmoi and Emacs"
author = ["Ben Mezger"]
date = 2021-09-11T19:48:00-03:00
slug = "chezmoi_and_emacs"
tags = ["emacs", "dotfiles"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Emacs]({{<relref "2020-06-04--11-36-43Z--emacs.md#" >}})

---

I've recently wanted to integrate [Chezmoi](https://chezmoi.io) with Emacs, so I can avoid switching
to the terminal or `eshell` whenever I needed Chezmoi. I've searched for a few
Emacs and Chezmoi integration and I found [this](https://github.com/tuh8888/chezmoi.el). However, I wanted to play a
bit with Elisp, so I decided to write my own.

The code is still a work-in-progress, but I already have the basic functionality
set up.

`chezmoi.el` provides three functions: `apply`, `edit` and `diff` – all three run
asynchronously. All logs and diffs are stored in the `*chezmoi*` buffer.
Further, `chezmoi-mode` is a minor-mode that sets up keybindings for all three
functions.

The following variables are available: `chezmoi-bin`, `chezmoi-apply` and
`chezmoi-edit`.

```emacs-lisp
;;; chezmoi.el --- Handle chezmoi configuration -*- lexical-binding: t -*-
;;
;;; Author: Ben Mezger
;; https://github.com/benmezger
;;
;;; Commentary:
;; Work in progress.
;;
;;; Code:

(defvar chezmoi-bin "chezmoi"
  "Path to chezmoi's binary.")

(defvar chezmoi-flags "--color false -v --force -i noscripts"
  "Flags to pass to chezmoi in every run.")

(defun chezmoi-apply()
  "Run chezmoi apply without running scripts."
  (interactive)
  (apply 'start-process
         "chezmoi" "*chezmoi*"
         chezmoi-bin "apply" (split-string chezmoi-flags " "))
  (with-current-buffer "*chezmoi*"
    (diff-mode)))

(defun chezmoi-diff()
  "Run chezmoi diff."
  (interactive)
  (message "Running chezmoi diff...")
  (apply 'start-process
         "chezmoi" "*chezmoi*"
         chezmoi-bin "diff" (split-string chezmoi-flags " "))
  (with-current-buffer "*chezmoi*"
    (diff-mode)
    (read-only-mode)))

(defun chezmoi-edit()
  "Edit a chezmoi file."
  (interactive)
  (ivy-read "File: "
            (process-lines chezmoi-bin "managed")
            :require-match t
            :action
            (lambda (n)
              (find-file
               (nth 0 (process-lines
                       chezmoi-bin "source-path"
                       (expand-file-name (concat "~/" n))))))))

(define-minor-mode chezmoi-mode
  "Enable chezmoi functionality."
  :lighter " chezmoi"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c A") 'chezmoi-apply)
            (define-key map (kbd "C-c E") 'chezmoi-edit)
            (define-key map (kbd "C-c D") 'chezmoi-diff)
            map))

(provide 'chezmoi)

;;; chezmoi.el ends here

```


## TODOs {#todos}

These are things I want to implement.


### <span class="org-todo todo TODO">TODO</span> Open `*chezmoi*` buffer as a popup buffer {#open-chezmoi-buffer-as-a-popup-buffer}


### <span class="org-todo todo TODO">TODO</span> Differentiate between .tmpl files, similar to diff-mode, magit, etc {#differentiate-between-dot-tmpl-files-similar-to-diff-mode-magit-etc}


### <span class="org-todo todo TODO">TODO</span> Open Chezmoi configuration function {#open-chezmoi-configuration-function}
