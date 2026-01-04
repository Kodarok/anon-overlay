EAPI=8

DESCRIPTION="Brave Browser – template ebuild"
HOMEPAGE="https://brave.com/"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="fetch mirror"

SRC_URI=""
S="${WORKDIR}"

pkg_pretend() {
die "Template ebuild. Do not emerge."
}
