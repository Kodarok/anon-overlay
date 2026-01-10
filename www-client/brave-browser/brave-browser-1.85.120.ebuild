EAPI=8

DESCRIPTION="Brave Browser – privacy-focused Chromium-based web browser"
HOMEPAGE="https://brave.com/"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64"

SRC_URI="https://github.com/brave/brave-browser/releases/download/v${PV}/brave-browser_${PV}_amd64.deb"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
}

src_install() {
	cp -r usr "${D}/" || die
}

