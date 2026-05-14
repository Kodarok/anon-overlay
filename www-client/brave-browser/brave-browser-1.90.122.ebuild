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
	# Copier exactement ce que fournit le .deb
	cp -a . "${D}" || die

	# Supprimer le cron Brave (non souhaité sur Gentoo)
	rm -f "${D}/etc/cron.daily/brave-browser"

	# Permissions exécutables (deb foireux)
	fperms +x /opt/brave.com/brave/brave
	fperms +x /opt/brave.com/brave/brave-browser
	fperms +x /opt/brave.com/brave/chrome-sandbox

	# Commandes utilisateur
	dosym /opt/brave.com/brave/brave-browser /usr/bin/brave-browser
	dosym /opt/brave.com/brave/brave-browser /usr/bin/brave
}
