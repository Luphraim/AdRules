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
    curl -sL --retry '"$RETRY"' --retry-delay 2 \
         --connect-timeout 30 \
         -o "$out" "$url" || echo "  [!] 下载失败: $url"
    '
}

# UBLOCK 专属规则 (包含原生 uAssets 和 高级语法规则如 ClearURLs)
UBLOCK=(
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances-others.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances-cookies.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/ubo-link-shorteners.txt"
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/ClearURLs%20for%20uBo/clear_urls_uboified.txt"
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
)

# ADGUARD 专属规则 (官方提供)
ADGUARD=(
    "https://filters.adtidy.org/extension/ublock/filters/2.txt"
    "https://filters.adtidy.org/extension/ublock/filters/3.txt"
    "https://filters.adtidy.org/extension/ublock/filters/17.txt"
    "https://filters.adtidy.org/extension/ublock/filters/4.txt"
    "https://filters.adtidy.org/extension/ublock/filters/14.txt"
    "https://filters.adtidy.org/extension/ublock/filters/224.txt"
    "https://filters.adtidy.org/android/filters/2_optimized.txt"
    "https://filters.adtidy.org/android/filters/224_optimized.txt"
)

# 通用 ABP 桌面端规则 (分配给 uBO 和 AdGuard)
ABP_PC=(
    "https://raw.githubusercontent.com/sbwml/halflife-list/refs/heads/master/ad-pc.txt"
    "https://raw.githubusercontent.com/sbwml/halflife-list/refs/heads/master/ad-edentw.txt"
    "https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt"
    "https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt"
)

# 通用 ABP 移动端规则 (分配给 uBO, AdGuard, Via/Lite)
ABP_MOBILE=(
    "https://raw.githubusercontent.com/sbwml/halflife-list/refs/heads/master/ad.txt"
    "https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt"
    "https://raw.githubusercontent.com/banbendalao/ADgk/master/kill-baidu-ad.txt"
    "https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt"
    "https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt"
    "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/adblock-rules.txt"
    "https://raw.githubusercontent.com/TG-Twilight/AWAvenue-Ads-Rule/refs/heads/main/AWAvenue-Ads-Rule.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-mobile.txt"
)

# DNS / HOSTS 层级规则 (提取域名，分发给所有环境)
DNS=(
    "https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt"
    "https://filters.adtidy.org/android/filters/15_optimized.txt"
    "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/dns-rules.txt"
    "https://raw.githubusercontent.com/bigdargon/hostsVN/master/filters/adservers-all.txt"
    "https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-agh-online.txt"
    "https://raw.githubusercontent.com/liwenjie119/adg-rules/master/black.txt"
    "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV-AGH.txt"
)

HOSTS=(
    "https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts"
    "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt"
    "https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts"
    "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
)

# 白名单规则
ALLOW=(
    "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/ChineseFilter/sections/allowlist.txt"
    "https://raw.githubusercontent.com/liwenjie119/adg-rules/master/white.txt"
    "https://raw.githubusercontent.com/8680/GOODBYEADS/refs/heads/master/data/rules/allow.txt"
)

# 生成下载任务
TASKS="$TMP/tasks.txt"
: >"$TASKS"

download_group ublock "${UBLOCK[@]}" >>"$TASKS"
download_group adguard "${ADGUARD[@]}" >>"$TASKS"
download_group abp_pc "${ABP_PC[@]}" >>"$TASKS"
download_group abp_mobile "${ABP_MOBILE[@]}" >>"$TASKS"
download_group dns "${DNS[@]}" >>"$TASKS"
download_group hosts "${HOSTS[@]}" >>"$TASKS"
download_group allow "${ALLOW[@]}" >>"$TASKS"

echo "==> 开始下载规则"
download_all "$TASKS"
echo "==> 下载完成"

touch "$ROOT/rules/mod/static.txt"

echo "==> 开始合并和编译规则"
awk -v OUT_DIR="$TMP" -f "$UTIL/rules-compiler.awk" \
    "$ROOT/rules/mod/static.txt" \
    "$TMP"/hosts*.txt \
    "$TMP"/ublock*.txt \
    "$TMP"/adguard*.txt \
    "$TMP"/abp_*.txt \
    "$TMP"/dns*.txt \
    "$TMP"/allow*.txt

add_title(){
    VERSION_LINE="! Version: $(TZ='Asia/Shanghai' date +'%Y-%m-%d %H:%M:%S') (GMT+8)"
    FILES=("filter.txt" "filter-lite.txt" "adguard.txt" "adguard-element.txt" "adguard-dns.txt" "dns.txt" "hosts")

    for name in "${FILES[@]}"; do
        src="$TMP/$name"
        [ -f "$src" ] || continue
        title_file="$RULES/title/$name"
        final_file="$ROOT/$name"

        {
            if [[ -f "$title_file" ]]; then
                cat "$title_file"
                echo ""
            fi
            echo "$VERSION_LINE"
            cat "$src"
        } > "$final_file"
    done

    rm -rf "$TMP"
    echo "✔ 规则合并与格式化完成"
}

add_title