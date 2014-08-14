VERSION=3.2.4
REL=1

packer build -var "aws_access_key=${AWS_ACCESS_KEY_ID}" \
             -var "aws_secret_key=${AWS_SECRET_ACCESS_KEY}" \
             -var "name=alerta-${VERSION}-${REL}" \
             amazon-ami.json
