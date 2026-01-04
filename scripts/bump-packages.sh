#!/bin/bash
set -euo pipefail

REPO="/var/db/repos/localrepo"

bump_package() {
    local PKGDIR="$1"
    local TEMPLATE
    TEMPLATE=$(ls "$PKGDIR/template/"*"-9999.ebuild" 2>/dev/null | head -n1)

    # Si pas de template, on quitte
    [[ -z "$TEMPLATE" ]] && return

    # Détecter le nom de package et récupérer la version depuis l'API
    local PKGNAME
    PKGNAME=$(basename "$PKGDIR")
    local LATEST

    case "$PKGNAME" in
        vscode-bin)
            LATEST=$(curl -s https://update.code.visualstudio.com/api/releases/stable | jq -r '.[0]')
            ;;
        brave-browser)
            LATEST=$(curl -s https://api.github.com/repos/brave/brave-browser/releases/latest | jq -r '.tag_name | sub("^v";"")')
            ;;
        *)
            echo "Package $PKGNAME not supported"
            return
            ;;
    esac

    local NEW="$PKGDIR/$PKGNAME-$LATEST.ebuild"
    [[ -f "$NEW" ]] && return

    # Génération de l'ebuild à partir du template
    sed "s/@VERSION@/$LATEST/g" "$TEMPLATE" > "$NEW"
    ebuild "$NEW" manifest

    echo "Updated $PKGNAME to $LATEST"
}

for PKGDIR in "$REPO"/*/*; do
    [[ -d "$PKGDIR/template" ]] || continue
    bump_package "$PKGDIR"
done

