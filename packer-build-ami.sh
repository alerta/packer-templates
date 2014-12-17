#!/bin/sh

VERSION=$1
RELEASE=${2:-1}

if [ "$VERSION" == "" ]
then
  echo "Usage: $(basename $0) VERSION [RELEASE]"
  exit 1
fi

packer build -var "aws_access_key=${AWS_ACCESS_KEY_ID}" \
             -var "aws_secret_key=${AWS_SECRET_ACCESS_KEY}" \
             -var "name=alerta-${VERSION}-${RELEASE}" \
             amazon-ami.json
