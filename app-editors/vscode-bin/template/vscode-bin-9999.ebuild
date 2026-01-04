EAPI=8

DESCRIPTION="Visual Studio Code"
HOMEPAGE="https://code.visualstudio.com/"

LICENSE="Microsoft"
SLOT="0"
KEYWORDS="amd64"

SRC_URI="https://update.code.visualstudio.com/@VERSION@/linux-deb-x64/stable -> vscode-@VERSION@.deb"

S="${WORKDIR}"

src_unpack() {
	ar x "${DISTDIR}/vscode-@VERSION@.deb" || die
	tar -xf data.tar.* || die
}

src_install() {
	cp -r usr "${D}/" || die
}

