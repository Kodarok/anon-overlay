#!/bin/bash
set -e

PKGDIR="/var/db/repos/localrepo/app-editors/vscode-bin"
TEMPLATE="${PKGDIR}/vscode-bin-9999.ebuild"

LATEST=$(curl -s https://update.code.visualstudio.com/api/releases/stable | jq -r '.[0]')
NEW_EBUILD="${PKGDIR}/vscode-bin-${LATEST}.ebuild"

[[ -f "${NEW_EBUILD}" ]] && exit 0
[[ ! -f "${TEMPLATE}" ]] && exit 0

cp "${TEMPLATE}" "${NEW_EBUILD}"
ebuild "${NEW_EBUILD}" manifest

cd /var/db/repos/localrepo
git add app-editors/vscode-bin/vscode-bin-${LATEST}.ebuild
git commit -m "Bump vscode-bin to ${LATEST}"
git push origin main
