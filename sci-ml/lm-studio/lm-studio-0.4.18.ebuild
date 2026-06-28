EAPI=8

DESCRIPTION="LM Studio"
HOMEPAGE="https://lmstudio.ai"

LICENSE="LM-Studio"
SLOT="0"
KEYWORDS="amd64"

SRC_URI="https://lmstudio.ai/download/latest/linux/x64?format=deb -> LM-Studio-0.4.18-0.4.18.deb"

S="${WORKDIR}"

src_unpack() {
	ar x "${DISTDIR}/LM-Studio-0.4.18-0.4.18.deb" || die
	tar -xf data.tar.* || die
}

src_install() {
    cp -a opt "${ED}/" || die
    cp -a usr "${ED}/" || die

    # sécurité: garantir présence du dossier
    dodir /usr/share/applications

    dosym /opt/LM-Studio/lm-studio \
        /usr/share/applications/lm-studio.desktop
}
