# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.28.2
PKG_RELEASE:=1
PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=Duan <duan@d-jy.net>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

NPS_URL=https://github.com/djylb/nps

NPC_ARCH:=
ifeq ($(ARCH),x86_64)
	NPC_ARCH:=amd64
endif
ifeq ($(ARCH),i386)
	NPC_ARCH:=386
endif
ifeq ($(ARCH),aarch64)
	NPC_ARCH:=arm64
endif
ifeq ($(findstring armv8,$(BOARD)),armv8)
	NPC_ARCH:=arm64
endif
ifeq ($(ARCH),arm)
	ifeq ($(BOARD),bcm53xx)
		NPC_ARCH:=arm_v6
	else ifeq ($(BOARD),kirkwood)
		NPC_ARCH:=arm_v5
	else
		NPC_ARCH:=arm_v7
	endif
endif
ifeq ($(filter mipsel,$(ARCH)),mipsel)
	NPC_ARCH:=mipsle
endif
ifeq ($(filter mips64el,$(ARCH)),mips64el)
	NPC_ARCH:=mips64le
endif
ifeq ($(filter mips64,$(ARCH)),mips64)
	NPC_ARCH:=mips64
endif
ifeq ($(filter mips,$(ARCH)),mips)
	NPC_ARCH:=mips
endif
ifeq ($(filter loongarch64,$(ARCH)),loongarch64)
	NPC_ARCH:=loong64
endif
ifeq ($(filter riscv64,$(ARCH)),riscv64)
	NPC_ARCH:=riscv64
endif

PKG_SOURCE:=linux_$(NPC_ARCH)_client.tar.gz
PKG_SOURCE_URL:=$(NPS_URL)/releases/download/v$(PKG_VERSION)/

# === NPC_HASH_TABLE_START ===
NPC_HASHES:= \
  amd64=f0855204d844687ba5fe51b6bfd627b408d909f10a1cdded9f1eb931e4d4705d \
  386=c4e9db01a7e97cffe9adf7039da7662ea2fec58c77cad547592945e0ff4f8317 \
  arm64=c9982aec7f213ce39a54b612a0e97a933cecb622c77b0825748ca67d83315f6a \
  arm_v7=794e1f6a9aed85fa37617aabd2c0807b5f61a775940fb44203223245257d96bf \
  arm_v6=19615b575119ca682919edb13ed17a7cf09c8d22b27f753e6d4faa32597a3d0d \
  arm_v5=71fda153ff6d86af68d15e484c4a4f82caba69827655f1bb9fd38be520e9bd27 \
  mips=d87a92a30cd71d277e5a0e8d25cf2edf48bd88d8e48e8387ed22e7e8f3e9d8d2 \
  mipsle=3c494820acc5918d0fac1c9dc9cbf17ff8659d083e7f614c50be49055d369a4c \
  mips64=8b9d531d5d1879ca6c4fbf87f46748cc4f20ad8a9ca20cbb4de9652fb6f065e7 \
  mips64le=7c91efc0207fb4165acbe62ac2623aae578fbb12a5758b49a2ac8a2a398c61c3 \
  loong64=fde9a8ee2ff2b54e3ae9397a11211d2af4626920deb8cbf1310d7c8c0fd64776 \
  riscv64=a4314e5b14770b81e7e92f4fc83fefeea1e4ac9ef87665e66313f8975b538cd2
# === NPC_HASH_TABLE_END ===

PKG_HASH:=$(strip $(foreach pair,$(NPC_HASHES), $(if $(findstring $(NPC_ARCH),$(pair)),$(word 2, $(subst =, ,$(pair))))))

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=NPC Client (precompiled for $(NPC_ARCH))
	URL:=$(NPS_URL)
endef

define Package/$(PKG_NAME)/description
NPC is a fast reverse proxy client to expose local servers through NAT/firewall.
This package uses the precompiled binary for the $(NPC_ARCH) architecture.
endef

define Build/Compile
	mkdir -p $(PKG_BUILD_DIR)
	tar -xzf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin/$(PKG_NAME)
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
