EAPI=8

DESCRIPTION="LM Studio"
HOMEPAGE="https://lmstudio.ai"

LICENSE="LM-Studio"
SLOT="0"
KEYWORDS="amd64"

SRC_URI="@URL@ -> @FILENAME@"

S="${WORKDIR}"

src_unpack() {
	ar x "${DISTDIR}/@FILENAME@" || die
	tar -xf data.tar.* || die
}

src_install() {
    cp -a opt "${ED}/" || die
    cp -a usr "${ED}/" || die

    dosym /opt/LM-Studio/lm-studio /usr/bin/lm-studio
}
