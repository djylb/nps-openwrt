# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.0
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
  amd64=e746ce4af7a599f143847666d9f3a14ceb5fedafe912aa8e5f4a5ac99b45f78c \
  386=e1125c7170fef1fb47c20bcc9b5bce4168402508f64cb61675e7ecce53ff141b \
  arm64=8533ad02a3cfbb77a32a02be9b63a21e586765fd4b3882d27cf1663f2ed24002 \
  arm_v7=dd2ef0871b521dc7c85eaeb74e6aed1ac66afed7259849007ce672f1da39ae6c \
  arm_v6=b30618657522bd3f2c1b8e8b555edd943ecb59e1506f4822f79db673eeb5045e \
  arm_v5=c17747f63c1ab64e94f9d4c34e38dd39f692fb47169dbb4ac375e55bf42a879d \
  mips_softfloat=12af79159536d166e360bc77f195cc2168a59f3dc01e55104dc64291d39307a7 \
  mipsle_softfloat=459da60ba9829da27c6b392e599d26d687ab9ffd9d568ee9a6007b8534128c35 \
  mips64=7d00d3f9976a55eb4bd3014cf5a99082c2ed69e8cf63b175a29c7d79f9cc124d \
  mips64le=01a6ea75ffee108619d84883289b5681f0791391a00ff577e6e14f70451d2ac3 \
  loong64=7f6c6dbbbed7825162045737d3e2ff879cc3012b843250b00b8bef88b55dcc08 \
  riscv64=1c2610d8c907bd775721378f86c9d08c9f98c748c3a0ddead8e191d824909257
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
