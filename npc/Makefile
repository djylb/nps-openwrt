# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.45
PKG_RELEASE:=1

NPC_ARCH:=
ifneq ($(filter x86_64,$(ARCH)),)
	NPC_ARCH:=amd64
else ifneq ($(filter i386,$(ARCH)),)
	NPC_ARCH:=386
else ifneq ($(filter aarch64%,$(ARCH)),)
	NPC_ARCH:=arm64
else ifneq ($(findstring armv8,$(BOARD)),)
	NPC_ARCH:=arm64
else ifneq ($(filter arm%,$(ARCH)),)
	ifeq ($(BOARD),bcm53xx)
		NPC_ARCH:=arm_v6
	else ifeq ($(BOARD),kirkwood)
		NPC_ARCH:=arm_v5
	else
		NPC_ARCH:=arm_v7
	endif
else ifneq ($(filter mipsel%,$(ARCH)),)
	NPC_ARCH:=mipsle
else ifneq ($(filter mips64el%,$(ARCH)),)
	NPC_ARCH:=mips64le
else ifneq ($(filter mips64%,$(ARCH)),)
	NPC_ARCH:=mips64
else ifneq ($(filter mips%,$(ARCH)),)
	NPC_ARCH:=mips
else ifneq ($(filter loongarch64%,$(ARCH)),)
	NPC_ARCH:=loong64
else ifneq ($(filter riscv64%,$(ARCH)),)
	NPC_ARCH:=riscv64
else
	$(error Unsupported ARCH: $(ARCH) or BOARD: $(BOARD))
endif

PKG_SOURCE:=linux_$(NPC_ARCH)_client.tar.gz
PKG_SOURCE_URL:=https://github.com/djylb/nps/releases/download/v$(PKG_VERSION)/

# === NPC_HASH_TABLE_START ===
NPC_HASHES := \
  amd64=d817ac7a23f8a849f543501398ec38f8e9632a726157856487ba74d41b7d6599 \
  386=a3d1904cd91d4ee127a08bddc4ee80db83003eff1cbfb985dc521d520cc3585a \
  arm64=90f956fc0022ed41bc9252e8d006729f282a9a5d52a96e82649f2d1672746cb3 \
  arm_v7=f5256d68c6a12a0d81cbbaede4ac9d5803cf936a798115d1cd0db5f4a8bf4ff4 \
  arm_v6=5786e01e5b6030a1259949b7ba68fad54007b0306b63c58730cc9d5be2eceda8 \
  arm_v5=8493899805ce623234f498a0b06ebdcffe8ff4e0fd08a7a9af736f7553e09bed \
  mips=461e78336503debc6e1c40e1d15cc5bc941e9a23d928ac648d8d26284eb41aeb \
  mipsle=9128dc43750836eae9acda36b9f2d0ae6a0fb90b3671743975325a1913b85eeb \
  mips64=c662f86f653a85c3fc74ecb43a27f9c17adbd5a209fbdd6fef3652dfb74aeca3 \
  mips64le=8ae5b9ef75520ebf86754f8b617974be41653df84df870111d664a51ea05f45c \
  loong64=afa70a9d4f6023c98e3747f5045d593c16c52e8e0ce2e4f959bbcc79253e50da \
  riscv64=a12c89b3b928fe49b32f01ef3fea26929ab7560f582b9f5b86f5071778ea371d \
# === NPC_HASH_TABLE_END ===

PKG_HASH:=$(word 2,$(filter $(NPC_ARCH)=%,$(NPC_HASHES)))

PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=Duan <duan@d-jy.net>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=NPC Client (precompiled for $(NPC_ARCH))
	URL:=https://github.com/djylb/nps
endef

define Package/$(PKG_NAME)/description
NPC is a fast reverse proxy client to expose local servers through NAT/firewall.
This package uses the precompiled binary for the $(NPC_ARCH) architecture.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	tar -xzf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin/$(PKG_NAME)
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
