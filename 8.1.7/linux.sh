#!/bin/bash

#
# Tested Redhat 6.2 (Zoot)
#  Linux/Linux 2.2
#  1 GB memory
#  8 GB disk
#  Network -> Bridge Adapter (VirtualBox)
#
#  Type 'text' for text mode installation
#  Install Custom
#  X Window System
#  GNOME
#  Networked Worksatation
#  Anonymous FTP Server
#  Network Management Workstation
#  Development
#  Kernel Development
#  Utilities
#  Generic SVGA
#
#

# Checklist
# [Redhat 6.2 (zoot)] - mount iso to /mnt
# [Oracle 8.1.7] - /tmp/linux81701.tar.bz2
# [Sun JDK 1.2.2] for linux - /tmp/jdk-1_2_2_017-linux-i586.tar.gz
# [xming] will be serving runInstaller as xwindow server, oracle server will be xwindow client
#  Install xming on your workstation
#  Make sure oracle server ip is added to x0.hosts under xming directory (e.g. C:\Program Files (x86)\Xming\X0.hosts)
#  Turn off Windows firewall on your workstation to let xming traffic pass through
#  Make sure xming is launched on your workstation
#  Make sure XMING_IP is set to your workstation ip
#

# Source env
if [ -f ./env ]; then
 . ./env
else
 echo "env file not found, run setup to create env file"
 exit 1
fi

# Source function.sh
source function.sh
#num_lines=$( lines_in_file $1 )
#echo The file $1 has $num_lines lines in it.

if xming_check ; then
#
# Database software installation, run as root user
#

#oracle user and groups creation
cr_user_and_groups

# Only if firewall is on
ipchains_off

if [ -f "$JAVA_SW" ]; then
  cd /usr/local
  tar xvfz $JAVA_SW
  ln -s jdk1.2.2 java
else
  echo "JAVA Software not found - $JAVA_SW"
  exit 1
fi

#.bash_profile
cr_profile $O_VER

#Create directories for software and database
cr_directories

#echo "oracle soft nofile 65536
#oracle hard nofile 65536
#oracle soft nproc 16384
#oracle hard nproc 16384" >> /etc/security/limits.conf


# Required packages
cd /mnt/cdrom/RedHat/RPMS/
rpm -ivh \
XFree86-3.3.6-20.i386.rpm \
XFree86-libs-3.3.6-20.i386.rpm \
XFree86-xfs-3.3.6-20.i386.rpm \
make-3.78.1-4.i386.rpm \
egcs-1.1.2-30.i386.rpm \
cpp-1.1.2-30.i386.rpm \
glibc-devel-2.1.3-15.i386.rpm \
kernel-headers-2.2.14-5.0.i386.rpm

# Making shell script for oracle installer
echo "mkdir $ORACLE_SW_STG
cd $ORACLE_SW_STG
bunzip2 -cd $ORACLE_SW1 | tar xvf -
export DISPLAY=$XMING_IP:0.0
$ORACLE_SW_STG/Disk1/runInstaller" > $SCRIPT_DIR/inst_ora_sw

# Adding execute permission to all users
chmod a+x $SCRIPT_DIR/inst_ora_sw

# unzip; set DISPLAY; runInstaller as oracle
su - $O_USER -c $SCRIPT_DIR/inst_ora_sw
else
  echo "xming check failed"
fi

