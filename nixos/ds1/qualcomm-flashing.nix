{
  pkgs,
  user,
  ...
}:
let
  flashingPython = pkgs.python3.withPackages (ps: [
    ps.kivy
    ps.pyudev
  ]);
  flashingLibraryPath = pkgs.lib.makeLibraryPath [
    pkgs.systemd
    pkgs.libusb1
    pkgs.libxml2
    pkgs.mtdev
  ];
  qdlRs =
    let
      src = pkgs.fetchFromGitHub {
        owner = "qualcomm";
        repo = "qdlrs";
        rev = "bfb733a9900129534c5ba0f35a7d1e8b9fc92392";
        hash = "sha256-tj8/rGw2UgKszHItlvzXgxfGPBow3W9LWMbcodsiiFY=";
      };
    in
    pkgs.rustPlatform.buildRustPackage {
      pname = "qdl-rs";
      version = "unstable-2026-06-19";
      inherit src;
      cargoLock.lockFile = "${src}/Cargo.lock";

      meta = {
        description = "Tools for flashing Qualcomm SoCs in EDL/QDL mode";
        homepage = "https://github.com/qualcomm/qdlrs";
        license = pkgs.lib.licenses.bsd3;
        mainProgram = "qdl-rs";
        platforms = pkgs.lib.platforms.linux;
      };
    };
in
{
  environment.systemPackages = [
    qdlRs
    pkgs.android-tools
    (pkgs.writeShellApplication {
      name = "flash-mini";
      # Run the flashing-rig from this wrapper
      # `flash-mini` ./flashing-rig.py
      text = ''
        export LD_LIBRARY_PATH=${flashingLibraryPath}
        export NIX_LD_LIBRARY_PATH=${flashingLibraryPath}
        exec ${flashingPython}/bin/python "$@"
      '';
    })
  ];

  users.groups.plugdev = { };
  users.users.${user}.extraGroups = [ "plugdev" ];

  services.udev = {
    packages = [ pkgs.android-udev-rules ];
    extraRules = ''
      SUBSYSTEM=="usb", MODE="0660", GROUP="plugdev"
    '';
  };
}
