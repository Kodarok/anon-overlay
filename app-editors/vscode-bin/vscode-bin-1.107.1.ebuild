EAPI=8

DESCRIPTION="Visual Studio Code – template ebuild (DO NOT BUILD)"
HOMEPAGE="https://code.visualstudio.com/"

LICENSE="Microsoft"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip fetch"

SRC_URI=""

S="${WORKDIR}"

pkg_pretend() {
die "vscode-bin-9999.ebuild is a template. It must not be emerged."
}
