#!/bin/bash

export IP=""

if [ -z "${VERSION}" ]; then
  export VERSION="1.0.6"
fi

ARCHITECTURE=$(dpkg --print-architecture)
CLOUDPANEL_DEB_URL=https://github.com/cloudpanel-io/cloudpanel-ce/releases/download/v$VERSION/cloudpanel.deb

die()
{
  /bin/echo -e "ERROR: $*" >&2
  exit 1
}

checkRoot()
{
  if [ `id -u` -ne 0 ]; then
    die "You should have superuser privileges to install CloudPanel"
  fi
}

checkCloudPanelVersion()
{
  if ! curl --output /dev/null --silent --head --fail "$CLOUDPANEL_DEB_URL"; then
    die "CloudPanel Version $VERSION does not exist."
  fi
}

checkOperatingSystem()
{
  if [ ! -f '/etc/debian_version' ]; then
    die "Operating system is not supported. Only Debian is supported."
  else
    DEBIAN_VERSION=$(cat /etc/debian_version)
    DEBIAN_MAIN_VERSION=`echo $DEBIAN_VERSION | cut -d "." -f -1`
    if [ "$DEBIAN_MAIN_VERSION" != "10" ]; then
      die "Only Debian Buster is supported"
    fi
  fi
}

setIp()
{
  IP=$(curl -sk --connect-timeout 10 --retry 3 --retry-delay 0 https://d3qnd54q8gb3je.cloudfront.net/)
  IP=$(echo "$IP" | cut -d"," -f1)
}

setupRequiredPackages()
{
  apt update
  apt -y install gnupg apt-transport-https
  DEBIAN_FRONTEND=noninteractive apt-get install -y postfix
}

addAptSourceList()
{
  curl -Lks https://d17k9fuiwb52nc.cloudfront.net/key.gpg | apt-key add -
  curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

  if [[ "$ARCHITECTURE" == "arm64" ]]; then
    ORIGIN="d2xpdm4jldf31f.cloudfront.net"
  else
    ORIGIN="d17k9fuiwb52nc.cloudfront.net"
  fi

  CLOUDPANEL_SOURCE_LIST=$(cat <<-END
deb https://$ORIGIN/ buster main
deb-src https://$ORIGIN/ buster main

deb https://$ORIGIN/ buster nginx
deb-src https://$ORIGIN/ buster nginx

deb https://$ORIGIN/ buster php-7.1
deb-src https://$ORIGIN/ buster php-7.1

deb https://$ORIGIN/ buster php-7.2
deb-src https://$ORIGIN/ buster php-7.2

deb https://$ORIGIN/ buster php-7.3
deb-src https://$ORIGIN/ buster php-7.3

deb https://$ORIGIN/ buster php-7.4
deb-src https://$ORIGIN/ buster php-7.4

deb https://$ORIGIN/ buster php-8.0
deb-src https://$ORIGIN/ buster php-8.0

deb https://$ORIGIN/ buster percona-server-server-5.7
deb-src https://$ORIGIN/ buster percona-server-server-5.7

deb https://$ORIGIN/ buster proftpd
deb-src https://$ORIGIN/ buster proftpd

END
)

CLOUDPANEL_APT_PREFERENCES=$(cat <<-END
Package: *
Pin: origin $ORIGIN
Pin-Priority: 1000
END
)

  echo 'deb https://deb.nodesource.com/node_14.x buster main' > /etc/apt/sources.list.d/nodesource.list
  echo 'deb-src https://deb.nodesource.com/node_14.x buster main' >> /etc/apt/sources.list.d/nodesource.list

  echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list

  echo -e "$CLOUDPANEL_SOURCE_LIST" > /etc/apt/sources.list.d/packages.cloudpanel.io.list
  echo -e "$CLOUDPANEL_APT_PREFERENCES" > /etc/apt/preferences.d/00packages.cloudpanel.io.pref
  apt update
}

setupCloudPanel()
{
  addAptSourceList
  rm -rf /etc/mysql/
  curl -Lks $CLOUDPANEL_DEB_URL -o /tmp/cloudpanel.deb
  DEBIAN_FRONTEND=noninteractive apt -o Dpkg::Options::="--force-overwrite" install -y -f /tmp/cloudpanel.deb
  showSuccessMessage
}

showSuccessMessage()
{
  CLOUDPANEL_URL_FILE="/etc/cloudpanel/.cloudpanel_url"
  if [ -f "$CLOUDPANEL_URL_FILE" ]; then
    CLOUDPANEL_URL=$(cat /etc/cloudpanel/.cloudpanel_url)
    printf "\n\n"
    printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
    printf "The installation of CloudPanel is complete!\n\n"
    printf "CloudPanel can be accessed now: $CLOUDPANEL_URL\n"
    printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
  fi
}

checkRoot
checkOperatingSystem
checkCloudPanelVersion
setIp
setupRequiredPackages
setupCloudPanel
