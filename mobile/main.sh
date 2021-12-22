#!/bin/bash
cd mobile/rules

# Start Download
curl -o user-rules.dd https://raw.githubusercontent.com/Cats-Team/AdRules/main/script/adblock/src/user-rules.dd
# curl -o i1.txt https://filters.adtidy.org/android/filters/2_optimized.txt
# curl -o i2.txt https://filters.adtidy.org/android/filters/11_optimized.txt
# curl -o i3.txt https://filters.adtidy.org/android/filters/3_optimized.txt
# curl -o i4.txt https://filters.adtidy.org/android/filters/224_optimized.txt
# curl -o i5.txt https://filters.adtidy.org/android/filters/14_optimized.txt
# curl -o i6.txt https://filters.adtidy.org/android/filters/5_optimized.txt
# curl -o i7.txt https://filters.adtidy.org/android/filters/4_optimized.txt
curl -o i8.txt https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad.txt
curl -o i9.txt https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock_lite.txt
curl -o i10.txt https://raw.githubusercontent.com/neodevpro/neodevhost/master/lite_adblocker
curl -o i11.txt https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt
curl -o i12.txt https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt
curl -o i13.txt https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt
curl -o i14.txt https://raw.githubusercontent.com/banbendalao/ADgk/master/kill-baidu-ad.txt
curl -o i15.txt https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt
curl -o i16.txt https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt
curl -o i17.txt https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-adguard.txt
curl -o i18.txt https://raw.githubusercontent.com/badmojr/1Hosts/master/Lite/adblock.txt

# Start Merge and Duplicate Removal
cat i*.txt > mergd.txt
cat mergd.txt | grep -v '^!' | grep -v '^！' | grep -v '^# ' | grep -v '^# ' | grep -v '^\[' | grep -v '^\【' > all.txt
sort -n all.txt | uniq > rules.txt

# Start Count Rules
num=`cat rules.txt | wc -l`

# Start Add title and date
echo "! Version: `date +"%Y-%m-%d %H:%M:%S"`" >> tpdate.txt
echo "! Total count: $num" \n>> tpdate.txt
cat title.dd tpdate.txt user-rules.dd rules.txt > ../../mobile.txt
rm *.txt
cd ../../
exit