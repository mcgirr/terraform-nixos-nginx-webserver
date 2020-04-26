#!/usr/bin/env bash

# The script to run after the instance is initially created

ssh -i ./id_rsa root@${ip} "nix-channel --update && nixos-rebuild switch"

ssh -i ./id_rsa root@${ip} "mkdir -p /var/www/${content_location}"

# Then scp the website file at this point.
# This assumes the static blog content you'd initially like to move over is located two directories up
scp -i ./id_rsa -P 22 -r ../../${content_location}/_site root@${ip}:/var/www/${content_location}/.

# then scp the configuration.nix file at this point
scp -i ./id_rsa -P 22 configuration.nix root@${ip}:/etc/nixos/configuration.nix

ssh -i ./id_rsa root@${ip} "nix-channel --update && nixos-rebuild switch"
