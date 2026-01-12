EAPI=8

DESCRIPTION="Brave Browser – privacy-focused Chromium-based web browser"
HOMEPAGE="https://brave.com/"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="strip"

SRC_URI="https://github.com/brave/brave-browser/releases/download/v${PV}/brave-browser_${PV}_amd64.deb"

S="${WORKDIR}"

QA_PREBUILT="
	/opt/brave.com/brave/brave
	/opt/brave.com/brave/chrome-sandbox
"

src_unpack() {
	ar x "${DISTDIR}/${A}" || die
	tar -xf data.tar.* || die
}

src_install() {
	insinto /
	doins -r opt || die

	# Forcer exécution sur tous les binaires et le wrapper
	for f in "${D}/opt/brave.com/brave/brave" \
			"${D}/opt/brave.com/brave/brave-browser" \
			"${D}/opt/brave.com/brave/chrome-sandbox"; do
		[[ -f "$f" ]] && chmod +x "$f"
	done

	# Symlinks vers le wrapper
	dosym /opt/brave.com/brave/brave-browser /usr/bin/brave-browser
	dosym /opt/brave.com/brave/brave-browser /usr/bin/brave
}

