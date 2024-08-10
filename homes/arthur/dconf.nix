{pkgs, ...}: {
  # TODO: salvar customizações de extensões
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
      auto-raise = true;
      num-workspaces = 5;
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
        appindicator
        blur-my-shell
        forge
        gnome-bedtime
        just-perfection
        legacy-gtk3-theme-scheme-auto-switcher
        night-theme-switcher

        light-style
      ]);
    };

    "org/gnome/mutter" = {
      center-new-windows = true;
      dynamic-workspaces = false;
      auto-maximize = false;
    };

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
