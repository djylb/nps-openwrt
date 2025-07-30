# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.30.2
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
  amd64=f4a2a64d82bbe500d0d5c38abf913069032f4d924fed2ecacedb2c9eb083b2df \
  386=ed34d51e7277273cb216e20b11427015b98867133b68da7434b88e2e17750236 \
  arm64=8339c1dc34e5df755ab0ac6aa42ed8f48f0b44e857119072a31b2a63318bcd77 \
  arm_v7=8099cb3311cff34fe813396706973c016e8244ec4c4b69c5aba73bf91eccc339 \
  arm_v6=4c62f2287c7f7a4de0be874e795876f06f1e2597d427e7401c37a54e1b1e41ac \
  arm_v5=e1287d419549e9ad41f855d5d2d93041d9b0fddea866eb10f2bcc0c31f04889c \
  mips_softfloat=d70e2e0c9fab9e46be2bdbfc224b3cbc5e63e2aad9cd41e142199644491d0ef3 \
  mipsle_softfloat=e46df6e34b017ac09a3112d51e01b504c1f120afcd503dd0f8b4a5a33696223a \
  mips64=6206c8eafb8636a0184e08cde31cc010c2f4f5da30701d02e3dfc4f986ab855f \
  mips64le=2405e2b4645daffc1964f220e6cf23200657421225126d4c4d109b22f628ed84 \
  loong64=62739796c061e703d91c54a0d569a026afa87fba96697a449d0b5a2ec616df2d \
  riscv64=724719491ef0b12c50472c8d8f180fcfe413f15b81235ddba2e60907f2bed978
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
