EAPI=8

DESCRIPTION="Visual Studio Code - Open Source code editor (binary)"
HOMEPAGE="https://code.visualstudio.com/"
SRC_URI="https://update.code.visualstudio.com/${PV}/linux-deb-x64/stable -> vscode-${PV}.deb"

LICENSE="Microsoft"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip"

S="${WORKDIR}"

src_unpack() {
ar x "${DISTDIR}/vscode-${PV}.deb" || die "ar failed"
tar -xf data.tar.xz || tar -xf data.tar.gz || die "data.tar extraction failed"
}

src_install() {
# Créer le répertoire pour /usr/share/code
if [[ -d usr/share/code ]]; then
    dodir /usr/share
    cp -a usr/share/code "${D}/usr/share/" || die
fi

# Wrapper binaire
dodir /usr/bin
cat > "${D}/usr/bin/code" <<'EOF'
#!/bin/sh
exec /usr/share/code/code "$@"
EOF
chmod +x "${D}/usr/bin/code" || die

# Copier et corriger le .desktop
if [[ -d usr/share/applications ]]; then
    dodir /usr/share/applications
    for f in usr/share/applications/*.desktop; do
        cp "$f" "${D}/usr/share/applications/"
        sed -i 's|Exec=/usr/share/code/code|Exec=/usr/bin/code|' "${D}/usr/share/applications/$(basename "$f")"
    done
fi
}

pkg_postinst() {
elog "Visual Studio Code ${PV} installé"
elog "Commande : code"
}

