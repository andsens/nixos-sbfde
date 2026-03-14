{ self, ... }:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.sbfde.installer;
in
{
  options.sbfde.installer = {
    enable = lib.mkEnableOption "installer ISO profile";
    repoUrl = lib.mkOption {
      description = "URL of the installation repository";
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
    deployKey = lib.mkOption {
      description = "SSH private key that can access the installation repository";
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
    knownHosts = lib.mkOption {
      description = "Lines of known_hosts to add to the SSH configuration";
      type = lib.types.nullOr lib.types.lines;
      default = ''
        github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=
        github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
        github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
        gitlab.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFSMqzJeV9rUzU4kWitGjeR4PWSa29SPqJ1fVkhtj3Hw9xjLVXVYrU9QlYWrOLXBpQ6KWjbjTDTdDkoohFzgbEY=
        gitlab.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsj2bNKTBSpIYDEGk9KxsGh3mySTRgMtXL583qmBpzeQ+jqCMRgBqB98u3z++J1sKlXHWfM9dyhSevkMwSbhoR8XIq/U0tCNyokEi/ueaBMCvbcTHhO7FcwzY92WK4Yt0aGROY5qX2UKSeOvuP4D6TPqKF1onrSzH9bx9XUf2lEdWT/ia1NEKjunUqu1xOB/StKDHMoX4/OKyIzuS0q/T1zOATthvasJFoPrAjkohTyaDUz2LN5JoH839hViyEG82yB+MjcFV5MU3N1l1QL3cVUCh93xSaua1N85qivl+siMkPGbO5xR/En4iEY6K2XPASUEMaieWVNTRCtJ4S8H+9
        gitlab.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf
        codeberg.org ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8hZi7K1/2E2uBX8gwPRJAHvRAob+3Sn+y2hxiEhN0buv1igjYFTgFO2qQD8vLfU/HT/P/rqvEeTvaDfY1y/vcvQ8+YuUYyTwE2UaVU5aJv89y6PEZBYycaJCPdGIfZlLMmjilh/Sk8IWSEK6dQr+g686lu5cSWrFW60ixWpHpEVB26eRWin3lKYWSQGMwwKv4LwmW3ouqqs4Z4vsqRFqXJ/eCi3yhpT+nOjljXvZKiYTpYajqUC48IHAxTWugrKe1vXWOPxVXXMQEPsaIRc2hpK+v1LmfB7GnEGvF1UAKnEZbUuiD9PBEeD5a1MZQIzcoPWCrTxipEpuXQ5Tni4mN
        codeberg.org ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBL2pDxWr18SoiDJCGZ5LmxPygTlPu+cCKSkpqkvCyQzl5xmIMeKNdfdBpfbCGDPoZQghePzFZkKJNR/v9Win3Sc=
        codeberg.org ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIVIC02vnjFyL+I4RHfvIGNtOgJMe769VTF1VR4EB3ZB
      '';
    };
    isoNixOSConfigurationName = lib.mkOption {
      description = "Name of the nixosConfiguration that configures the ISO installer, a shorthand for replacing \${config.networking.hostName} in updateUrl";
      type = lib.types.nullOr lib.types.str;
      default = config.networking.hostName;
      defaultText = lib.literalExpression "\${config.networking.hostName}";
    };
    updateUrl = lib.mkOption {
      description = "Repourl & path to the installer package so it can run the newest version, null to disable";
      type = lib.types.nullOr lib.types.str;
      default = "${cfg.repoUrl}#nixosConfigurations.${cfg.isoNixOSConfigurationName}.config.sbfde.installer.package";
      defaultText = lib.literalExpression "\${repoUrl}#nixosConfigurations.\${config.sbfde.installer.isoNixOSConfigurationName}.config.sbfde.installer.package";
    };
    unattended = {
      enable = lib.mkEnableOption "unattended installation";
      installDev = lib.mkOption {
        description = "The devicepath to install NixOS to";
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      nixOSConfig = lib.mkOption {
        description = "The nixOS configuration to install";
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      hashedPassword = lib.mkOption {
        description = "Hashed password of the primary user";
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
    package = lib.mkPackageOption self.packages.${pkgs.stdenv.hostPlatform.system} "installer" {
      extraDescription = "The installer package to use";
    };
    isoImage = lib.mkOption {
      description = "The installer ISO derivation";
      type = lib.types.package;
      readOnly = true;
      default = config.system.build.isoImage;
    };
    configuration = lib.mkOption {
      description = "The installer configuration file. Setting this option causes all other installer configs to be ignored.";
      type = lib.types.package;
      default = pkgs.stdenv.mkDerivation {
        name = "install-nixos";
        dontUnpack = true;
        # Would love for a builtins.toJSONPretty(data, indentChar)
        installPhase = ''
          runHook preInstall
          ${lib.getExe pkgs.jq} . >"$out" <<'EOF'
          ${builtins.toJSON (
            builtins.removeAttrs cfg [
              "enable"
              "deployKey"
              "knownHosts"
              "isoNixOSConfigurationName"
              "package"
              "isoImage"
              "includeConfiguration"
              "configuration"
            ]
          )}
          EOF
          runHook postInstall
        '';
      };
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
      pkgs.sbctl
      pkgs.jq
      pkgs.iproute2
    ];
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    isoImage.contents = [
      {
        source = cfg.configuration;
        target = "config.json";
      }
    ]
    ++ (lib.optional (cfg.deployKey != null) {
      source = pkgs.writeText "deploy_key" cfg.deployKey;
      target = "deploy_key";
    })
    ++ (lib.optional (cfg.knownHosts != null) {
      source = pkgs.writeText "known_hosts" cfg.knownHosts;
      target = "known_hosts";
    });
    systemd.tmpfiles.settings."50-ssh" = {
      "/root/.ssh".d = {
        user = "root";
        group = "root";
        mode = "0700";
      };
      "/root/.ssh".f = {
        user = "root";
        group = "root";
        mode = "0600";
        argument = ''
          UserKnownHostsFile /iso/known_hosts
          IdentityFile %d/.ssh/deploykey
        '';
      };
    };
    security.sudo.extraConfig = ''
      # Keep install-nixos env vars for root and %wheel.
      Defaults:root,%wheel env_keep+=REPOURL
      Defaults:root,%wheel env_keep+=UPDATEURL
    '';
    environment.interactiveShellInit = ''
      if [[ $USER = nixos && ! -e .installer-launched ]]; then
        touch .installer-launched
        sudo install-nixos --abort-msg --auto-reboot
      fi
    '';
  };
}
