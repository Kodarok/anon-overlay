EAPI=8

DESCRIPTION="Visual Studio Code – template ebuild (DO NOT BUILD)"
HOMEPAGE="https://code.visualstudio.com/"

LICENSE="Microsoft"
SLOT="0"
KEYWORDS=""
RESTRICT="fetch mirror"

SRC_URI=""

S="${WORKDIR}"

pkg_pretend() {
die "vscode-bin-9999.ebuild is a template. Do not emerge."
}

