EAPI=8

DESCRIPTION="Brave Browser – privacy-focused Chromium-based web browser"
HOMEPAGE="https://brave.com/"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64"

SRC_URI="https://github.com/brave/brave-browser/releases/download/v1.85.120/brave-browser_1.85.120_amd64.deb"

S="\${WORKDIR}"

src_unpack() {
	ar x "\${DISTDIR}/brave-browser_1.85.120_amd64.deb" || die
	tar -xf data.tar.* || die
}

src_install() {
	cp -r opt "\${D}/" || die
	dosym /opt/brave.com/brave/brave-browser /usr/bin/brave-browser
}

