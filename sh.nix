{ config, pkgs, ... }:
let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    vim = "nvim";
    pwroff = "shutdown -h now";
  };
in
{

  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.fish = {
    enable = true;
    shellAliases = myAliases;
  };
}

