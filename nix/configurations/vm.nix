{ self, ... }:
{
  imports = [ self.nixosModules.vm ];
  config = {
    system.stateVersion = "25.11";
  };
}
