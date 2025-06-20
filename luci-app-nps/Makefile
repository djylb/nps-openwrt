# Copyright (C) 2008-2014 The LuCI Team <luci@lists.subsignal.org>
# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-nps
PKG_VERSION:=1.7
PKG_RELEASE:=7

LUCI_TITLE:=LuCI support for NPS
LUCI_DEPENDS:=+nps
LUCI_PKGARCH:=all

define Package/$(PKG_NAME)/conffiles
/etc/config/nps
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
