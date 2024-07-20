{
  lib,
  pkgs,
  config,
  inputs,
  outputs,
  ...
}: {
  users.users.arthur = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."user_passwords/arthur".path;
    description = "Arthur";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "input" "lp"];
    packages = (with pkgs; [
      adw-gtk3
      alejandra
      bottles
      brave
      chromatic
      clang
      clang-tools
      dconf-editor
      emacs29-pgtk
      emacs-lsp-booster
      fd
      file
      foliate
      fragments
      fzf
      gamescope
      gitu
      gnome-graphs
      kryptor
      libreoffice
      man-pages
      man-pages-posix
      markdown-oxide
      moreutils
      nixd
      nix-init
      nix-tree
      nix-your-shell
      ocrmypdf
      ripgrep
      signal-desktop
      sops
      stremio
      tesseract
      trash-cli
      tree
      unzip
      wget
      wl-clipboard
    ]) ++ [
      (inputs.wrapper-manager.lib.build {
        inherit pkgs;
        modules = lib.pipe (builtins.readDir ../../wrappers) [
          (lib.filterAttrs (name: value: value == "directory"))
          builtins.attrNames
          (map (n: ../../wrappers/${n}))
        ];
        specialArgs = {
          inherit inputs;
          nixcfg = config;
        };
      })
    ];
  };

  users.defaultUserShell = pkgs.fish;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.arthur = import ./../../homes/arthur/home.nix;
    extraSpecialArgs = {inherit inputs outputs;};
  };
}
