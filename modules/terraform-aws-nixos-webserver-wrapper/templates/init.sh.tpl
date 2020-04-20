#!/usr/bin/env bash

# The script to run after the instance is initially created

ssh -i ./id_rsa root@${ip} "nix-channel --update && nixos-rebuild switch"

ssh -i ./id_rsa root@${ip} "mkdir -p /var/www/${content_location}"
# TODO set this with an input variable

# then scp the website file at this point
scp -i ./id_rsa -P 22 -r ../../${content_location}/_site root@${ip}:/var/www/${content_location}/.
# TODO set this with an input variable

# then scp the configuration.nix file at this point
scp -i ./id_rsa -P 22 configuration.nix root@${ip}:/etc/nixos/configuration.nix

ssh -i ./id_rsa root@${ip} "nix-channel --update && nixos-rebuild switch"
