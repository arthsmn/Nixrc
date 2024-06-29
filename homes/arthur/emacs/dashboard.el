(setopt
 dashboard-center-content t
 dashboard-startup-banner 'logo
 dashboard-navigation-cycle t
 initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))

(dashboard-setup-startup-hook)
