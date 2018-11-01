#System language
lang en_US
#Language modules to install
langsupport en_US
#System keyboard
keyboard us
#System mouse
mouse
#System timezone
timezone America/New_York
#Root password
rootpw --iscrypted $1$gZQXjJlz$OVOpiCmTXl1aiOi.IZsED1
#Initial user
user juniper --fullname "juniper" --iscrypted --password $1$bj3TuznT$zcn8epIzJW7G95tBc18sU.
#Reboot after installation
reboot
#Use text mode install
text
#Install OS instead of upgrade
install
#Use hard drive installation media
harddrive --dir=/root/disks/ubuntu-16.04.5-server-amd64.iso --partition=/dev/dm-1
#Use Web installation
#url --url http://archive.ubuntu.com/ubuntu/dists/xenial/main/installer-amd64/
#System bootloader configuration
bootloader --location=mbr
#Clear the Master Boot Record
zerombr yes
# Skip question about not having swap partition
# partman-basicfilesystems partman-basicfilesystems/no_swap boolean false
#Partition clearing information
clearpart --all --initlabel
#Disk partitioning information
part / --fstype ext4 --size 30000 --grow --maxsize 1
part swap --recommended
#System authorization infomation
auth  --useshadow  --enablemd5
#Network information
network --hostname=jedi-seed --bootproto=static --ip=192.168.10.4 --netmask=255.255.255.0 --gateway=192.168.10.1 --nameserver=192.168.10.10 --device=eth0 --noipv6
#Firewall configuration
firewall --disabled
#Do not configure the X Window System
skipx
%packages
@ubuntu-server
openssh-server
vim
%post
echo "Post-installation script"
#!/bin/bash
exec < /dev/tty6 > /dev/tty6
chvt 6
systemctl enable serial-getty@ttyS0.service && systemctl start serial-getty@ttyS0.service
apt-get update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get install -y git python-pip software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get -y install ansible
chvt 1