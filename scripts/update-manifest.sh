#!/bin/bash
set -e
REPO="/var/db/repos/localrepo"
cd "$REPO/app-editors/vscode-bin"

# Mettre à jour le Manifest pour tous les ebuilds
for e in *.ebuild; do
    ebuild "$e" manifest
done

# Commit et push les changements Git
git add *.ebuild Manifest
git commit -m "Update vscode-bin template and Manifest"
git push origin main

