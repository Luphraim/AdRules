#!/bin/sh

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
  # "https://filters.adtidy.org/android/filters/15_optimized.txt"
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
adblock_uni=(
  # 乘风 广告过滤规则，适用于UBO或ADG
  # "https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt"
  # 乘风 视频过滤规则，适用于UBO或ADG
  "https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt"
  # GOODBYEADS Rules
  "https://raw.githubusercontent.com/8680/GOODBYEADS/master/data/rules/adblock.txt"
  # 百度超级净化 @坂本大佬
  "https://raw.githubusercontent.com/banbendalao/ADgk/master/kill-baidu-ad.txt"
)

# 元素过滤规则 (AdGuard)
adblock_ag=(
  # Anti-AD for Adguard
  "https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-adguard.txt"
  # adgk规则 @坂本大佬
  "https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt"
  # 主要去除手机盗版网站广告 @酷安：大萌主
  "https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt"
  # 去 APP 下载广告规则
  "https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt"
  # ADFILT
  # "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
)

# 元素过滤规则 (PC)
adblock_full=(
  # EasyList (反广告主规则列表。主要面向英文网站，包含大量通用规则)
  # "https://easylist.to/easylist/easylist.txt"
  # Easylist China (反广告主规则列表的补充。主要面向中文网站)
  # "https://easylist-downloads.adblockplus.org/easylistchina.txt"
  # EasyPrivacy (防隐私跟踪挖矿规则列表)
  # "https://easylist.to/easylist/easyprivacy.txt"
  # CJX's Annoyance List (反自我推广,移除anti adblock,防跟踪规则列表)
  # "https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-annoyance.txt"
  # halflife规则，[推荐桌面端]合并自乘风视频广告过滤规则、Easylist、EasylistChina、EasyPrivacy、CJX'sAnnoyance，以及补充的一些规则
  "https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-pc.txt"
  # Adblock Warning Removal List
  # "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt"
  # Anti-Adblock Killer
  # "https://raw.githubusercontent.com/reek/anti-adblock-killer/master/anti-adblock-killer-filters.txt"
  # halflife规则，合并自Adblock Warning Removal List、ABP filters、anti-adblock-killer-filters
  "https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-edentw.txt"
  # Hacamer's URL Filter
  # "https://raw.githubusercontent.com/hacamer/AdRule/main/url-filter.txt"
  # I don't care about cookies
  "https://www.i-dont-care-about-cookies.eu/abp/"
  # Online Malicious URL Blocklist URL-based
  # "https://malware-filter.gitlab.io/malware-filter/urlhaus-filter.txt"
)

# 元素过滤规则 (Mobile)
adblock_lite=(
  # halflife规则，[推荐移动端]合并自乘风视频广告过滤规则、EasylistChina、EasylistLite、CJX'sAnnoyance，以及补充的一些规则
  "https://raw.githubusercontents.com/o0HalfLife0o/list/master/ad.txt"
  # halflife规则，合并自Adblock Warning Removal List、ABP filters、anti-adblock-killer-filters
  "https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-edentw.txt"
  # Hacamer's URL Filter
  # "https://raw.githubusercontent.com/hacamer/AdRule/main/url-filter.txt"
  # 百度超级净化 @坂本大佬
  "https://raw.githubusercontent.com/banbendalao/ADgk/master/kill-baidu-ad.txt"
  # 主要去除手机盗版网站广告 @酷安：大萌主
  "https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt"
  # 去 APP 下载广告规则
  "https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt"
)

# HOSTS过滤
hosts=(
  # 大圣净化规则
  "https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts"
  # neoHosts - Basic Hosts 基础、克制的数据，推荐所有用户使用。
  "https://cdn.jsdelivr.net/gh/neoFelhz/neohosts@gh-pages/basic/hosts.txt"
  # NoCoin adblock list
  "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt"
  # yhosts 智能设备专用(更全,用电脑看视频网站可能出错)
  "https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts"
  # StevenBlack's hosts file
  "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
  # NEO DEV HOST - Lite version (Without Dead Domain inside)
  # "https://raw.githubusercontent.com/neodevpro/neodevhost/master/lite_host"
  # GoodbyeAds
  # "https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Hosts/GoodbyeAds.txt"
)

