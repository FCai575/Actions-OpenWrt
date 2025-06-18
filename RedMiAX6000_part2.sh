#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
# sed -i 's/192.168.1.1/192.168.88.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/10.0.10.1/g" package/base-files/files/bin/config_generate

# 固件版本号添加个人标识和日期
sed -i "s/DISTRIB_DESCRIPTION='%D %V %C'/DISTRIB_DESCRIPTION='FCai($(TZ=UTC-8 date +%Y.%m.%d)) '/g" package/base-files/files/etc/openwrt_release

# 修正连接数
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=100000' package/base-files/files/etc/sysctl.conf

echo 'refresh feeds'
./scripts/feeds update -a
./scripts/feeds install -a
