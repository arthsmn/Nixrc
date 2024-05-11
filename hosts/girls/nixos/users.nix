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
      bottles
      brave
      fd
      fragments
      libreoffice-qt
      markdown-oxide
      nickel
      nil
      nix-init
      nix-your-shell
      nls
      ocrmypdf
      python311Packages.python-lsp-server
      # TODO: usar python padrão quando a versão for >= 3.13
      python313
      ripgrep
      rust-analyzer-unwrapped
      (rust-bin.stable.latest.default.override {extensions = ["rust-src"];})
      signal-desktop
      sops
      stremio
      gnome.dconf-editor
      tesseract
      trash-cli
      tree
      wget
      wl-clipboard
      zls
    ];
  };

  users.defaultUserShell = pkgs.fish;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.arthur = import ./../../../homes/arthur/home.nix;
    extraSpecialArgs = {inherit inputs outputs;};
  };
}
