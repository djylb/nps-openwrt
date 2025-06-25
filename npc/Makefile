# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.27
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
  amd64=5627c7eb2504388a29ec8dde07e5ea7ec35a6b3136e1f0fe1fa1bb45cb598b0f \
  386=3d2d89d33c30d8589e3499f222964089ad562872874937b6ce8c500bfafeff75 \
  arm64=8dab907d8203d0f22798f5fc38cdb8c94791a392a3fff78c998645ba799b1ee0 \
  arm_v7=37d9b97c95f3789ccb1211883b4b2a236cc35b0b115eb913387b0d4654741286 \
  arm_v6=6f065e592df1092d83b031ad74156d0a524c3ea8519c9c780c9dc7d130ef992f \
  arm_v5=eb93834821ba1b8d6c78709edac5a6a6234f521d4f5b40574adb4653496a45e6 \
  mips_softfloat=d658ef49d217e862843e55439208a6fda067acee7998bcbd05e8cf563da5269d \
  mipsle_softfloat=3bed8cd84fe6c66125e47cc272c564893ecc97b8297af7d3c82dae1fed0e8dab \
  mips64=2422ee18bc6664d22291071b16f695a3ba4165d9957f3d396ac91b127e2ef246 \
  mips64le=29b720ec1be2ec0fe0997d267723d8740938ab9f2af26184783ed8672433bdc0 \
  loong64=5720323c6ba68972faa083694652a78b57aa3ac7c08e85165f151c8793b81ed2 \
  riscv64=b9053b0384caa1cbb842f42f3f1123d2927975e3cd55caf8a1a61ae3a9dfb0f9
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