# DNS通用过滤规则
dns_uni=(
  # AdGuard DNS filter
  "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt"
  # Cats-Team 自定义过滤规则
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/dns-rule-allow.txt"
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/dns-rules.txt"
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/thrid-part-rules.txt"
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/adblock-rules.txt"
)

# DNS (AdGuard Home)过滤规则
dns_agh=(
  # Anti-AD for AdGuardHome（DNS过滤）
  "https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt"
  # Online Malicious URL Blocklist Domain-based (AdGuard Home)
  "https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-agh-online.txt"
  # LWJ's black list
  "https://raw.githubusercontent.com/liwenjie119/adg-rules/master/black.txt"
  # LWJ's white list
  "https://raw.githubusercontent.com/liwenjie119/adg-rules/master/white.txt"
)

# 白名单规则
allow=(
  # AdGuard Chinese Filters whitelist
  "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/ChineseFilter/sections/whitelist.txt"
  # Energized Protection - unblock
  # "https://raw.githubusercontent.com/EnergizedProtection/unblock/master/basic/formats/filter"
  # Cats-Team 自定义白名单规则
  "https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/allowlist.txt"
  # GOODBYEADS Rules
  "https://raw.githubusercontent.com/8680/GOODBYEADS/master/data/rules/whitelist.txt"
)


