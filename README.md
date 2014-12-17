Packer Templates for Alerta
===========================
Used to build the vm images available for download on [alerta.io](http://alerta.io/).

Set-up
------
To build an [Amazon AMI](https://www.packer.io/docs/builders/amazon-ebs.html) check the base AMI image is correct for your region and then validate the template:

    $ packer validate amazon-ami.json
    
To build a [VMWare](https://www.packer.io/docs/builders/vmware-iso.html) or [VirtualBox](https://www.packer.io/docs/builders/virtualbox-iso.html) image ensure that the virtualisation software is locally installed and then validate the template:

    $ packer validate vm-images.json

Build Images
------------
To build an Amazon AMI run:

    $ packer-build-ami.sh VERSION RELEASE

To build a VMWare Image and a VirtualBox image run:

    $ packer-build-vm.sh VERSION RELEASE


License
-------
Copyright (c) 2014 Nick Satterly. Available under the MIT License.
