#!/bin/sh
LC_ALL='C'

# Create temporary folder
echo '新建TMP文件夹...'
mkdir -p ./rules/tmp/
cd ./rules/tmp
echo '新建TMP文件夹完成'

# Start Download Filter File
echo '开始下载规则...'
# uBlock Origin规则
ublock=(
  # uBlock filters
  "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
  # uBlock filters – Badware risks
  "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt"
  # uBlock filters – Privacy
  "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"
  # uBlock filters – Quick fixes
  "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt"
  # uBlock filters – Resource abuse
  "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt"
  # uBlock filters – Unbreak
  "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt"
  # uBlock filters – Annoyances
  "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt"
)

# Adguard For Android 规则
adguard=(
  # 基础过滤器
  "https://filters.adtidy.org/android/filters/2_optimized.txt"
  # 移动设备过滤器
  "https://filters.adtidy.org/android/filters/11_optimized.txt"
  # 防跟踪保护过滤器
  "https://filters.adtidy.org/android/filters/3_optimized.txt"
  # URL跟踪过滤器
  "https://filters.adtidy.org/android/filters/17_optimized.txt"
  # 社交媒体过滤器
  "https://filters.adtidy.org/android/filters/4_optimized.txt"
  # 恼人广告过滤器
  "https://filters.adtidy.org/android/filters/14_optimized.txt"
  # 中文过滤器
  "https://filters.adtidy.org/android/filters/224_optimized.txt"
  # DNS过滤器
  "https://filters.adtidy.org/android/filters/15_optimized.txt"
)

