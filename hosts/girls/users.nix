{
  lib,
  pkgs,
  config,
  inputs,
  outputs,
  ...
}: let
  inherit (outputs.myLib) listOfDirs;

  wrapper-manager-build = inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = listOfDirs ../../wrappers;
    specialArgs = {
      inherit inputs;
      nixcfg = config;
    };
  };
in {
  users.users.arthur = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."user_passwords/arthur".path;
    description = "Arthur";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "input" "lp"];
    packages =
      (with pkgs; [
        adw-gtk3
        alejandra
        bottles
        brave
        chromatic
        dconf-editor
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
        sbcl
        signal-desktop
        sops
        tesseract
        trash-cli
        tree
        unzip
        wget
        wl-clipboard

        clang-tools
        clang

        luajitPackages.fennel
        fennel-ls
        fnlfmt

        cargo-watch
        (fenix.stable.withComponents [
          "cargo"
          "clippy"
          "rust-analyzer"
          "rust-src"
          "rustc"
          "rustfmt"
        ])
      ])
      ++ [wrapper-manager-build];
  };

  users.defaultUserShell = pkgs.fish;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.arthur = import ./../../homes/arthur/home.nix;
    extraSpecialArgs = {inherit inputs outputs;};
  };
}
