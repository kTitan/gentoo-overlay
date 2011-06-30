# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

EGIT_REPO_URI=git://eplists.constabel.net/git/VDRSeriesTimer.git
EGIT_BRANCH=master
if [[ ${PV} == "9999" ]] ; then
	inherit git-2
	KEYWORDS=""
else
	MY_P="VDRSeriesTimer-${PV}"
	SRC_URI="http://www.constabel.net/files/vdr/${MY_P}.tgz"
	KEYWORDS="~x86"
	S="${WORKDIR}/${MY_P}"
fi

IUSE=""

DESCRIPTION="VDR Script: Episodes for epgsearch"
HOMEPAGE="http://www.constabel.net/vdr/scripts.de.htm"

SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-plugins/vdr-epgsearch-0.9.19
>=virtual/perl-PodParser-1.35
>=virtual/perl-Getopt-Long-2.36
>=dev-perl/Text-LevenshteinXS-0.03
dev-perl/config-general
dev-perl/libintl-perl
dev-perl/IO-Socket-SSL"

ETC_DIR="/etc/eplists"
EPS_DIR="/var/vdr/eplists/episodes"

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git-2_src_unpack
	else
		unpack ${A}
	fi
	cd "${S}"
}

src_compile() {
	make i18n

	find man -name "*.gz" -exec gunzip {} \;
}

src_install() {
	eval `perl '-V:package'`
	eval `perl '-V:version'`
	dobin src/*.pl
	dodoc FAQ HISTORY README.i18n *.README.DE etc/*.example
	doman man/*/*
	domo locale/*/*/*.mo

	dodir /usr/lib/${package}/${version}
	cp src/*.pm "${D}"/usr/lib/${package}/${version}

	dodir "${ETC_DIR}"
	insinto "${ETC_DIR}"
	doins "${FILESDIR}"/vdrseriestimer.conf
	insinto /etc/vdr/plugins/epgsearch
	doins "${FILESDIR}"/epgsearchuservars.conf

	dodir ${EPS_DIR}

	insinto /etc/cron.daily
	newins "${FILESDIR}"/cron.daily eplists.cron

	elog "if this is a new install, please consider to run"
	elog "emerge --config =${PF}"
}

pkg_config () {
	if [[ -d ${EPS_DIR} ]]; then
		ewarn "getting episode lists"
		ewarn "please wait"
		wget --no-check-certificate -q \
			https://ssl.constabel-it.de/eplists.constabel.net/eplists_full_utf8.tgz \
			-O - | tar xfz - -C ${EPS_DIR}/../
		chown -R vdr:vdr ${EPS_DIR}
	fi
}
