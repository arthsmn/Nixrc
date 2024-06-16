(setopt
 gc-cons-threshold 10000000
 byte-compile-warnings '(not obsolete)
 warning-suppress-log-types '((comp) (bytecomp))
 native-comp-async-report-warnings-errors 'silent)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(setopt
 frame-resize-pixelwise t
 default-frame-alist '((fullscreen . maximized)
                       (background-color . "#000000")
                       (ns-appearance . dark)
                       (ns-transparent-titlebar . t)))

(setopt
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)

(pixel-scroll-precision-mode)

(savehist-mode)
