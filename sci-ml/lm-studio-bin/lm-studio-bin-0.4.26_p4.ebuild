EAPI=8

DESCRIPTION="LM Studio"
HOMEPAGE="https://lmstudio.ai"

LICENSE="LM-Studio"
SLOT="0"
KEYWORDS="amd64"

SRC_URI="https://installers.lmstudio.ai/linux/x64/0.4.26-4/LM-Studio-0.4.26-4-x64.deb -> LM-Studio-0.4.26-4-x64.deb"

S="${WORKDIR}"

src_unpack() {
	ar x "${DISTDIR}/LM-Studio-0.4.26-4-x64.deb" || die
	tar -xf data.tar.* || die
}

# src_install() {
#    cp -a opt "${ED}/" || die
#    cp -a usr "${ED}/" || die
#
#    dosym /opt/LM-Studio/lm-studio /usr/bin/lm-studio-bin
# }

src_install() {
    cp -a opt usr "${ED}/" || die
}
