# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.12
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
  amd64=305d46fcb25e2e783d013240942da908a3be29f16491c96c3c1f513dd6753c59 \
  386=4f428f2c5031a53567b14f31d9c70ac12c611575aae68c87d14b1c8ae6aa8595 \
  arm64=e25216c729d6995e16dc084b967c2f6a966bea488dd73885eca78cc3e9eaf052 \
  arm_v7=5045cbc624e5077b60dc8dedfb70c9598730652be411770138e67f78a1078a92 \
  arm_v6=b5f0a0a6654953fe0d7bc8b4d07fe8eecd8385a0369d956d380990c668a78182 \
  arm_v5=ada258c3bf005c65f8077d29869c2d0343df4aabb7ee4f07bffe8a367491db48 \
  mips=1e786eca2c9976fca450226651b2a9f5549872a7f7155b16cc10877e28b9106d \
  mipsle=15fc19db823bfca9dbb12e4db5ef3fac43d5d860181a9f33cc00a157b2a9fcb5 \
  mips64=1b574879bb52de6a67501dfaa8734e03a186911fba071442386fb147259dca80 \
  mips64le=b107b3485f706a6b9ed6752502d98e2c385ddd20f028b72bb45236ee791f32c2 \
  loong64=5f541102bd4571a004c3aa5c8046026e48983cc8edc1ab36d209216706a06122 \
  riscv64=f04307958ada8dcfac50ff65866c5b186f8a9fd2016ee8eb885d8a1f4410049d
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
