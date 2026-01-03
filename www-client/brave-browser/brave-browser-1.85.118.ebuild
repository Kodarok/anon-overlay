EAPI=8

DESCRIPTION="Brave Browser – privacy-focused Chromium-based web browser"
HOMEPAGE="https://brave.com/"
SRC_URI="https://github.com/brave/brave-browser/releases/download/v${PV}/brave-browser_${PV}_amd64.deb"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}

src_unpack() {
    ar x "${DISTDIR}/brave-browser_${PV}_amd64.deb" || die "Impossible d'extraire le .deb"

    # extraire le contenu principal
    tar -xf data.tar.xz || tar -xf data.tar.gz || die "Impossible d'extraire data.tar"
}

src_install() {
    # Créer le dossier de staging pour Brave
    dodir /opt/brave.com/brave
    cp -r opt/brave.com/brave/* "${D}/opt/brave.com/brave/"

    # Créer le wrapper binaire
    dodir /usr/bin
    echo '#!/bin/sh' > "${D}/usr/bin/brave-browser"
    echo 'exec /opt/brave.com/brave/brave-browser "$@"' >> "${D}/usr/bin/brave-browser"
    chmod +x "${D}/usr/bin/brave-browser"

    # Copier et corriger fichiers desktop
    if [[ -d usr/share/applications ]]; then
        dodir /usr/share/applications
        for f in usr/share/applications/*.desktop; do
            cp "$f" "${D}/usr/share/applications/"
            sed -i 's|Exec=/usr/bin/brave-browser-stable|Exec=/usr/bin/brave-browser|' "${D}/usr/share/applications/$(basename "$f")"
        done
    fi

    # Copier metainfo
    if [[ -d usr/share/metainfo ]]; then
        dodir /usr/share/metainfo
        cp -r usr/share/metainfo/* "${D}/usr/share/metainfo/"
    fi

    # Copier docs
    if [[ -d usr/share/doc/brave-browser ]]; then
        dodir "/usr/share/doc/${PF}"
        cp -r usr/share/doc/brave-browser/* "${D}/usr/share/doc/${PF}/"
    fi
}

pkg_postinst() {
    elog "Brave Browser ${PV} installé dans /opt/brave.com/brave et /usr/bin/brave-browser"
}

