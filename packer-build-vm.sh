#!/bin/sh

VERSION=$1
RELEASE=${2:-1}

if [ "$VERSION" == "" ]
then
  echo "Usage: $(basename $0) VERSION [RELEASE]"
  exit 1
fi

packer build -var "name=alerta-${VERSION}-${RELEASE}" vm-images.json
