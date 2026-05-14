EAPI=8

DESCRIPTION="Visual Studio Code"
HOMEPAGE="https://code.visualstudio.com/"

LICENSE="Microsoft"
SLOT="0"
KEYWORDS="amd64"

SRC_URI="https://update.code.visualstudio.com/1.112.0/linux-deb-x64/stable -> vscode-1.112.0.deb"

S="${WORKDIR}"

src_unpack() {
	ar x "${DISTDIR}/vscode-1.112.0.deb" || die
	tar -xf data.tar.* || die
}

src_install() {
	cp -r usr "${D}/" || die
}

