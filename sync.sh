#!/bin/sh
set -e

REPONAME="ypcs"

S3CMD="/usr/bin/s3cmd"
S3BUCKET="ypcs-repository"
S3PREFIX="repos/"

TARGET="s3://${S3BUCKET}/${S3PREFIX}${REPONAME}"

echo "I: Sign install.sh..."
sha256sum install.sh |tee install.sh.sha256
gpg -a --sign install.sh.sha256

echo "I: Sync config, tools..."
${S3CMD} sync install.sh ${TARGET}/
${S3CMD} sync install.sh.sha256 ${TARGET}/
${S3CMD} sync install.sh.sha256.asc ${TARGET}/
${S3CMD} sync conf ${TARGET}/
${S3CMD} sync logs ${TARGET}/
cd www/debian
${S3CMD} sync index.html ${TARGET}/ 
cd ../..

echo "I: Sync reprepro database..."
${S3CMD} sync db ${TARGET}/

echo "I: Sync pool..."
cd www/debian
${S3CMD} sync pool ${TARGET}/

echo "I: Sync dists..."
${S3CMD} sync dists ${TARGET}/
