#!/bin/bash
set -euo pipefail

REPO="/var/db/repos/localrepo"

find "$REPO" -type f -name "*.ebuild" \
  ! -name "*-9999.ebuild" \
  ! -path "*/template/*" \
| while read -r EBUILD; do
    DIR=$(dirname "$EBUILD")
    echo "Updating Manifest in $DIR"
    ( cd "$DIR" && ebuild "$(basename "$EBUILD")" manifest )
done

cd "$REPO"
git add .
git commit -m "Update Manifests"
git push origin main

