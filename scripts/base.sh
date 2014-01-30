apt-get -y update
apt-get -y upgrade
apt-get -y install curl wget
# Ensure NFS mounts work properly
apt-get -y install nfs-common
apt-get clean
