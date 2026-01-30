#!/usr/bin/env bash
set -euo pipefail

########################
# 基础路径
########################
ROOT="$(cd "$(dirname "$(dirname "$0")")" && pwd)"
UTIL="$ROOT/utils"
RULES="$ROOT/rules"
TMP="$RULES/tmp"

mkdir -p "$TMP"

echo "==> 使用临时目录: $TMP"

########################
# 并发控制
########################
PARALLEL=8
RETRY=3

########################
# 下载函数
########################
download_group() {
	local prefix="$1"
	shift
	for url in "$@"; do
		printf "%s|%s\n" "$prefix" "$url"
	done
}

download_all() {
	local taskfile="$1"

	cat "$taskfile" | \
	xargs -P "$PARALLEL" -n 1 -I {} bash -c '
	IFS="|" read prefix url <<< "{}"
	name=$(basename "$url")
	out="'$TMP'/${prefix}-${name}"
	echo "  -> 下载 $url"
	curl -L --retry '"$RETRY"' --retry-delay 2 \
	     --connect-timeout 30 \
	     -o "$out" "$url"
	'
}

########################
# 规则 URL 定义
########################


# uBlock Origin规则
UBLOCK=(
	# uBlock filters – Ads
	"https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
	# uBlock filters – Badware risks
	"https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt"
	# uBlock filters – Privacy
	"https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"
	"https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt"
	# uBlock filters – Quick fixes
	"https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt"
	# uBlock filters – Unbreak
	"https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt"
	# uBlock filters – Annoyances
	"https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt"
	"https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances-others.txt"
	"https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances-cookies.txt"
	# uBlock filters - Link Shorteners
	"https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/ubo-link-shorteners.txt"

	# Adguard For uBlock Origin 规则
	# 基础过滤器
	"https://filters.adtidy.org/extension/ublock/filters/2.txt"
	# 防跟踪保护过滤器
	"https://filters.adtidy.org/extension/ublock/filters/3.txt"
	# URL跟踪过滤器
	"https://filters.adtidy.org/extension/ublock/filters/17.txt"
	# 社交媒体过滤器
	"https://filters.adtidy.org/extension/ublock/filters/4.txt"
	# 恼人广告过滤器
	"https://filters.adtidy.org/extension/ublock/filters/14.txt"
	# 中文过滤器
	"https://filters.adtidy.org/extension/ublock/filters/224.txt"
)

# Adguard For Android 规则
ADGUARD=(
	# 基础过滤器
	"https://filters.adtidy.org/android/filters/2_optimized.txt"
	# 中文过滤器
	"https://filters.adtidy.org/android/filters/224_optimized.txt"
)

# 元素过滤规则
ADBLOCK_UNI=(
	# 乘风 广告过滤规则，适用于UBO或ADG
	"https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt"
	# 乘风 视频过滤规则，适用于UBO或ADG
	"https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt"
	# 秋风广告规则
	"https://raw.githubusercontent.com/TG-Twilight/AWAvenue-Ads-Rule/refs/heads/main/AWAvenue-Ads-Rule.txt"
	# GOODBYEADS Rules
	"https://github.com/8680/GOODBYEADS/raw/refs/heads/master/data/mod/adblock.txt"
	#Clean Url
	"https://raw.githubusercontent.com/DandelionSprout/adfilt/master/ClearURLs%20for%20uBo/clear_urls_uboified.txt"
	"https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
)

# 元素过滤规则 (AdGuard)
ADBLOCK_AG=(
	# Anti-AD for Adguard
	"https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-adguard.txt"
	# adgk规则 @坂本大佬
	"https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt"
	# 主要去除手机盗版网站广告 @酷安：大萌主
	"https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt"
	# 去 APP 下载广告规则
	"https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt"
	# 百度超级净化 @坂本大佬
	"https://raw.githubusercontent.com/banbendalao/ADgk/master/kill-baidu-ad.txt"
	# Cats-Team AdBlock Rules
	"https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/adblock-rules.txt"
)

# 元素过滤规则 (PC)
ADBLOCK_FULL=(
	# halflife规则，[推荐桌面端]合并自乘风视频广告过滤规则、Easylist、EasylistChina、EasyPrivacy、CJX'sAnnoyance，以及补充的一些规则
	"https://raw.githubusercontent.com/sbwml/halflife-list/refs/heads/master/ad-pc.txt"
	# halflife规则，合并自Adblock Warning Removal List、ABP filters、anti-adblock-killer-filters
	"https://raw.githubusercontent.com/sbwml/halflife-list/refs/heads/master/ad-edentw.txt"
	# I don't care about cookies
	"https://www.i-dont-care-about-cookies.eu/abp/"
)

