;;; early-init.el --- Initialization -*- lexical-binding: t; -*-
(setq gs-cons-threshold most-positive-fixnum
      byte-compile-warnings '(not obsolete)
      warning-suppress-log-types '((comp) (bytecomp))
      native-comp-async-report-warning-errors 'silent

      inhibit-startup-echo-area-message (user-login-name)
      frame-resize-pixelwise t ;; resolve problemas de wms com o emacs

      package-enable-at-startup nil)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq no-littering-var-directory (expand-file-name "emacs/" (getenv "XDG_DATA_HOME"))
      no-littering-etc-directory user-emacs-directory)

(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "emacs/eln-cache/" (getenv "XDG_CACHE_HOME")))))
