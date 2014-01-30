Packer.io Templates for Alerta
==============================

Used to build the vm images available for download on [alerta.io](http://alerta.io/).

To build an Amazon AMI:
```
$ packer validate amazon-ami.json
$ packer build -var 'aws_access_key=YOUR ACCESS KEY' -var 'aws_secret_key=YOUR SECRET KEY' \
  -var 'name=alerta-2.0.65' amazon-ami.json
```

To build a VMWare Image and a VirtualBox image:
```
$ packer validate amazon-ami.json
$ packer build -var 'name=alerta-2.0.65' vm-images.json
```

License
-------

Copyright (c) 2014 Nick Satterly. Available under the MIT License.
