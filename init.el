;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(defvar myPackages
  '(cyberpunk-theme
    ein
    elpy
    flycheck
    magit
    crux
    exec-path-from-shell
    auto-highlight-symbol
    smartparens
    back-button
    py-autopep8))

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-refresh-contents)
            (package-install package)))
      myPackages)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ace-window
  :ensure t
  :init
  (global-set-key [remap other-window] 'ace-window))

;; swiper
(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    ))

;; BASIC CONFIG
;; --------------------------------------
(require 'smartparens)
(require 'crux)
(require 'company)

;; smartparens
(add-hook 'prog-mode-hook 'turn-on-smartparens-mode)

;; auto-highlight-symbol
(global-auto-highlight-symbol-mode)
(define-key auto-highlight-symbol-mode-map (kbd "M-p") 'ahs-backward)
(define-key auto-highlight-symbol-mode-map (kbd "M-n") 'ahs-forward)
(setq ahs-idle-interval 1.0)

(setq inhibit-startup-message t) 

(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(column-number-mode t)
(global-linum-mode t)
(setq ring-bell-function 'ignore)

(load-theme 'cyberpunk t) ;; load cyberpunk theme

;; Set default font
(set-face-attribute 'default nil
                    :family "Ubuntu Mono"
                    :height 120
                    :weight 'normal
                    :slant 'normal
                    :width 'normal)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
(setq ibuffer-default-sorting-mode 'major-mode)

;; PROGRAMMING CONFIGURATION
;; --------------------------------------
;; use space to indent by default
(setq-default tab-width 4)


;; PYTHON CONFIGURATION
;; uses company for completion
;; --------------------------------------
(elpy-enable)
;;(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;; C++ CONFIGURATION
;; --------------------------------------
(defun my-c++-mode-hook ()
  (flycheck-mode)
  (company-mode)
  (setq flycheck-clang-language-standard "c++14"))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'flycheck-mode)

(setq c-default-style "linux"
      c-basic-offset 4)

(sp-local-pair 'c++-mode "{" nil :post-handlers
               '((my-create-newline-and-enter-sexp "RET")))

(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))


;; Keyboard Shortcuts
;; --------------------------------------
(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-c s") 'crux-transpose-windows)
(global-set-key (kbd "C-c o") 'crux-open-with)
(global-set-key (kbd "C-c n") 'crux-cleanup-buffer-or-region)
(global-set-key (kbd "C-c I") 'crux-find-user-init-file)
(global-set-key (kbd "C-c w") 'wdired-change-to-wdired-mode)

(global-set-key (kbd "C-c W") 'whitespace-mode)
;; TODO: define this only in python mode
;; (define-key elpy-mode (kbd "C-=") 'elpy-goto-definition)
(global-set-key (kbd "C-=") 'elpy-goto-definition)
(global-set-key (kbd "C--") 'pop-tag-mark)

(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-n") 'company-select-next)


;; TODO
;; --------------------------------------
;; consider removing indentation highlighting in python
;; C-s stops at line
;; python auto-pep8?
;; breadcrumb
;; auto-complete in ipython
;; highlight symbol only highlights in current view
;; c++14 or later

;; init.el ends here
