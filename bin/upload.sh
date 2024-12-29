#!/bin/bash

set -e
# set -x

function err() {
    echo "error: $@"
} >/dev/stderr

if [[ -z ${SITE_SOURCE_ROOT} ]]
then
    err "mandatory environment variable SITE_SOURCE_ROOT not set"
    exit 1
fi

if [[ -z ${SITE_HOST} ]]
then
    err "mandatory environment variable SITE_HOST not set"
    exit 1
fi

if [[ -z ${SITE_INTERNET_DOMAIN} ]]
then
    err "mandatory environment variable SITE_INTERNET_DOMAIN not set"
    exit 1
fi

if [[ -z ${SITE_USER} ]]
then
    err "mandatory environment variable SITE_USER not set"
    exit 1
fi

declare -r build_dir=${SITE_SOURCE_ROOT}/build

if [[ ! -d ${build_dir} ]]
then
    err "build directory ${build_dir} doesn't exists"
    exit 1
fi

rsync --verbose \
 --recursive \
 --times \
 --chmod=F644 \
 --delete \
 ${build_dir}/ \
 ${SITE_USER}@${SITE_HOST}:~/${SITE_INTERNET_DOMAIN}
