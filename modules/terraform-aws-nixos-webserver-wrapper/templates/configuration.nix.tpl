{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/amazon-image.nix>
  ];

  ec2.hvm = true;

  networking = {
    hostName = "${hostname}";

    enableIPv6 = true; 

    # Open ports in the firewall.
    firewall.allowedTCPPorts = [
       # TODO set with a template var
       22
       80
       443
    ];
  };

  environment = {
    systemPackages = with pkgs; [
        htop
        vim
    ];
  };

  services.nginx = {
    enable = true;
    virtualHosts = {

      "www.${domain}" = {
        forceSSL = true;

        enableACME = true;

        locations."/" = {
          root = "/var/www/${content_location}/_site";
        };


      };

      # TODO combine this with the above so that this doesn't repeat itself

      "${domain}" = {
        forceSSL = true;

        enableACME = true;

        locations."/" = {
          root = "/var/www/${content_location}/_site";
        };

      };

    };
  };

  # Optional: You can configure the email address used with Let's Encrypt.
  # This way you get renewal reminders (automated by NixOS) as well as expiration emails.
  security.acme.certs."www.${domain}" = {
    email = "${email}";

    extraDomains = { "${domain}" = null; };
  };

  system.stateVersion = "19.09";
}