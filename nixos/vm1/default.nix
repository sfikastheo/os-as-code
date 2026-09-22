# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  modulesPath,
  pkgs,
  user,
  ...
}:
{
  imports = [
    "${modulesPath}/virtualisation/lxc-container.nix"
    ./orbstack.nix
  ];

  nix.settings.trusted-users = [
    "root"
    user
  ];

  networking.hostName = "vm1";
  networking.networkmanager.enable = true;

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    # Packages
    file
    gnutar
    lsof
    usbutils
    vim-full
    zsh
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Define additional groups
  users.groups = {
    i2c = { };
  };

  programs.zsh.enable = true;
  users.users.${user} = {
    isSystemUser = true;
    uid = 502;
    group = "users";
    createHome = true;
    home = "/home/${user}";
    homeMode = "700";
    description = user;
    shell = pkgs.zsh;
    extraGroups = [
      "audio"
      "dialout"
      "docker"
      "i2c"
      "networkmanager"
      "orbstack"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEJnx35WTioopNCzkzz0S8Kv/rmgBZTDl7Bdyynzpkxy theodore.sfikas@toolsforhumanity.com"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Virtualization
  virtualisation.docker = {
    enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.variables.EDITOR = "nvim";

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    systemd
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # OrbStack LXC configuration
  users.mutableUsers = false;
  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };
  systemd.network = {
    enable = true;
    networks."50-eth0" = {
      matchConfig.Name = "eth0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };
  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      MIICDDCCAbKgAwIBAgIQd9FUWarUiejZDNm2dp1CRTAKBggqhkjOPQQDAjBmMR0w
      GwYDVQQKExRPcmJTdGFjayBEZXZlbG9wbWVudDEeMBwGA1UECwwVQ29udGFpbmVy
      cyAmIFNlcnZpY2VzMSUwIwYDVQQDExxPcmJTdGFjayBEZXZlbG9wbWVudCBSb290
      IENBMB4XDTI2MDkyMjIyNDUwOVoXDTM2MDkyMjIyNDUwOVowZjEdMBsGA1UEChMU
      T3JiU3RhY2sgRGV2ZWxvcG1lbnQxHjAcBgNVBAsMFUNvbnRhaW5lcnMgJiBTZXJ2
      aWNlczElMCMGA1UEAxMcT3JiU3RhY2sgRGV2ZWxvcG1lbnQgUm9vdCBDQTBZMBMG
      ByqGSM49AgEGCCqGSM49AwEHA0IABGlfIunhFmUit8XG+X+1W/LAZKy1XSQJ+5ws
      Ugefb2mGHruFiUSKBbW6nTi/mmhwYix44yojnk98WktGVZXcroCjQjBAMA4GA1Ud
      DwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBRMjgCmGwTMiGPg
      qNxTXlTJ6I+gTzAKBggqhkjOPQQDAgNIADBFAiBIgxNf691auT/OEAOxCmrMq8PX
      FqdJo6YMohv7GKJCYgIhAJ71mf1iitWwstQ310k+BCtdf+KbLJsKflyX6rtspjfA
      -----END CERTIFICATE-----
    ''
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
