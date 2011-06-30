# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

RESTRICT="mirror strip"

inherit vdr-plugin git-2

EGIT_REPO_URI=git://projects.vdr-developer.org/vdr-plugin-xmltv2vdr.git
DESCRIPTION="VDR plugin: XMLTV 2 VDR Plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-xmltv2vdr"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=media-video/vdr-1.7.14"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin_src_prepare
}

src_install() {
	vdr-plugin_src_install

	dodir /var/lib/epgsources
	fowners vdr:vdr /var/lib/epgsources
}
