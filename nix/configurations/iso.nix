{ self, modulesPath, ... }:
{
  imports = [
    self.nixosModules.installer
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${modulesPath}/installer/cd-dvd/iso-image.nix"
  ];
  config = {
    system.stateVersion = "25.11";
    sbfde.installer = {
      enable = true;
      updateUrl = "git+https://github.com/andsens/nixos-sbfde#nixosConfigurations.iso.config.sbfde.installer.package";
    };
  };
}
