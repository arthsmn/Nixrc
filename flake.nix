{
  description = "Configuração do meu sistema";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprcursor-phinger = {
      url = "github:jappie3/hyprcursor-phinger";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";
    ghostty-hm-module.url = "github:clo4/ghostty-hm-module";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./nixosModules;
    homeManagerModules = import ./homeManagerModules;

    nixosConfigurations = {
      girls = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = with inputs; [
          disko.nixosModules.disko
          lanzaboote.nixosModules.lanzaboote
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          nix-index-database.nixosModules.nix-index
          nix-flatpak.nixosModules.nix-flatpak
          ./hosts/girls/default.nix
        ];
      };
    };
  };
}
