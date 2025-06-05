# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.15
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
  amd64=7233849eb27141be3b6c17853a260c7ec9508aadfdc88e73bc325e117565ddc0 \
  386=21eca52030cc8c6522781460ec16cb79c4b303891ff06ab1c9389b212a529f9b \
  arm64=7e7f502970ed392759ebd1d9c96d55159a0eb6e510535d06778e6bbee97baca6 \
  arm_v7=7da3a5b816e6015c24c0858cc6263bc6f29329c44a8e0a604c63986cf0d3d349 \
  arm_v6=c2577e5dac322c99a88a7573f3983c54381ef6680bc06d8850680fd7fecd5653 \
  arm_v5=a8f1024d336b4538585a2f100b98fdf7b56001e0d15026173a48f396fc1f307a \
  mips_softfloat=d75a1121667beaef4b25eccbd8125b90914140f4205ba3b54c37b20531c8c6e5 \
  mipsle_softfloat=92ffd4350497dae108c5c618b65ab5a54758fe61b2097b0f3ba566212d2cef9b \
  mips64=921dc6fb9b277d88c79dd8e8bfd0edf256ee4136c9edfa89bcbce56b87f3b4c2 \
  mips64le=14f1ad6b1f4aed4c3d79513bac8c5019389dba747227304c18854d97519ac3db \
  loong64=210dcd726379f2a46316a593fbb4a7e51cda0ddf9abca0c962e4cc0b11a914fd \
  riscv64=30b3798efa4bc5e46a59f128b78f786624a3bcfcea71db2d5ef8c72cd44ad572
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