# 元素过滤规则 (Mobile)
ADBLOCK_LITE=(
	# halflife规则，[推荐移动端]合并自乘风视频广告过滤规则、EasylistChina、EasylistLite、CJX'sAnnoyance，以及补充的一些规则
	"https://raw.githubusercontent.com/sbwml/halflife-list/refs/heads/master/ad.txt"
	# halflife规则，合并自Adblock Warning Removal List、ABP filters、anti-adblock-killer-filters
	"https://raw.githubusercontent.com/sbwml/halflife-list/refs/heads/master/ad-edentw.txt"
	# 百度超级净化 @坂本大佬
	"https://raw.githubusercontent.com/banbendalao/ADgk/master/kill-baidu-ad.txt"
	# 主要去除手机盗版网站广告 @酷安：大萌主
	"https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt"
	# 去 APP 下载广告规则
	"https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt"
	# uBlock filters – Ads For Mobile
	"https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-mobile.txt"
	# Cats-Team AdBlock Rules
	"https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/adblock-rules.txt"
)

# HOSTS过滤
HOSTS=(
	# 大圣净化规则
	"https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts"
	# NoCoin adblock list
	"https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt"
	# yhosts 智能设备专用(更全,用电脑看视频网站可能出错)
	"https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts"
	#hostsVN
	"https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
)

# DNS通用过滤规则
DNS_UNI=(
	# AdGuard DNS filter
	"https://filters.adtidy.org/android/filters/15_optimized.txt"
	# Cats-Team 自定义过滤规则
	"https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/dns-rules.txt"
	#HostsVN
	"https://raw.githubusercontent.com/bigdargon/hostsVN/master/filters/adservers-all.txt"
)

# DNS (AdGuard Home)过滤规则
DNS_AGH=(
	# Anti-AD for AdGuardHome（DNS过滤）
	"https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt"
	# Online Malicious URL Blocklist Domain-based (AdGuard Home)
	"https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-agh-online.txt"
	# LWJ's black list
	"https://raw.githubusercontent.com/liwenjie119/adg-rules/master/black.txt"
	# LWJ's white list
	"https://raw.githubusercontent.com/liwenjie119/adg-rules/master/white.txt"
	#Smart-TV
	"https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV-AGH.txt"
)

# 白名单规则
ALLOW=(
	# AdGuard Chinese Filters whitelist
	"https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/ChineseFilter/sections/allowlist.txt"
	# GOODBYEADS Rules
	"https://raw.githubusercontent.com/8680/GOODBYEADS/refs/heads/master/data/rules/allow.txt"
)

# 生成下载任务
TASKS="$TMP/tasks.txt"
: >"$TASKS"

download_group ublock "${UBLOCK[@]}" >>"$TASKS"
download_group adguard "${ADGUARD[@]}" >>"$TASKS"
download_group adblock_uni "${ADBLOCK_UNI[@]}" >>"$TASKS"
download_group adblock_full "${ADBLOCK_FULL[@]}" >>"$TASKS"
download_group adblock_lite "${ADBLOCK_LITE[@]}" >>"$TASKS"
download_group hosts "${HOSTS[@]}" >>"$TASKS"
download_group dns_uni "${DNS_UNI[@]}" >>"$TASKS"
download_group dns_agh "${DNS_AGH[@]}" >>"$TASKS"
download_group allow "${ALLOW[@]}" >>"$TASKS"

echo "==> 开始下载规则"
download_all "$TASKS"
echo "==> 下载完成"

# 开始规则合并
awk -f $UTIL/rules-compiler.awk \
$ROOT/rules/mod/static.txt \
$TMP/hosts*.txt \
$TMP/ublock*.txt \
$TMP/adblock_*.txt \
$TMP/adguard*.txt

add_title(){
	VERSION_LINE="! Version: $(TZ=UTC-8 date +'%Y-%m-%d %H:%M:%S')（北京时间）"

	FILES=(
		filter.txt
		filter-lite.txt
		adguard.txt
		adguard-element.txt
		adguard-dns.txt
		dns.txt
		hosts
	)

	for name in "${FILES[@]}"; do
		# 防止空匹配
		# 当前目录中的规则文件
		src="./$name"
		[ -f "$src" ] || continue

		title_file="$RULES/title/$name"
		out_file="$TMP/$name.tmp"

		{
			# 写入标题文件（如果存在）
			if [[ -f "$title_file" ]]; then
				cat "$title_file"
			fi

			# 写入Version 行
			echo "$VERSION_LINE"

			# 写入规则
			cat "$src"
		} >"$out_file"

		# 删除原规则文件
		rm -f "$src"
		# 覆盖最终文件
		mv "$out_file" "$ROOT/$name"
	done

	rm -rf "$TMP"
	echo "✔ 规则合并完成"
}

add_title
