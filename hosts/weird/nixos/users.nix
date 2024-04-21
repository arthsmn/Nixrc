{
  pkgs,
  config,
  inputs,
  outputs,
  ...
}: {
  users.users = {
    arthur = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."user_passwords/arthur".path;
      description = "Arthur";
      extraGroups = ["networkmanager" "wheel" "lp" "lpadmin" "libvirtd" "input"];
      packages = with pkgs; [
        fd
        markdown-oxide
        nls
        nickel
        nil
        nix-init
        nix-your-shell
        ocrmypdf
        # TODO: usar python padrão quando a versão for >= 3.13
        python313
        python311Packages.python-lsp-server
        ripgrep
        rust-analyzer-unwrapped
        (rust-bin.stable.latest.default.override {extensions = ["rust-src"];})
        signal-desktop
        sops
        stremio
        tesseract
        trash-cli
        tree
        wget
        wl-clipboard
        zls
      ];
    };

    bb = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."user_passwords/bb".path;
      description = "B&B";
      extraGroups = ["networkmanager" "lp" "lpadmin"];
      packages = with pkgs; [
        dropbox
        irpf
      ];
    };
  };

  users.defaultUserShell = pkgs.fish;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.arthur = import ../homeManager/home.nix;
    extraSpecialArgs = {inherit inputs outputs;};
  };
}
