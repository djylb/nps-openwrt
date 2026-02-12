# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.34.4
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
  amd64=2a3d7a7fb9046e2c8d2f4141541524a525aea8dc3cc029868af432c0fe3bd110 \
  386=4a788b9eaf48c1d6953aec481a07dee970bc92fe2722a1ef61367b97a4d3c237 \
  arm64=934194fd9439733f042990a7f8d5bc82a55abf00315d2fa800706513bf566323 \
  arm_v7=c3560cf8799c2f0da3a7d8da34515145478d1dab62004000dee620351b40ddf9 \
  arm_v6=505fc830b184bd4c05e262e425e9901320c1725a0303d287d079ad55b9b7ec9b \
  arm_v5=0215b8175751a1635ec9f659fab954e528489c130e4c22a8201d6f5bc970aa68 \
  mips_softfloat=e94320e54d64512268e68fe2b4e4d34453960389e4aed910ee04aceaf42e8144 \
  mipsle_softfloat=35cf1cc7b8399c5c81f1ad3f50c538c513aaea7950990edce69ab83d6079b0ff \
  mips64=479d087e3afee643f57e0ca10f44184ff99b81dd3084e9d601b21c2f75c966e4 \
  mips64le=9b2eaac03bcc2fbf3678330c7a3f114650e950b9cdad94f353562dbc64b38228 \
  loong64=9aa501435cacaccb9d0504fb8a0a43a9a71694da90546dc356c60dd7502c44f8 \
  riscv64=62f0b60fee5575ce45d9558e0504104dba77d0aea80feb44ffdc24aa91425b7d
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
