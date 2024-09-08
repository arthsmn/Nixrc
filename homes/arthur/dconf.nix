{pkgs, ...}: {
  # TODO: salvar customizações de extensões
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
      auto-raise = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
      minimize = [];
    };

    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
      font-antialiasing = "rgba";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      # TODO: usar filter + hasPrefix para não precisar repetir. (O problema é que a lista de pacotes é de derivações)
      enabled-extensions = map (f: f.extensionUuid) (with pkgs.gnomeExtensions; [
        alphabetical-app-grid
        blur-my-shell
        caffeine
        gnome-bedtime
        hot-edge
        just-perfection
        legacy-gtk3-theme-scheme-auto-switcher
        night-theme-switcher
        pop-shell

        light-style
      ]);
    };

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
