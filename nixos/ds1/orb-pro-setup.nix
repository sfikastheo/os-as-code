{ user, ... }:
{
  users.groups.plugdev = { };
  users.users.${user}.extraGroups = [ "plugdev" ];

  services.udev.extraRules = ''
    # Qualcomm USB modes used by qdl, ADB, and fastboot.
    SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", MODE="0666", GROUP="plugdev", TAG+="uaccess"
  '';
}
