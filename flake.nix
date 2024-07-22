{
  outputs = {
    self,
      nixpkgs,
      ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (outputs.myLib) forAllSystems;
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/homeManager;
    myLib = import ./lib {inherit nixpkgs;};

    nixosConfigurations = {
      girls = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = with inputs;
          [
            disko.nixosModules.disko
            lanzaboote.nixosModules.lanzaboote
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            lix-module.nixosModules.default
            nix-index-database.nixosModules.nix-index
          ]
          ++ [./hosts/girls/default.nix];
      };
    };
  };
  
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

    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
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

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";
  };
}
