EAPI=8

DESCRIPTION="Brave Browser – privacy-focused Chromium-based web browser"
HOMEPAGE="https://brave.com/"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64"

SRC_URI="https://github.com/brave/brave-browser/releases/download/v1.97.59/brave-browser_1.97.59_amd64.deb -> brave-browser_1.97.59.deb"

S="${WORKDIR}"

QA_PREBUILT="
    /opt/brave.com/brave/*
"

src_unpack() {
    ar x "${DISTDIR}/${A}" || die
    tar -xf data.tar.* || die
}

src_install() {
    cp -a opt usr etc "${ED}/" || die

    fperms 4755 /opt/brave.com/brave/chrome-sandbox
}
