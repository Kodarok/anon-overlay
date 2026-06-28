#!/bin/bash

# required:
# app-misc/jq
# net-misc/curl

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
	    URL="https://update.code.visualstudio.com/${LATEST}/linux-deb-x64/stable"
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

	lm-studio)
            LATEST="$(...)"

            VERSION="${LATEST%-*}"
            BUILD="${LATEST##*-}"

            URL="https://lmstudio.ai/download/latest/linux/x64?format=deb"
            FILENAME="LM-Studio-${VERSION}-${BUILD}.deb"
        ;;

    	*)
            echo "Package $PKGNAME not supported"
            return
            ;;
    esac

    local NEW="$PKGDIR/$PKGNAME-$LATEST.ebuild"
    [[ -f "$NEW" ]] && return

    # Variables utilisables dans les templates
    local VERSION_ONLY BUILD

    if [[ "$LATEST" == *-* ]]; then
        VERSION_ONLY="${LATEST%-*}"
        BUILD="${LATEST##*-}"
    else
        VERSION_ONLY="$LATEST"
        BUILD=""
    fi

    # Si FILENAME n'a pas été défini, on le déduit de l'URL
    : "${FILENAME:=$(basename "${URL%%\?*}")}"

    # Génération de l'ebuild à partir du template
    sed \
        -e "s|@VERSION@|${LATEST}|g" \
        -e "s|@URL@|${URL}|g" \
        -e "s|@FILENAME@|${FILENAME}|g" \
        "$TEMPLATE" > "$NEW"

    ebuild "$NEW" manifest

    echo "Updated $PKGNAME to $LATEST"
}

for PKGDIR in "$REPO"/*/*; do
    [[ -d "$PKGDIR/template" ]] || continue
    bump_package "$PKGDIR"
done
