{
  description = "My first flake!";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # Makes sure that 'home-manager' is not a different version than 'nixpkgs'
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        Tofu = lib.nixosSystem {
	  inherit system;
          modules = [ ./configuration.nix ];
        };
      };

      homeConfigurations = {
        mystre = home-manager.lib.homeManagerConfiguration {
	  inherit pkgs;
          modules = [ ./home.nix  ];
	};
      };
    };

}
