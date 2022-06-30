{ inputs =
    { make-shell.url = "github:ursi/nix-make-shell/1";

      murmur =
        { flake = false;
          url = "github:garycourt/murmurhash-js";
        };

      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      purs-nix.url = "github:ursi/purs-nix/foreign-dependencies";
      utils.url = "github:ursi/flake-utils/8";
    };

  outputs = { murmur, utils, ... }@inputs:
    utils.apply-systems { inherit inputs; }
      ({ make-shell, purs-nix, pkgs, ... }:
         let
           p = pkgs;
           inherit (purs-nix) ps-pkgs;
           package = import ./package.nix { inherit murmur p; } purs-nix;

           ps =
             purs-nix.purs
               (package
                // { test-dependencies =
                       let inherit (purs-nix.ps-pkgs-ns) ursi; in
                       [ ursi.prelude
                         ps-pkgs."assert"
                       ];
                   }
               );
         in
         { packages.default =
             purs-nix.build
               { name = "ursi.murmur3";
                 src.path = ./.;
                 info = package;
               };

           devShells.default =
             make-shell
               { packages =
                   with pkgs;
                   [ nodejs
                     nodePackages.bower
                     nodePackages.pulp
                     purs-nix.purescript

                     (ps.command
                        { bundle =
                            { esbuild.platform = "node";
                              main = false;
                              module = "Murmur3";
                            };
                        }
                     )
                   ];
               };
         }
      );
}
