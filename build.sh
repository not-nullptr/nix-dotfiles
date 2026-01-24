#!/usr/bin/env bash

DRY_RUN=false

if [[ "$1" == "--dry" ]]; then
	DRY_RUN=true
fi

if [[ ! -f ".hostname" ]]; then
	echo "error: .hostname not found. create it with the hostname you want to target!"
	exit 1
fi

HOSTNAME=$(cat .hostname | tr -d '[:space:]') # don't want any whitespace now, do we?

if [[ -z "$HOSTNAME" ]]; then
	echo "error: .hostname is empty. please specify the hostname (see ./hosts/* for a list of available hostnames!)"
	exit 1
fi


if [[ ! -d "./hosts/${HOSTNAME}" ]]; then
	echo "error: no config defined for \"${HOSTNAME}\". please create one!"
	exit 1
fi

set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

FLAKE_PATH=".#${HOSTNAME}"
ARGSTR="--argstr"

# TODO: this repetition is unnecessary
if [[ "$DRY_RUN" == true ]]; then
	echo "dry-running for ${HOSTNAME}"
	nixos-rebuild dry-run --flake "$FLAKE_PATH"
else
	echo "building and switching to ${HOSTNAME}"
	sudo nixos-rebuild switch --flake "$FLAKE_PATH"
fi
