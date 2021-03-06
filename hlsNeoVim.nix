{compiler ? "ghc884"} :
let
  pkgs = import <nixpkgs> {};
  ghc  = pkgs.haskell.packages.${compiler}.ghcWithPackages (p: with p; [ bytestring
                                                                       text
                                                                      mtl
                                                                      ]);

  hls       = pkgs.haskell-language-server.override {supportedGhcVersions = ["884" "8102"];};
  myNeoVim  = pkgs.neovim.override {
                configure = {
                  customRC = builtins.readFile ~/.vimrc;
                  packages.myPlugins = with pkgs.vimPlugins; {
                    start = [
                              #
                              coc-nvim
                              airline
                              #same word highlighting when not supported by the language
                              coc-highlight #don't think I need this
                              #General whitespace
                              vim-trailing-whitespace vim-autoformat
                              #Git
                              coc-git
                              fugitive
                              #Commenting
                              nerdcommenter
                              #Theme
                              papercolor-theme vim-airline-themes
                              gruvbox
                              #haskell syntax highlighting
                              haskell-vim vim-hoogle
                              vim-nix
                              #json
                              coc-json
                              #search
                              ctrlp
                              #additional
                              vim-surround
                              palenight-vim

                            ];
                    opt   = [];
                  };
                };
              };

in
  pkgs.stdenv.mkDerivation rec {
    name = "hls-env";

    buildInputs = [
                  pkgs.cabal-install
                   ghc
                   hls
                   myNeoVim
                   pkgs.nodejs
                 ];

  }
