# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.19
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
  amd64=b6cf943f4d2170881f3c4508d83dd4b511bbbb8c4b5a9d0a8e6f0d76d5f3b59a \
  386=ba2811e04d5d753a72887dcbf13b38c9503e0f22571a6337c4bdc89793ae537b \
  arm64=f0225f7a1ef6bebf1ca723cb87b239c8ec912faa6548844895fe94914d4e37ac \
  arm_v7=6efb035b1bb2870aca5ca3dbc4eea5eddccf3af4fa3945502126a0bd3882eab9 \
  arm_v6=ff441d9e381b9466b125e152a87a0e4317a2e6323d0729c04b7c10345571c22e \
  arm_v5=ba83ead5cf73b5f2ad4d762a04f986dc9e94a511370529c071f0d806c1f87aac \
  mips_softfloat=392d840243c978394c05aecda543c476b271910dfea71ce5e6ef5515ae8e75ea \
  mipsle_softfloat=2f7ae3a16f2dec8ad1a197ad7089d9556fd9a4c4ff31c65d69aa14075c31c01d \
  mips64=eeeeb6f894b94f9bd9b733a7adf7006cb971f2f6fb4911cd0bda829d720e0395 \
  mips64le=d50676a54236817b6001328362b06116774dbec8907b4c2dfc6fd9f306bca4e5 \
  loong64=bcb382bf7794f9f57027c258bd569b0b8ef9b5d19625ce17c370dd08193bece3 \
  riscv64=92247198d8acf6ed215e3dd203a1b57b1ca8bf4fd44333b06d45ff5dc5e91dfe
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
