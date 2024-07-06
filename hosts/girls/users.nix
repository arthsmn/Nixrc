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
      broot
      ormolu
      chromatic
      emacs-lsp-booster
      fd
      file
      foliate
      fragments
      ghc
      gitu
      haskell-language-server
      heroic
      libreoffice
      lime3ds
      markdown-oxide
      nixd
      nix-init
      nix-your-shell
      nodePackages.typescript-language-server
      ocrmypdf
      python311Packages.python-lsp-server
      # TODO: usar python padrão quando a versão for >= 3.13
      python313
      ripgrep
      rlwrap
      rust-analyzer-unwrapped
      ryujinx
      (rust-bin.stable.latest.default.override {extensions = ["rust-src"];})
      signal-desktop
      sops
      stremio
      gamescope
      gnome.dconf-editor
      tesseract
      trash-cli
      kitty
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
