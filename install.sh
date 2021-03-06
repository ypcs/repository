#!/bin/sh
set -e

DIST="jessie"

TEMPFILE="$(mktemp)"

cat > ${TEMPFILE} << EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

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
sXjS9qpCdO4R/dY=
=oLvG
-----END PGP PUBLIC KEY BLOCK-----
EOF
apt-key add ${TEMPFILE}
rm -f ${TEMPFILE}
#cp ${TEMPFILE} /etc/apt/trusted.gpg.d/ypcs.gpg

apt-get -y install apt-transport-https

cat > /etc/apt/sources.list.d/ypcs.list << EOF
deb https://cdn.ypcs.fi/repos/ypcs ${DIST} main contrib non-free
#deb-src https://cdn.ypcs.fi/repos/ypcs ${DIST} main contrib non-free
EOF

apt-get update
apt-get -y install ypcs-archive-keyring
