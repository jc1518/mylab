#!/bin/bash

LOCKFILE="/etc/yum/pluginconf.d/versionlock.list"
APPLICATIONS="httpd bind"

# Backup old versionlock list
cp -f $LOCKFILE $LOCKFILE.bak

# Add the current working version to lockversion list
cat > $LOCKFILE << NOTE
## NOTICE: THIS FILE IS MANAGED BY PUPPET ##
# You get this EPOCH:NAME-VERSION-RELEASE.ARCH format by running:
# eg. rpm -q tomcat6 --qf "%|epoch?{%{epoch}}:{0}|:%{name}-%{version}-%{release}.%{arch}\n"
#
# The following lines cause yum to not upgrade the packages to newer version:
NOTE

for app in $APPLICATIONS
do
	for myapp in $(rpm -qa | grep $app)
	do  
		rpm -q $myapp --qf "%|epoch?{%{epoch}}:{0}|:%{name}-%{version}-%{release}.%{arch}\n" >> $LOCKFILE
	done
done

