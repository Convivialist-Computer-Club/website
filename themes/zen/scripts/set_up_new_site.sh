#!/usr/bin/env bash

# shell script hardening
set -euo pipefail

# This script copies the scss and layout files I think most people
# would like to override. It also copies the example config file.
# (Run chmod 700 on this file to make it executable)

if [[ ! "$0" =~ "themes/zen/scripts/set_up_new_site.sh" ]]; then
  echo "Error: This script must be run from the project root directory."
  echo "Usage: ./theme/zen/set_up_new_site.sh"
  exit 1
fi

mkdir -p "assets/sass"
mkdir -p "layouts"

copy_files=("themes/zen/assets/sass/_colors.scss:assets/sass/_colors.scss"
            "themes/zen/assets/sass/_extra.scss:assets/sass/_extra.scss"
            "themes/zen/assets/sass/_fonts.scss:assets/sass/_fonts.scss"
            "themes/zen/assets/sass/_custom.scss:assets/sass/_custom.scss"
            "themes/zen/assets/sass/_zen.scss:assets/sass/_zen.scss"
            "themes/zen/layouts/index.html:layouts/index.html"
            "themes/zen/exampleSite/config.yaml:config.yaml")

for files in "${copy_files[@]}" ; do
  if [[ ! -f "${files##*:}" ]]; then
    cp "${files%%:*}" "${files##*:}"
    echo "Copied: ${files##*:}"
  else
    echo "Already exist so not overwritten: ${files##*:}"
  fi
done

if [[ -f "config.toml" && -f "config.yaml" ]]; then
  mv config.toml config.toml.old
fi
