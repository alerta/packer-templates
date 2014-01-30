Packer.io Templates for Alerta
==============================

Used to build the vm images available for download on [alerta.io](http://alerta.io/).

```
$ packer validate alerta.json
$ packer build -var 'aws_access_key=YOUR ACCESS KEY' -var 'aws_secret_key=YOUR SECRET KEY' \
  -var 'release=2.0.65' alerta.json
```

License
-------

Copyright (c) 2014 Nick Satterly. Available under the MIT License.
