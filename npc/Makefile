# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.34.7
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
  amd64=7d9cfa0b1ab31a61d208e64914aaa78e03d2daa7780578d2e3ebf7209e64fa09 \
  386=9d4ccceeaa392658a155d31f686efbf1b85694692f568f0985e929c31ccf0229 \
  arm64=7300df22608b1617b95a939284c32a8d9f57defbebfe774280bb3c800c5bd3c9 \
  arm_v7=97fbfa4a961db5978cb3f25ca141580cea0e4e758fa15806c45fcd39856c9de4 \
  arm_v6=74e376909b7c8932cc7c2d467c755bdc8603e02d59abb01ec7fadfbb3d59584c \
  arm_v5=7039b037eee7a4ac6698ade3cbb1f28c927aa7b153bfba1ed566a42843d5c0b9 \
  mips_softfloat=b29cd8c359e752eae4a2be3fbea1d3924f0f41e9b091b0570a61866085926ffb \
  mipsle_softfloat=511d590131f8e13c8157f36bc7e0cf863a65e8b363b06d8e1a4e6b74ed21995d \
  mips64=7cfd3c45442cf7abe220452f8bf1856d1a6f0c6886c71fd2e6abf03d445c7e7e \
  mips64le=47fd0a0e9567e57901f8210ac475d21a4363e1b26808e1eb1f37caa8d00143c2 \
  loong64=8ca20e2a178bcecd3965243df18404a0b6d378c884de856c59654c684d51a09a \
  riscv64=1a954dd318cacf416ca83529e595f017f54f3239813b8a33c0fd095e5b3ffd7c
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