# Adguard For uBlock Origin 规则
ag_ubo=(
  # 基础过滤器
  "https://filters.adtidy.org/extension/ublock/filters/2.txt"
  # 移动设备过滤器
  # "https://filters.adtidy.org/extension/ublock/filters/11.txt"
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

# 元素过滤规则
common=(
  # 乘风通用过滤规则，适用于UBO或ADG
  "https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt"
  # 乘风视频过滤规则，适用于UBO或ADG
  "https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt"
)

# 元素过滤规则 (AdGuard)
adblock_ag=(
  # Anti-AD for Adguard
  "https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-adguard.txt"
  # adgk规则 @坂本大佬
  "https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt"
  # 百度超级净化 @坂本大佬
  "https://raw.githubusercontent.com/banbendalao/ADgk/master/kill-baidu-ad.txt"
  # 主要去除手机盗版网站广告 @酷安：大萌主
  "https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt"
  # 去 APP 下载广告规则
  "https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt"
  # Cats-Team 自定义过滤规则
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/dns-rule-allow.txt"
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/dns-rules.txt"
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/thrid-part-rules.txt"
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/adblock-rules.txt"
  # ADFILT
  # "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
)

# 元素过滤规则 (PC)
adblock_full=(
  # EasyList (反广告主规则列表。主要面向英文网站，包含大量通用规则)
  "https://easylist.to/easylist/easylist.txt"
  # Easylist China (反广告主规则列表的补充。主要面向中文网站)
  "https://easylist-downloads.adblockplus.org/easylistchina.txt"
  # EasyPrivacy (防隐私跟踪挖矿规则列表)
  "https://easylist.to/easylist/easyprivacy.txt"
  # CJX's Annoyance List (反自我推广,移除anti adblock,防跟踪规则列表)
  "https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-annoyance.txt"
  # Adblock Warning Removal List
  "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt"
  # Anti-Adblock Killer
  "https://raw.githubusercontent.com/reek/anti-adblock-killer/master/anti-adblock-killer-filters.txt"
  # Hacamer's URL Filter
  "https://raw.githubusercontent.com/hacamer/AdRule/main/url-filter.txt"
  # I don't care about cookies
  "https://www.i-dont-care-about-cookies.eu/abp/"
  # Online Malicious URL Blocklist URL-based
  "https://curben.gitlab.io/malware-filter/urlhaus-filter-online.txt"
)

# 元素过滤规则 (Mobile)
adblock_lite=(
  # halflife规则，[推荐移动端]合并自乘风视频广告过滤规则、EasylistChina、EasylistLite、CJX'sAnnoyance，以及补充的一些规则
  "https://raw.githubusercontents.com/o0HalfLife0o/list/master/ad.txt"
  # Adblock Warning Removal List
  "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt"
  # Hacamer's URL Filter
  "https://raw.githubusercontent.com/hacamer/AdRule/main/url-filter.txt"
  # 百度超级净化 @坂本大佬
  "https://raw.githubusercontent.com/banbendalao/ADgk/master/kill-baidu-ad.txt"
  # 主要去除手机盗版网站广告 @酷安：大萌主
  "https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt"
  # 去 APP 下载广告规则
  "https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt"
)

# DNS过滤规则
dns=(
  # AdGuard DNS filter
  "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt"
  # Anti-AD for AdGuardHome（DNS过滤）
  "https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt"
  # Online Malicious URL Blocklist Domain-based (AdGuard Home)
  "https://curben.gitlab.io/malware-filter/urlhaus-filter-agh-online.txt"
  # Cats-Team 自定义过滤规则
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/dns-rule-allow.txt"
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/dns-rules.txt"
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/thrid-part-rules.txt"
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/adblock-rules.txt"
  # LWJ's black list
  "https://raw.githubusercontent.com/liwenjie119/adg-rules/master/black.txt"
)

# HOSTS过滤
hosts=(
  # 大圣净化规则
  "https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts"
  # neoHosts - Basic Hosts 基础、克制的数据，推荐所有用户使用。
  "https://cdn.jsdelivr.net/gh/neoFelhz/neohosts@gh-pages/basic/hosts.txt"
  # AdAway
  "https://adaway.org/hosts.txt"
  # NEO DEV HOST - Lite version (Without Dead Domain inside)
  "https://raw.githubusercontent.com/neodevpro/neodevhost/master/lite_host"
  # NoCoin adblock list
  "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt"
  # yhosts 智能设备专用(更全,用电脑看视频网站可能出错)
  "https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts"
  # GoodbyeAds
  # "https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Hosts/GoodbyeAds.txt"
  # GoodbyeAds YouTube Adblock
  # "https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Extension/GoodbyeAds-YouTube-AdBlock.txt"
  # GoodbyeAds Spotify AdBlock
  # "https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Extension/GoodbyeAds-Spotify-AdBlock.txt"
)

# 白名单规则
allow=(
  # Cats-Team 自定义白名单规则
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/allowlist.txt"
  # LWJ's white list
  "https://raw.githubusercontent.com/liwenjie119/adg-rules/master/white.txt"
  # AdGuard Chinese Filters whitelist
  "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/ChineseFilter/sections/whitelist.txt"
)


for i in "${!ublock[@]}" "${!adguard[@]}" "${!ag_ubo[@]}" "${!adguard_full[@]}" "${!common[@]}" "${!adblock_ag[@]}" "${!adblock_full[@]}" "${!adblock_lite[@]}" "${!dns[@]}" "${!hosts[@]}" "${!allow[@]}"
do
  curl --parallel --parallel-immediate -k -L -C - -o "ublock${i}.txt" --connect-timeout 60 -s "${ublock[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "adguard${i}.txt" --connect-timeout 60 -s "${adguard[$i]}" &
  # curl --parallel --parallel-immediate -k -L -C - -o "ag_ubo${i}.txt" --connect-timeout 60 -s "${ag_ubo[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "common${i}.txt" --connect-timeout 60 -s "${common[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "adblock_ag${i}.txt" --connect-timeout 60 -s "${adblock_ag[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "adblock_full${i}.txt" --connect-timeout 60 -s "${adblock_full[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "adblock_lite${i}.txt" --connect-timeout 60 -s "${adblock_lite[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "dns${i}.txt" --connect-timeout 60 -s "${dns[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "hosts${i}.txt" --connect-timeout 60 -s "${hosts[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "allow${i}.txt" --connect-timeout 60 -s "${allow[$i]}" &
done

# 其他规则
# curl --connect-timeout 60 -s -o - https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanProgramAD.list \
#  | grep -F 'DOMAIN-SUFFIX,' | sed 's/DOMAIN-SUFFIX,/127.0.0.1 /g' > hosts999.txt
# curl --connect-timeout 60 -s -o - https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanAD.list \
#  | grep -F 'DOMAIN-SUFFIX,' | sed 's/DOMAIN-SUFFIX,/127.0.0.1 /g' > hosts998.txt

# GOODBYEADS Rules For Android
curl --connect-timeout 60 -s -o - https://raw.githubusercontent.com/8680/GOODBYEADS/master/data/rules/Android.txt | grep -E -v "^(\#).*" > element0.txt
# GOODBYEADS Rules For PC
curl --connect-timeout 60 -s -o - https://raw.githubusercontent.com/8680/GOODBYEADS/master/data/rules/PC.txt | grep -E -v "^(\#).*" > element1.txt
echo '规则下载完成'


# Start Merge and Duplicate Removal
echo 开始合并
# 预处理自定义规则
cat ../mod/static.txt element*.txt \
 | grep -E -v '^((\!)|(\！)|(\[)).*' \
 | sort -u > ../mod/element.txt
cat ../mod/element.txt perdns*.txt \
 | grep -E '^((\|\|)|(\@\@))' \
 | sed 's/\^\^/\^/g' \
 | sort -u > ../mod/dns.txt

# 合并白名单规则
cat allow*.txt \
 | grep '^(\@\@).*' \
 | sed 's/\^\^/\^/g' \
 | sort -u > tmp-allow.txt

# 合并通用过滤规则
cat ../mod/element.txt ../mod/dns.txt tmp-allow.txt common*.txt \
 | grep -E -v '^((\!)|(\！)|(\[)).*' \
 | sed 's/\^\^/\^/g' \
 | sort -u > tmp-adblock.txt

# 合并AdKiller过滤规则
cat tmp-adblock.txt ublock*.txt adblock_full*.txt \
 | grep -E -v '^((\!)|(\！)|(\[)).*' \
 | sed 's/\^\^/\^/g' \
 | sort -u > pre-filter.txt

# 合并AdKiller-Lite过滤规则
cat tmp-adblock.txt adblock_lite*.txt \
 | grep -E -v '^((\!)|(\！)|(\[)).*' \
 | sed 's/\^\^/\^/g' \
 | sort -u > pre-filter-lite.txt
 
# 合并HOSTS过滤规则并转化为DNS过滤规则
cat hosts*.txt \
 | sed s/127.0.0.1/0.0.0.0/ \
 | sed s/::/0.0.0.0/g \
 | sed 's/  / /' \
 | grep -E '^(0.0.0.0 ).*' \
 | sort -u > pre-hosts.txt
cat pre-hosts.txt \
 | sed 's/0.0.0.0 /||/g' \
 | sed 's/$/&^/g' \
 | sort -u > tmp-dns.txt

# 合并AdGuard过滤规则
cat tmp-adblock.txt adguard*.txt adblock_ag*.txt \
 | grep -E -v '^((\!)|(\！)|(\[)).*' \
 | sed 's/\^\^/\^/g' \
 | sort -u > pre-adguard.txt

# 分别提取AdGuard DNS规则和元素过滤规则
cat pre-adguard.txt tmp-dns.txt \
 | grep -E '^((\|\|)|(\@\@))' \
 | sed 's/\^\^/\^/g' \
 | sort -u > pre-adguard-dns.txt
cat pre-adguard.txt \
 | grep -E -v '^((\|\|)|(\@\@))' \
 | sort -u > pre-adguard-element.txt

# 合并DNS (AdGuard Home)过滤规则
cat ../mod/dns.txt tmp-allow.txt dns*.txt \
 | grep -E -v '^((\!)|(\！)|(\[)).*' \
 | sed 's/\^\^/\^/g' \
 | sort -u > pre-dns.txt


# Move to Pre Filter
echo '移动规则到Pre目录'
cd ../
mkdir -p ./pre
mkdir -p ./tpdate
mv ./tmp/pre-*.txt ./pre
rm -rf ./tmp
cd ./pre
echo '移动完成'

python ../../utils/deduplication.py

echo '规则合并去重处理完成'


# Start Add title and date
diffFile="$(ls | sort -u)"
for i in $diffFile;
do
  n=`cat $i | wc -l`
  new=$(echo "$i" | sed 's/pre-//g')
  echo "! Version: $(TZ=UTC-8 date +'%Y-%m-%d %H:%M:%S')（北京时间）" > ../tpdate/$i-tpdate.txt
  echo "! Total count: $n" >> ../tpdate/$i-tpdate.txt
  cat ../../utils/title/$new ../tpdate/$i-tpdate.txt ./$i \
  | sed '/^$/d' > ../../$new
done
cd ../
rm -rf ./pre ./tpdate
echo '规则处理完成'
exit