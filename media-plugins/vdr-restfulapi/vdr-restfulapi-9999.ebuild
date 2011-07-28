# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

RESTRICT="mirror strip"

inherit vdr-plugin git-2

EGIT_REPO_URI="https://github.com/yavdr/vdr-plugin-restfulapi.git"
DESCRIPTION="VDR plugin: Restful API VDR Plugin"
HOMEPAGE="https://github.com/yavdr/vdr-plugin-restfulapi"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=media-video/vdr-1.7.16
	>dev-libs/cxxtools-2.0"
RDEPEND="${DEPEND}"
