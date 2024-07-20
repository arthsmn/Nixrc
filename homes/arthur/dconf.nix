{...}: {
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
    "org/gnome/shell" = {
      disabled-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "forge@jmmaranan.com"
        "just-perfection-desktop@just-perfection"
        "legacyschemeautoswitcher@joshimukul29.gmail.com"
        "nightthemeswitcher@romainvigier.fr"
      ];
    };
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
      auto-raise = true;
    };
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
      font-antialiasing = "rgba";
      monospace-font-name = "Sarasa Term CL 13";
    };
    "org/gnome/mutter" = {
      center-new-windows = true;
    };
  };
}
