## sbfde\.enable

Whether to enable SecureBoot Full Disk Encryption\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```

*Declared by:*
 - [nix/modules/default/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/default/default.nix)



## sbfde\.enrollEmptyKey



Whether to enable enrollment of an empty encryption key (eases setup procedure, will be removed after enrollment of the SecureBoot LUKS key)\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```

*Declared by:*
 - [nix/modules/default/full-disk-encryption\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/default/full-disk-encryption.nix)



## sbfde\.enrollFallbackPassword



Whether to enable enrollment of a fallback password\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```

*Declared by:*
 - [nix/modules/default/full-disk-encryption\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/default/full-disk-encryption.nix)



## sbfde\.hashedPasswordFile



Where to place the hashed password for the primary user of the system\. ` null ` to disable the prompt\.



*Type:*
null or string



*Default:*

````nix
"`hashedPasswordFile` of the first normal, enabled user with UID >= 1000"
````

*Declared by:*
 - [nix/modules/default/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/default/default.nix)



## sbfde\.includeInSelection



Whether to include this host configuration in the installer prompt



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [nix/modules/default/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/default/default.nix)



## sbfde\.installer\.enable



Whether to enable installer ISO profile\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.installer\.package



The installer package to use\. The installer package to use



*Type:*
package



*Default:*

```nix
pkgs.installer
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.installer\.configuration



The installer configuration file\. Setting this option causes all other installer configs to be ignored\.



*Type:*
package



*Default:*

```nix
""
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.installer\.deployKey



SSH private key that can access the installation repository



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.installer\.isoImage



The installer ISO derivation



*Type:*
package *(read only)*



*Default:*

```nix
""
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.installer\.isoNixOSConfigurationName



Name of the nixosConfiguration that configures the ISO installer, a shorthand for replacing ${config\.networking\.hostName} in updateUrl



*Type:*
null or string



*Default:*

```nix
${config.networking.hostName}
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.installer\.knownHosts



Lines of known_hosts to add to the SSH configuration



*Type:*
null or strings concatenated with “\\n”



*Default:*

```nix
''
  github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=
  github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
  github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
  gitlab.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFSMqzJeV9rUzU4kWitGjeR4PWSa29SPqJ1fVkhtj3Hw9xjLVXVYrU9QlYWrOLXBpQ6KWjbjTDTdDkoohFzgbEY=
  gitlab.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsj2bNKTBSpIYDEGk9KxsGh3mySTRgMtXL583qmBpzeQ+jqCMRgBqB98u3z++J1sKlXHWfM9dyhSevkMwSbhoR8XIq/U0tCNyokEi/ueaBMCvbcTHhO7FcwzY92WK4Yt0aGROY5qX2UKSeOvuP4D6TPqKF1onrSzH9bx9XUf2lEdWT/ia1NEKjunUqu1xOB/StKDHMoX4/OKyIzuS0q/T1zOATthvasJFoPrAjkohTyaDUz2LN5JoH839hViyEG82yB+MjcFV5MU3N1l1QL3cVUCh93xSaua1N85qivl+siMkPGbO5xR/En4iEY6K2XPASUEMaieWVNTRCtJ4S8H+9
  gitlab.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf
  codeberg.org ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8hZi7K1/2E2uBX8gwPRJAHvRAob+3Sn+y2hxiEhN0buv1igjYFTgFO2qQD8vLfU/HT/P/rqvEeTvaDfY1y/vcvQ8+YuUYyTwE2UaVU5aJv89y6PEZBYycaJCPdGIfZlLMmjilh/Sk8IWSEK6dQr+g686lu5cSWrFW60ixWpHpEVB26eRWin3lKYWSQGMwwKv4LwmW3ouqqs4Z4vsqRFqXJ/eCi3yhpT+nOjljXvZKiYTpYajqUC48IHAxTWugrKe1vXWOPxVXXMQEPsaIRc2hpK+v1LmfB7GnEGvF1UAKnEZbUuiD9PBEeD5a1MZQIzcoPWCrTxipEpuXQ5Tni4mN
  codeberg.org ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBL2pDxWr18SoiDJCGZ5LmxPygTlPu+cCKSkpqkvCyQzl5xmIMeKNdfdBpfbCGDPoZQghePzFZkKJNR/v9Win3Sc=
  codeberg.org ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIVIC02vnjFyL+I4RHfvIGNtOgJMe769VTF1VR4EB3ZB
''
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.installer\.repoUrl



URL of the installation repository



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.installer\.unattended\.enable



Whether to enable unattended installation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.installer\.unattended\.hashedPassword



Hashed password of the primary user



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.installer\.unattended\.installDev



The devicepath to install NixOS to



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.installer\.unattended\.nixOSConfig



The nixOS configuration to install



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.installer\.updateUrl



Repourl \& path to the installer package so it can run the newest version, null to disable



*Type:*
null or string



*Default:*

```nix
${repoUrl}#nixosConfigurations.${config.sbfde.installer.isoNixOSConfigurationName}.config.sbfde.installer.package
```

*Declared by:*
 - [nix/modules/installer/default\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/installer/default.nix)



## sbfde\.recoveryKeyPath



Location of the full disk encryption recovery key



*Type:*
string



*Default:*

```nix
"/etc/cryptsetup-keys.d/nixos.key"
```

*Declared by:*
 - [nix/modules/default/full-disk-encryption\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/default/full-disk-encryption.nix)



## sbfde\.repartDefinitions



The repart definition files



*Type:*
package *(read only)*



*Default:*

```nix
""
```

*Declared by:*
 - [nix/modules/default/filesystem\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/default/filesystem.nix)



## sbfde\.tpm2PCRs



Which PCRs to lock the TPM2 key with



*Type:*
string



*Default:*

```nix
"0+2+7+15:sha256=0000000000000000000000000000000000000000000000000000000000000000"
```

*Declared by:*
 - [nix/modules/default/full-disk-encryption\.nix](https://github.com/andsens/nixos-sbfde/blob/main/nix/modules/default/full-disk-encryption.nix)


