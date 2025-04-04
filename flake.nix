{
  description = "Home Manager configuration of jakeh";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixCats = {
      url = "github:BirdeeHub/nixCats-nvim";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    linuxPkgs = nixpkgs.legacyPackages."x86_64-linux";
    macosPkgs = nixpkgs.legacyPackages."aarch64-darwin";

    jakehHome = home-manager.lib.homeManagerConfiguration {
      pkgs = linuxPkgs;
      extraSpecialArgs = {
        inherit (self) inputs;
        wellKnown = {
          username = "jakeh";
          homeDirectory = "/home/jakeh";
        };
      };

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./homes/jakeh-nixos.nix
        ./nvim/default.nix
        ./sops/default.nix
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
    macosHome = home-manager.lib.homeManagerConfiguration {
      pkgs = macosPkgs;
      extraSpecialArgs = {
        inherit (self) inputs;
        wellKnown = {
          username = "jake";
          homeDirectory = "/Users/jake";
        };
      };

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./homes/jake-macos.nix
        ./nvim/default.nix
        ./sops/default.nix
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  in {
    homeConfigurations."jakeh" = jakehHome;
    packages.aarch64-darwin.default = macosHome.activationPackage;
  };
}
