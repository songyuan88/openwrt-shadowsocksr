#
# Copyright (C) 2016 Jian Chang <aa65535@live.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocksr-libev
PKG_VERSION:=2.5.2
PKG_RELEASE:=bc1bbecc49ab5a9afb4ab7076f0d9359dc0493d1

PKG_SOURCE_PROTO:=git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.gz
PKG_SOURCE_URL:=https://github.com/shadowsocksrr/shadowsocksr-libev.git
PKG_SOURCE_VERSION:=$(PKG_RELEASE)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE)

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=chenhw2 <https://github.com/chenhw2/openwrt-shadowsocksr>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocksr-libev/Default
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Lightweight Secured Socks5 Proxy
	URL:=https://github.com/shadowsocksrr/shadowsocksr-libev
	DEPENDS:=+libmbedtls +libpcre +libpthread
endef

Package/shadowsocksr-libev = $(call Package/shadowsocksr-libev/Default)

define Package/shadowsocksr-libev/description
shadowsocksr-libev is a lightweight secured socks5 proxy for embedded devices and low end boxes.
endef

CONFIGURE_ARGS += --disable-ssp --disable-documentation --disable-assert --with-crypto-library=mbedtls

define Package/shadowsocksr-libev/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-local $(1)/usr/bin/ssr-local
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-redir $(1)/usr/bin/ssr-redir
	$(LN) ssr-local $(1)/usr/bin/ssr-tunnel
endef

$(eval $(call BuildPackage,shadowsocksr-libev))
