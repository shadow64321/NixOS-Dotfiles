# How to Install
  1. Place files in the /etc/nixos folder on your machine
  2. Remove the 'hardware-configuration.nix'
  3. run 'nixos-generate-config' to get nixos to make a Hardware Configuration file for your system
  4. Edit 'configuration.nix' and change:
       - 'networking.hostname = "Your Chosen Hostname"'
       - 'time.timeZone', 'i18n.defaultLocale' and 'i18n.extraLocaleSettings'
       - 'users.users."Your Chosen Hostname"' and change the 'description' variables value to "Your Chosen Hostname"
