{ ... }:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.sbfde;
in
{
  config = lib.mkIf cfg.enable {
    boot = {
      initrd = {
        systemd = {
          enable = lib.mkDefault true;
          tpm2.enable = lib.mkDefault true;
          initrdBin = lib.optional (lib.hasPrefix "ext" config.fileSystems."/".fsType) pkgs.e2fsprogs;
        };
        availableKernelModules = lib.optional (config.fileSystems."/".fsType == "ext4") "ext4"; # Not automatically added because systemd-boot is "disabled"
      };
      lanzaboote = {
        enable = lib.mkDefault true;
        pkiBundle = lib.mkDefault "/var/lib/sbctl";
        autoGenerateKeys.enable = lib.mkDefault true;
        autoEnrollKeys = {
          enable = lib.mkDefault true;
          autoReboot = lib.mkDefault true;
        };
      };
      loader = {
        grub.enable = false;
        systemd-boot.enable = lib.mkForce false;
        efi.canTouchEfiVariables = lib.mkDefault true;
      };
    };
    system.fsPackages = lib.optional (lib.hasPrefix "ext"
      config.fileSystems."/".fsType
    ) pkgs.e2fsprogs; # Not automatically added because systemd-boot is "disabled"
    systemd.services.copy-sb-keys-to-boot =
      lib.mkIf (config.boot.lanzaboote.enable && config.boot.lanzaboote.autoGenerateKeys.enable)
        {
          restartIfChanged = true;
          description = "Copy SecureBoot certificates to /boot, for manual installation";
          unitConfig = {
            After = [ "generate-sb-keys.service" ];
            ConditionSecurity = [ "!uefi-secureboot" ];
          };
          serviceConfig.Type = "oneshot";
          script = ''
            ${lib.getExe' pkgs.coreutils "mkdir"} -p /boot/loader/keys/manual
            ${lib.getExe pkgs.openssl} x509 -in "/${config.boot.lanzaboote.pkiBundle}/keys/db/db.pem" -outform der -out /boot/loader/keys/manual/db.cer
            ${lib.getExe pkgs.openssl} x509 -in "/${config.boot.lanzaboote.pkiBundle}/keys/KEK/KEK.pem" -outform der -out /boot/loader/keys/manual/KEK.cer
          '';
          wantedBy = [ "generate-sb-keys.service" ];
        };
  };
}
