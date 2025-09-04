# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.2
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
	NPC_ARCH:=mipsle_softfloat
endif
ifeq ($(filter mips64el,$(ARCH)),mips64el)
	NPC_ARCH:=mips64le
endif
ifeq ($(filter mips64,$(ARCH)),mips64)
	NPC_ARCH:=mips64
endif
ifeq ($(filter mips,$(ARCH)),mips)
	NPC_ARCH:=mips_softfloat
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
  amd64=ebafe2388fab6a64cf3eae959e51153eca4a0f71424238d4a39276d71d7ce8c6 \
  386=b547527089f19ec259af48bfba0dc2b1f465d1a204b0faa8a6e836e14a96df22 \
  arm64=2436b2cdbbb455d0fe54061b4febb6f29b343bdd38ae8ac3f5129189da19c436 \
  arm_v7=d65277c86651d2737c0a732d802cad9d1a736b5dceadb3c1cd08b7d706ed9ca9 \
  arm_v6=ff84fabf99f459d5edec1a3ba692f4fcf1e8d123e74df8e13bdcabad99b69e28 \
  arm_v5=a59ada0a16d5bf981d617cf6f52b9b5e3dda0b48f80c5c5f03e6f0052b462f56 \
  mips_softfloat=355561447e671367c0c3b7ef69d6c7685fcab8616aad9d03d18c5786f955a797 \
  mipsle_softfloat=31d78f62f0f18779dab30e289938215575982cf6fb029807152f82cbc1cbeaca \
  mips64=3cc0dbe1549ff1d6506d662533018772da9fe5707d1debb31c9a62d18d0d5112 \
  mips64le=f87cb37ee32ce14741a24d4036b86360257436ebe384ff9837cb590d15cb3fc6 \
  loong64=578d17372f79401f052919b09479592e1bfdceeb4101ef2cfff4cbb0ebc4e4be \
  riscv64=b30e22878116c9563fe4f05180e2e31e275f4b53ddd5bc6ef7f3ac03e1c18f86
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
