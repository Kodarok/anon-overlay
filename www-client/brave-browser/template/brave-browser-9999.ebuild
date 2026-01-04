EAPI=8

DESCRIPTION="Brave Browser – privacy-focused Chromium-based web browser"
HOMEPAGE="https://brave.com/"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64"

SRC_URI="https://github.com/brave/brave-browser/releases/download/v@VERSION@/brave-browser_@VERSION@_amd64.deb"

S="\${WORKDIR}"

src_unpack() {
	ar x "\${DISTDIR}/brave-browser_@VERSION@_amd64.deb" || die
	tar -xf data.tar.* || die
}

src_install() {
	cp -r opt "\${D}/" || die
	dosym /opt/brave.com/brave/brave-browser /usr/bin/brave-browser
}

