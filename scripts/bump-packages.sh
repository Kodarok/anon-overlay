#!/bin/bash

# required:
# app-misc/jq
# net-misc/curl

CACHYOS_KERNEL_VERSION="7.0.9-1"

set -euo pipefail

REPO="/var/db/repos/anon-overlay"

bump_package() {
    local PKGDIR="$1"

    local TEMPLATE
    TEMPLATE=$(find "$PKGDIR/template" -maxdepth 1 -name '*-9999.ebuild' | head -n1)

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
        LATEST=""

        for v in $(curl -s https://api.github.com/repos/brave/brave-browser/releases \
            | jq -r '.[].tag_name | sub("^v";"")'); do

            URL="https://github.com/brave/brave-browser/releases/download/v${v}/brave-browser_${v}_amd64.deb"

            if curl -sfI "$URL" >/dev/null; then
                LATEST="$v"
                break
            fi
        done

        [[ -z "$LATEST" ]] && {
            echo "No valid Brave release found"
            return
        }
        ;;

	#cachyos-kernel)
    	#    UPSTREAM="$CACHYOS_KERNEL_VERSION"   # linux-cachyos-7.0.9-1
    	#    CLEAN="${UPSTREAM#cachyos-}"   # 7.0.9-1
    	#    PV="${CLEAN%-*}"                     # 7.0.9
    	#    REV="${CLEAN##*-}"                   # 1
	#    LATEST="${PV}-r${REV}"               # 7.0.9-r1
	#    ;;

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

