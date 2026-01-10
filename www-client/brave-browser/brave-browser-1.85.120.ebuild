EAPI=8

DESCRIPTION="Brave Browser – privacy-focused Chromium-based web browser"
HOMEPAGE="https://brave.com/"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64"

SRC_URI="https://github.com/brave/brave-browser/releases/download/v${PV}/brave-browser_${PV}_amd64.deb"

S="${WORKDIR}"

src_unpack() {
	ar x "${DISTDIR}/${A}" || die
	mkdir data || die
	tar -xf data.tar.* -C data || die
}

src_install() {
	cp -r data/opt "${D}/" || die
	dosym /opt/brave.com/brave/brave-browser /usr/bin/brave-browser
}

