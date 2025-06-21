{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bottom
    mtm
    neovim
    lf
    util-linux
    dig
  ];
}
