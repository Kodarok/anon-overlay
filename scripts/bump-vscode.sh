#!/bin/bash
set -euo pipefail

PKGDIR="/var/db/repos/localrepo/app-editors/vscode-bin"
TEMPLATE="${PKGDIR}/template/vscode-bin-9999.ebuild"

LATEST=$(curl -s https://update.code.visualstudio.com/api/releases/stable | jq -r '.[0]')
NEW="${PKGDIR}/vscode-bin-${LATEST}.ebuild"

[[ -f "$NEW" ]] && exit 0

sed "s/@VERSION@/${LATEST}/g" "$TEMPLATE" > "$NEW"

ebuild "$NEW" manifest

