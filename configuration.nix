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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # I use zsh btw... wait lol no I don't
  # environment.shells = with pkgs; [ bash zsh fish ];
  # users.defaultUserShell = pkgs.zsh;
  # programs.zsh.enable = true;

  # I use fish... maybe you have heard of it
  environment.shells = with pkgs; [ bash zsh fish ];
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  networking.hostName = "Tofu"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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

  # Throws error
  i18n.supportedLocales = [
    "ko_KR.UTF-8"
    "ja_JP.UTF-8"
  ];

  # Multi-lingual Support
  # i18n.inputMethod.fctix5 = {
    # waylandFrontend = true;
    # addons = with pkgs; [
      # fctix5-configtool
      # fctix5-hangul
      # fctix5-mozc
      # fcitx5-gtk
    # ];
  # };

  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    hachimarupop
    nanum
  ];

  # X 11
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver = {
    # Configure keymap in X11
    layout = "au";
    xkbVariant = "";
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
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
  users.users.mystre = {
    isNormalUser = true;
    description = "MystrE";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      librewolf
      kate
      thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

     # General
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     neovim
     wget
     networkmanagerapplet
     nerdfonts
     font-awesome
     mpd
     floorp
     anki
     vlc
     obs-studio
     cli-visualizer
     spotify
     spicetify-cli
     syncthing
     p7zip

     # Virtulisation
     # qemu
     # virt-manager

     # Gaming
     steam
     lutris


     # Terminal
     alacritty
     htop
     neofetch
     git
     python3
     starship
     tmux
     fish
     # oh-my-fish

     # Terminal Commands
     asciiquarium
     cmatrix
     cowsay
     lolcat
     figlet # makes cool text, to pass arg: figlet "cool text here"

     # Hyprland
     waybar
     dunst
     libnotify
     swww
     rofi-wayland
     rofi-power-menu
     pyprland

     # Multi-lingual Support
     fcitx5
     fcitx5-configtool
     fcitx5-hangul
     fcitx5-mozc
     fcitx5-gtk

     # Info-Sec
     wireshark # Network inspector
     hydra # Password brute force crack
     okteta # Hex Editor
     dhex # Hex Editor
     gobuster # Website Api Fuzzer
     nmap # Port Fuzzer
     john # John the Ripper Password Cracker
     wordlists # A Collection of Wordlists for Info-Sec
     ghidra # Assembly editor
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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
