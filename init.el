(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq-default org-src-fontify-natively t)
(setq-default org-src-preserve-indentation t)
(setq-default org-src-tab-acts-natively t)

(org-babel-load-file (expand-file-name "/home/xw/.emacs.d/my-init.org"))
