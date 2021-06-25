# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit python-any-r1 bash-completion-r1

RESTRICT="mirror"

DESCRIPTION="Wrapper for the Google cloud SDK."
SLOT="0"
SRC_URI="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${PV}-linux-x86_64.tar.gz"

LICENSE="Google-TOS"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/google-cloud-sdk"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

COMMANDS=( gcloud gsutil docker-credential-gcloud )

src_install() {
	dodir ${ROOT}/usr/share/google-cloud-sdk
	cp -R "${S}/" "${D}/usr/share/" || die "Install failed!"
	for c in ${COMMANDS[@]}
	do
		dosym ${D}/usr/share/google-cloud-sdk/bin/$c /usr/bin/$c
	done
	newbashcomp ${D}/usr/share/google-cloud-sdk/completion.bash.inc gcloud
	bashcomp_alias gcloud gsutil bq
}
