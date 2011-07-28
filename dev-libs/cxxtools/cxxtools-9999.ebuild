# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cxxtools/cxxtools-2.0.ebuild,v 1.1 2011/01/19 19:01:30 hd_brummy Exp $

EAPI="2"

inherit autotools eutils subversion

ESVN_REPO_URI="https://cxxtools.svn.sourceforge.net/svnroot/cxxtools/trunk/cxxtools"
ESVN_PROJECT="cxxtools"
ESVN_BOOTSTRAP=""

DESCRIPTION="Collection of general purpose C++-classes"
HOMEPAGE="http://www.tntnet.org/cxxtools.hms"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/libiconv"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog
}
