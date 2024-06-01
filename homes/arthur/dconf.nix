{...}: {
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
    "org/gnome/shell" = {
      disabled-user-extensions = false;
      enabled-extensions = ["blur-my-shell@aunetx" "appindicatorsupport@rgcjonas.gmail.com" "forge@jmmaranan.com"];
    };
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
      auto-raise = true;
    };
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
      font-antialiasing = "rgba";
      monospace-font-name = "Sarasa Term Slab CL 11";
    };
    "org/gnome/mutter" = {
      center-new-windows = true;
    };
    "org/gnome/shell/extensions/forge/keybindings" = {
      window-swap-last-active = ["<Control><Super>Return"];
    };
  };
}
