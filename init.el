;; disable auto-save and auto-backup
;; (setq auto-save-default nil)
;; (setq make-backup-files nil)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . "/tmp/emacs.tmp")))
(setq auto-save-file-name-transforms
      `((".*" "/tmp/emacs.tmp" t)))

;; effective emacs http://steve.yegge.googlepages.com/effective-emacs
(global-set-key "\C-s"     'isearch-forward-regexp)
(global-set-key "\C-r"     'isearch-backward-regexp)
(global-set-key "\C-x\C-b" 'ibuffer)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-w"     'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key "\C-c\C-r" 'revert-buffer)

;; auto fill disable
(auto-fill-mode -1)
(set-default 'fill-column 200)

;; window movement
(global-set-key [S-left]  'windmove-left)
(global-set-key [S-right] 'windmove-right)
(global-set-key [S-up]    'windmove-up)
(global-set-key [S-down]  'windmove-down)

;;; Movement in iTerm2
(define-key input-decode-map "\e[1;5A" [C-up])
(define-key input-decode-map "\e[1;5B" [C-down])
(define-key input-decode-map "\e[1;5C" [C-right])
(define-key input-decode-map "\e[1;5D" [C-left])

;;; window control
(global-set-key "\M-1" 'delete-other-windows)
(global-set-key "\M-2" 'split-window-vertically)
(global-set-key "\M-3" 'split-window-horizontally)
(global-set-key "\M-0" 'delete-window)

(setq dired-listing-switches "-alh")                     ;; dired

(line-number-mode 1)                                     ;; show line numbers
(column-number-mode 1)                                   ;; show column numbers

(add-hook 'before-save-hook 'delete-trailing-whitespace) ;; remove trailing whitespace on save
(setq require-final-newline t)                           ;; add final newline on save

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))      ;; scroll one line at a time
(setq mouse-wheel-progressive-speed nil)                 ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                       ;; scroll window under mouse
(setq scroll-step 1)                                     ;; keyboard scroll one line at a time


(setq ring-bell-function 'ignore)                        ;; disable bells completely

(if (not window-system) (menu-bar-mode -1))              ;; disable menu bar

(defalias 'yes-or-no-p 'y-or-n-p)                        ;; short confirmations

;;; recent file
(require 'recentf)
(recentf-mode 1)
(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let* ((file-assoc-list
          (mapcar (lambda (x) (cons (file-name-nondirectory x) x)) recentf-list))
         (filename-list
          (cl-remove-duplicates (mapcar #'car file-assoc-list)
                             :test #'string=))
         (filename (ido-completing-read "Choose recent file: "
                                        filename-list
                                        nil
                                        t)))
    (when filename
      (find-file (cdr (assoc filename file-assoc-list))))))

(setq ido-use-virtual-buffers t)

(global-set-key "\C-xf" 'recentf-ido-find-file)
