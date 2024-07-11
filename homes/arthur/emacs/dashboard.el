(setopt
 dashboard-center-content t
 dashboard-startup-banner 'logo
 dashboard-navigation-cycle t
 initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name))
 dashboard-items '((recents   . 5)
                   ;; (bookmarks . 5)
                   (projects  . 5)
                   ;; (agenda    . 5)
                   ;; (registers . 5)
		   ))

(dashboard-setup-startup-hook)
