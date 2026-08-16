{ self, inputs, ... }:
{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.sbfde.vm;
in
{
  options.sbfde.vm = {
    isoImage = lib.mkOption {
      description = "The installer ISO derivation";
      type = lib.types.package;
      default =
        self.nixosConfigurations."iso-${pkgs.stdenv.hostPlatform.system}".config.sbfde.installer.isoImage;
      defaultText = "";
    };
  };
  imports = [
    inputs.qemu-vm.nixosModules.qemuSetup
    inputs.qemu-vm.nixosModules.qemuGuest
  ];
  config = {
    virtualisation = {
      fileSystems."/" = {
        fsType = "ext4";
        device = "/dev/disk/by-partlabel/nixos";
      };
      installBootLoader = false;
      useNixStoreImage = false;
      mountHostNixStore = false;
      useDefaultFilesystems = false;
      diskImage = null;
      emptyDiskImages = [ (50 * 1024) ];
      # https://github.com/NixOS/nixpkgs/blob/ec14b485283e51596b77b11b9c6efd7e3f3a1c75/nixos/modules/virtualisation/qemu-vm.nix#L218-L222
      efi.keepVariables = false; # prevent make-disk-image.nix from running (see link above)
      qemu.drives = [
        {
          file = "${cfg.isoImage}/iso/${cfg.isoImage.isoName}";
          driveExtraOpts = {
            media = "cdrom";
            format = "raw";
            readonly = "on";
          };
        }
      ];
    };
  };
}
