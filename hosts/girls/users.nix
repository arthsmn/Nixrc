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
    extraGroups = ["networkmanager" "wheel" "libvirtd" "input"];
    packages = with pkgs; [
      alejandra
      blackbox-terminal
      bottles
      brave
      ormolu
      chromatic
      emacs-lsp-booster
      fd
      file
      foliate
      fragments
      ghc
      haskell-language-server
      heroic
      libreoffice
      lime3ds
      markdown-oxide
      nixd
      nix-init
      nix-your-shell
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
      gnome.dconf-editor
      tesseract
      # texliveBasic
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
