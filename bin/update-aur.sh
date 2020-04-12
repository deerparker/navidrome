#! /bin/sh

# Based on Sumner Evens' contribution:
# https://aur.archlinux.org/cgit/aur.git/tree/update.sh?h=navidrome-bin

AUR_NAME=navidrome-bin
EXECUTABLE_NAME=navidrome
DESCRIPTION="Music Server and Streamer compatible with Subsonic/Airsonic"
URL=https://www.navidrome.org/
LICENSE='GPL3'
ADDITIONAL=

if [[ $# == 0 ]]; then
    echo 'Usage: ./update.sh VERSION_NUMBER'
    exit 1
fi
pkgrel=1
if [[ $# == 2 ]]; then
    pkgrel=$2
fi

printf '' > PKGBUILD
echo "# Maintainer: Deluan Quintao <navidrome [at] deluan [dot] com>

pkgbase='${AUR_NAME}'
pkgname=(${AUR_NAME})
pkgver='${GIT_TAG#"v"}'
pkgrel=$pkgrel
pkgdesc='${DESCRIPTION}'
url='${URL}'
license=('${LICENSE}')
arch=(x86_64 armv6h armv7h aarch64)
provides=('${EXECUTABLE_NAME}')
conflicts=('${EXECUTABLE_NAME}')
depends=('glibc' 'ffmpeg')
source_x86_64=('https://github.com/deluan/navidrome/releases/download/v$1/navidrome_$1_Linux_x86_64.tar.gz')
source_armv6h=('https://github.com/deluan/navidrome/releases/download/v$1/navidrome_$1_Linux_armv6.tar.gz')
source_armv7h=('https://github.com/deluan/navidrome/releases/download/v$1/navidrome_$1_Linux_armv7.tar.gz')
source_aarch64=('https://github.com/deluan/navidrome/releases/download/v$1/navidrome_$1_Linux_arm64.tar.gz')
sha256sums_x86_64=()
sha256sums_armv6h=()
sha256sums_armv7h=()
sha256sums_aarch64=()

package() {
  install -Dm755 \"\$srcdir/navidrome\" \"\$pkgdir/usr/bin/${EXECUTABLE_NAME}\"
}
" >> PKGBUILD

updpkgsums
makepkg --printsrcinfo > .SRCINFO

# Test
makepkg -f
