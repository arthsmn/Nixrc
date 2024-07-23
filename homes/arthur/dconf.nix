{...}: {
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
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
