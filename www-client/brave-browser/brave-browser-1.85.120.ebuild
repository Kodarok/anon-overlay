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
	/opt/brave.com/brave/brave-browser
	/opt/brave.com/brave/chrome-sandbox
"

src_unpack() {
	ar x "${DISTDIR}/${A}" || die
	tar -xf data.tar.* || die
}

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
	/opt/brave.com/brave/brave-browser
	/opt/brave.com/brave/chrome-sandbox
"

src_unpack() {
	ar x "${DISTDIR}/${A}" || die
	tar -xf data.tar.* || die
}

src_install() {
	# Installer tout ce que le deb fournit
	insinto /
	doins -r .

	# Supprimer le cron Brave (Gentoo-style)
	rm -f "${ED}/etc/cron.daily/brave-browser"

	# Permissions exécutables
	fperms +x /opt/brave.com/brave/brave
	fperms +x /opt/brave.com/brave/brave-browser
	fperms +x /opt/brave.com/brave/chrome-sandbox

	# Commandes utilisateur
	dosym /opt/brave.com/brave/brave-browser /usr/bin/brave-browser
	dosym /opt/brave.com/brave/brave-browser /usr/bin/brave
}
