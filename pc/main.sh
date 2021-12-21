#!/bin/bash
cd pc/rules

# Start Download
curl -o i1.txt https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-pc.txt
curl -o i2.txt https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-edentw.txt
curl -o i3.txt https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt
curl -o i4.txt https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt
curl -o i5.txt https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock.txt
curl -o i6.txt https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock_privacy.txt
curl -o i7.txt https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt
curl -o i8.txt https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt
curl -o i9.txt https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt
curl -o i10.txt https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt
curl -o i11.txt https://raw.githubusercontent.com/neodevpro/neodevhost/master/lite_adblocker
curl -o i12.txt https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt
curl -o i13.txt https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-adguard.txt
# curl -o i17.txt https://www.i-dont-care-about-cookies.eu/abp/

# Start Merge and Duplicate Removal
cat i*.txt > mergd.txt
cat mergd.txt | grep -v '^!' | grep -v '^！' | grep -v '^# ' | grep -v '^# ' | grep -v '^\[' | grep -v '^\【' > all.txt
sort -n all.txt | uniq > rules.txt

# Start Count Rules
num=`cat rules.txt | wc -l`

# Start Add title and date
echo "! Version: `date +"%Y-%m-%d %H:%M:%S"`" >> tpdate.txt
echo "! Total count: $num" >> tpdate.txt
cat title.dd tpdate.txt user-rules.dd rules.txt > ../../filter.txt
rm *.txt
cd ../../
exit
