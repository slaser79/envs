{ pkgs} :
{
  hls       = pkgs.haskell-language-server.override {supportedGhcVersions = ["884" "8102"];};
}
