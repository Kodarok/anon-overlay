#!/bin/bash
set -euo pipefail

PKGDIR="/var/db/repos/localrepo/www-client/brave-browser"
TEMPLATE="$PKGDIR/template/brave-browser-9999.ebuild"

LATEST=$(curl -s https://api.github.com/repos/brave/brave-browser/releases/latest \
  | jq -r '.tag_name | sub("^v"; "")')

NEW="$PKGDIR/brave-browser-${LATEST}.ebuild"

[[ -f "$NEW" ]] && exit 0

sed "s/@VERSION@/${LATEST}/g" "$TEMPLATE" > "$NEW"

ebuild "$NEW" manifest

