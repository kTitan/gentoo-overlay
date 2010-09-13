# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/uzbl/uzbl-9999.ebuild,v 1.16 2010/04/04 15:36:16 wired Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils

IUSE=""
if [[ ${PV} == *9999* ]]; then
	inherit git
	EGIT_REPO_URI=${EGIT_REPO_URI:-"git://github.com/dbr/tvnamer.git"}
	KEYWORDS=""
	SRC_URI=""
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="http://github.com/dbr/${PN}/tarball/${PV} -> ${P}.tar.gz"
fi

DESCRIPTION="Automatic TV episode file renamer, uses data from thetvdb.com via
tvdb_api."
HOMEPAGE="http://github.com/dbr/tvnamer"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="dev-python/tvdb_api
	dev-python/simplejson"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	if [[ ${PV} == *9999* ]]; then
		git_src_prepare
	else
		cd "${WORKDIR}"/dbr-tvnamer-*
		S=$(pwd)
	fi
}

src_install() {
	distutils_src_install

	python_generate_wrapper_scripts -E -f -q "${D%/}${EPREFIX}/usr/bin/tvnamer"
}
