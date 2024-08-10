(setq gs-cons-threshold most-positive-fixnum
      package-enable-at-startup nil)

(setq byte-compile-warnings '(not obsolete)
      warning-suppress-log-types '((comp) (bytecomp))
      native-comp-async-report-warning-errors 'silent)

(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      frame-title-format '("%b")
      ring-bell-function 'ignore
      use-dialog-box nil
      use-file-dialog nil
      use-short-answers t
      inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-x-resources t
      inhibit-startup-echo-area-message user-login-name
      inhibit-startup-buffer-menu t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(fringe-mode -1)

(setq no-littering-etc-directory (expand-file-name "emacs/" (getenv "XDG_DATA_HOME"))
      no-littering-var-directory (expand-file-name "emacs/" (getenv "XDG_CACHE_HOME")))

(when (fboundp 'startup-redirect-eln-cache)
(startup-redirect-eln-cache
 (convert-standard-filename
  (expand-file-name  "eln-cache/" no-littering-var-directory))))

(defvar prev-file-name-handler-alist file-name-handler-alist)
(defvar prev-vc-handled-backends vc-handled-backends)

(setq file-name-handler-alist nil
      vc-handled-backends nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist prev-file-name-handler-alist
                  vc-handled-backends prev-vc-handled-backends)))
