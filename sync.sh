#!/bin/sh
set -e

REPONAME="ypcs"

S3CMD="/usr/bin/s3cmd"
S3BUCKET="ypcs-repository"
S3PREFIX="repos/"

TARGET="s3://${S3BUCKET}/${S3PREFIX}${REPONAME}"

echo "I: Sync config, tools..."
${S3CMD} sync install.sh ${TARGET}/
${S3CMD} sync install.sh.asc ${TARGET}/
${S3CMD} sync conf ${TARGET}/
${S3CMD} sync logs ${TARGET}/

echo "I: Sync reprepro database..."
${S3CMD} sync db ${TARGET}/

echo "I: Sync pool..."
cd www/debian
${S3CMD} sync pool ${TARGET}/

echo "I: Sync dists..."
${S3CMD} sync dists ${TARGET}/