for i in "${!ublock[@]}" "${!adguard[@]}" "${!adblock_uni[@]}" "${!adblock_ag[@]}" "${!adblock_full[@]}" "${!adblock_lite[@]}" "${!hosts[@]}" "${!dns_uni[@]}" "${!dns_agh[@]}" "${!allow[@]}"
do
  curl --parallel --parallel-immediate -k -L -C - -o "ublock${i}.txt" --connect-timeout 60 -s "${ublock[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "adguard${i}.txt" --connect-timeout 60 -s "${adguard[$i]}" &  
  curl --parallel --parallel-immediate -k -L -C - -o "adblock_uni${i}.txt" --connect-timeout 60 -s "${adblock_uni[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "adblock_ag${i}.txt" --connect-timeout 60 -s "${adblock_ag[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "adblock_full${i}.txt" --connect-timeout 60 -s "${adblock_full[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "adblock_lite${i}.txt" --connect-timeout 60 -s "${adblock_lite[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "hosts${i}.txt" --connect-timeout 60 -s "${hosts[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "dns_uni${i}.txt" --connect-timeout 60 -s "${dns_uni[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "dns_agh${i}.txt" --connect-timeout 60 -s "${dns_agh[$i]}" &
  curl --parallel --parallel-immediate -k -L -C - -o "allow${i}.txt" --connect-timeout 60 -s "${allow[$i]}" &
done

# 其他规则
curl --connect-timeout 60 -s -o - https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanProgramAD.list \
 | grep -F 'DOMAIN-SUFFIX,' | sed 's/DOMAIN-SUFFIX,/127.0.0.1 /g' > hosts999.txt
curl --connect-timeout 60 -s -o - https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanAD.list \
 | grep -F 'DOMAIN-SUFFIX,' | sed 's/DOMAIN-SUFFIX,/127.0.0.1 /g' > hosts998.txt

echo '规则下载完成'


# Start Merge and Duplicate Removal
echo 开始合并
# 预处理自定义规则
sort ../mod/static.txt -u -o ../mod/static.txt
cat ../mod/static.txt \
 | egrep -v '^\!|\！|\[' \
 | egrep '^@@|\|\|.*(\^)$' \
 | egrep -v '\/|\$' \
 | sort | uniq -i > ../mod/dns.txt
comm -23 ../mod/static.txt ../mod/dns.txt \
 | sort | uniq -i > ../mod/element.txt

# 合并白名单规则
cat allow*.txt \
 | egrep '^@@\|\|?[^\^=\/:]+?\^([^\/=\*]+)?$' \
 | sort | uniq -i > tmp-allow.txt

# 合并通用过滤规则
cat ../mod/element.txt ../mod/dns.txt tmp-allow.txt adblock_uni*.txt \
 | egrep -v '^\!|\！|\[' \
 | sort | uniq -i > tmp-adblock.txt

# 合并AdKiller过滤规则
cat tmp-adblock.txt ublock*.txt adblock_full*.txt \
 | egrep -v '^\!|\！|\[' \
 | sort | uniq -i > pre-filter.txt
python ../../utils/deduplication.py pre-filter.txt

# 合并AdKiller-Lite过滤规则
cat tmp-adblock.txt adblock_lite*.txt \
 | egrep -v '^\!|\！|\[' \
 | sort | uniq -i > pre-filter-lite.txt
python ../../utils/deduplication.py pre-filter-lite.txt
 
# 合并HOSTS过滤规则并转化为DNS过滤规则
cat hosts*.txt \
 | egrep -v '^((#.*)|(\s*))$' \
 | egrep -v '^[0-9\.:]+\s+(ip6\-)?(localhost|loopback)$' \
 | egrep -v '0.0.0.0 0.0.0.0' \
 | egrep -v '#' \
 | sed 's/127.0.0.1/0.0.0.0/' \
 | sed 's/::/0.0.0.0/g' \
 | sed 's/  / /' \
 | egrep '^(0.0.0.0 )' \
 | sort | uniq -i > pre-hosts.txt
python ../../utils/deduplication.py pre-hosts.txt
cat pre-hosts.txt \
 | sed 's/0.0.0.0 /||/g' \
 | sed 's/$/&\^/g' > tmp-hosts-dns.txt

# 合并DNS通用过滤规则
cat ../mod/dns.txt tmp-allow.txt dns_uni*.txt \
 | egrep -v '^#|\!|\！|\[' \
 | sort | uniq -i > tmp-dns.txt

# 合并AdGuard过滤规则
cat tmp-adblock.txt tmp-dns.txt adguard*.txt adblock_ag*.txt \
 | egrep -v '^\!|\！|\[' \
 | sort | uniq -i > pre-adguard.txt
python ../../utils/deduplication.py pre-adguard.txt

# 分别提取AdGuard DNS规则和元素过滤规则
cat pre-adguard.txt tmp-hosts-dns.txt \
 | egrep '^(\|\||@@\|\|)?[^\^=\/:]+?\^([^\/=\*]+)?$' \
 | sort | uniq -i > pre-adguard-dns.txt
python ../../utils/deduplication.py pre-adguard-dns.txt
sort pre-adguard.txt -o pre-adguard.txt
sort pre-adguard-dns.txt -o pre-adguard-dns.txt
comm -23 pre-adguard.txt pre-adguard-dns.txt \
 | sort | uniq -i > pre-adguard-element.txt
python ../../utils/deduplication.py pre-adguard-element.txt

# 合并DNS (AdGuard Home)过滤规则
cat tmp-dns.txt tmp-hosts-dns.txt dns_agh*.txt tmp-allow.txt \
 | egrep -v '^#|\!|\！|\[' \
 | sort | uniq -i > pre-dns.txt
python ../../utils/deduplication.py pre-dns.txt


# Move to Pre Filter
echo '移动规则到Pre目录'
cd ../
mkdir -p ./pre
mkdir -p ./tpdate
mv ./tmp/pre-*.txt ./pre
rm -rf ./tmp
cd ./pre
echo '移动完成'

echo '规则合并去重处理完成'


# Start Add title and date

# 先处理HOSTS规则
cp ../../utils/title/hosts.txt ../tpdate/hosts
echo "# Version: $(TZ=UTC-8 date +'%Y-%m-%d %H:%M:%S')（北京时间）" >> ../tpdate/hosts
n=`cat pre-hosts.txt | wc -l`
echo "# Total count: $n" >> ../tpdate/hosts
cat ../tpdate/hosts ../mod/hosts ./pre-hosts.txt > ../../hosts
rm ./pre-hosts.txt

# 再处理剩下的规则
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