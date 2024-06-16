(setopt
 dashboard-center-content t
 dashboard-startup-banner 'logo
 dashboard-items '((recents   . 5)
                   (bookmarks . 5)
                   (projects  . 5)
                   (agenda    . 5)
                   (registers . 5))
 dashboard-startupify-list '(dashboard-insert-banner
			     dashboard-insert-newline
			     dashboard-insert-banner-title
			     dashboard-insert-newline
			     dashboard-insert-navigator
			     dashboard-insert-newline
			     dashboard-insert-init-info
			     dashboard-insert-items
			     dashboard-insert-newline
			     dashboard-insert-footer)
 dashboard-navigation-cycle t
 initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))

(dashboard-setup-startup-hook))
