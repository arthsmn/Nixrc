{
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
    packages = with pkgs; [
      alejandra
      bottles
      brave
      cargo
      chromatic
      clang
      clippy
      dconf-editor
      fd
      file
      foliate
      fragments
      gamescope
      ghc
      gitu
      gnome-graphs
      haskell-language-server
      heroic
      libreoffice
      lime3ds
      markdown-oxide
      nixd
      nix-init
      nix-tree
      nix-your-shell
      ocrmypdf
      ormolu
      python312Packages.python-lsp-server
      python313 # TODO: usar python padrão quando a versão for >= 3.13
      ripgrep
      rust-analyzer
      rustc
      rustfmt
      ryujinx
      signal-desktop
      sops
      stremio
      tesseract
      trash-cli
      tree
      unzip
      wget
      wl-clipboard
      zls
    ];
  };

  users.defaultUserShell = pkgs.fish;

  services.flatpak = {
    enable = true;
    packages = [
      "io.mrarm.mcpelauncher"
    ];
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.arthur = import ./../../homes/arthur/home.nix;
    extraSpecialArgs = {inherit inputs outputs;};
  };
}
