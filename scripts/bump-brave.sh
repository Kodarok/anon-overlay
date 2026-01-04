#!/bin/bash
set -e

PKGDIR="/var/db/repos/localrepo/www-client/brave-browser"
TEMPLATE="${PKGDIR}/template/brave-browser-9999.ebuild"

LATEST=$(curl -s https://api.github.com/repos/brave/brave-browser/releases/latest \
  | sed -n 's/.*"tag_name": *"v\([^"]*\)".*/\1/p')

NEW="${PKGDIR}/brave-browser-${LATEST}.ebuild"

[[ -f "$NEW" ]] && exit 0

cat > "$NEW" <<EOF
EAPI=8

DESCRIPTION="Brave Browser – privacy-focused Chromium-based web browser"
HOMEPAGE="https://brave.com/"

SRC_URI="https://github.com/brave/brave-browser/releases/download/v${LATEST}/brave-browser_${LATEST}_amd64.deb"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

S=\${WORKDIR}

src_unpack() {
ar x "\${DISTDIR}/brave-browser_${LATEST}_amd64.deb" || die
tar -xf data.tar.* || die
}

src_install() {
cp -r opt "\${D}/" || die
dosym /opt/brave.com/brave/brave-browser /usr/bin/brave-browser
}
EOF

ebuild "$NEW" manifest

