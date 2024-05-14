# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = { 
    enable = true;
    useOSProber = true;
    device = "nodev";
    efiSupport = true;
    theme = "/boot/grub/themes/Jingliu";
    splashImage = null;
  };

  # I use zsh btw... wait lol no I don't
  # environment.shells = with pkgs; [ bash zsh fish ];
  # users.defaultUserShell = pkgs.zsh;
  # programs.zsh.enable = true;

  # I use fish... maybe you have heard of it
  environment.shells = with pkgs; [ bash zsh fish ];
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  networking.hostName = "Jeremiah"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

#   i18n.supportedLocales = [
#     "ko_KR.UTF-8/UTF-8"
#     "ja_JP.UTF-8/UTF-8"
#   ];

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
    fira-code
    fira-code-symbols
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    hachimarupop
    nanum
    fantasque-sans-mono
    noto-fonts
    terminus-nerdfont
    siji
    material-icons
    font-awesome
  ];
 
  fonts.fontconfig.allowBitmaps = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
      sddm.theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
    };
  };

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;

  # Bspwm
  services.xserver.windowManager.bspwm = {
    enable = true;
    # configFile = "home/jeremiah/.config/bspwm/bspwmrc";
    # sxhkd.configFile = "$HOME/.config/bspwm/sxhkdrc";
  };

  services.picom.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = false;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };
  
  # Configure keymap in X11
  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";

    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    # Opengl
    opengl.enable = true;

    # Most wayland compositors need this
    nvidia.modesetting.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enables bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jeremiah = {
    isNormalUser = true;
    description = "Jeremiah";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      # kate
      thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    lib.optional (pkgs.obsidian.version == "1.4.16") "electron-25.9.0"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

     # General
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     neovim
     wget
     networkmanagerapplet
     mpd
     floorp
     anki
     vlc
     obs-studio
     syncthing
     p7zip
     # obsidian
     rawtherapee
     syncthing
     # davinci-resolve-studio
     # davinci-resolve
     gimp
     grub2_efi
     logseq


     # Programming
     rustup
     go
     python3
     zig
     

     # Music
     # spotify
     # spicetify-cli
     # cli-visualizer
     blanket
     musikcube
     spotdl


     # Virtulisation
     qemu
     virt-manager


     # Gaming
     steam
     lutris
     asusctl
     

     # Libre 
     libresprite
     libreoffice


     # Terminal
     alacritty
     # htop
     bat # better cat
     gdu # disk usage analyser
     lf # Terminal File Manager
     killall
     # viu # allows images to be viewed in terminal
     catimg # Same as above
     btop # better htop
     ascii-image-converter
     neofetch # Depreciated
     # uwufetch
     # fastfetch
     git
     python3
     # Pip???
     starship
     # tmux
     fish
     # oh-my-fish


     # Screenshotting - Hyprland
     slurp
     grim
     swappy
     imagemagick


     # Terminal Commands
     asciiquarium
     cmatrix
     cowsay
     lolcat
     figlet # makes cool text, to pass arg: figlet "cool text here"
     feh # wallpaper setter + image viewer


     # Bspwm
     bspwm
     polybar
     picom
     sxhkd
     bsp-layout
     bc
     pywal
     networkmanager_dmenu
     dmenu
     scrot
     brightnessctl
     betterlockscreen


     # Hyprland
     # waybar
     # eww-wayland
     # dunst
     # libnotify
     swww
     rofi-wayland
     rofi-power-menu
#      pyprland


     # Multi-lingual Support
#      fcitx5
#      fcitx5-configtool
#      fcitx5-hangul
#      fcitx5-mozc
#      fcitx5-gtk


     # Info-Sec
     wireshark # Network inspector
     # hydra # Password brute force crack <- Doesn't work
     okteta # Hex Editor
     dhex # Hex Editor
     gobuster # Website Api Fuzzer
     nmap # Port Fuzzer
     john # John the Ripper Password Cracker
     wordlists # A Collection of Wordlists for Info-Sec
     ghidra # Assembly editor


     # if sddm breaks
     #libsforqt5.qt5.qtquickcontrols2   
     #libsforqt5.qt5.qtgraphicaleffects
  ];

  # Stuff to make steam work
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
    "davinci-resolve"
    "davinci-resolve-studio"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?


  # makes file with all installed packages in /etc directory called 'current-system-packages'
  environment.etc."current-system-packages".text =
  let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
