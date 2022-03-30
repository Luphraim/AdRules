#!/bin/bash
cd pc/rules

# Start Download
curl -o Cats-Team.txt https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/adblock-rules.txt
curl -o i1.txt https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-pc.txt
curl -o i2.txt https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-edentw.txt
curl -o i3.txt https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt
curl -o i4.txt https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt
curl -o i5.txt https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock.txt
curl -o i6.txt https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock_privacy.txt
curl -o i11.txt https://raw.githubusercontent.com/neodevpro/neodevhost/master/lite_adblocker
curl -o i12.txt https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt
curl -o i13.txt https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-adguard.txt
curl -o i14.txt https://www.i-dont-care-about-cookies.eu/abp/
curl -o i15.txt https://easylist-downloads.adblockplus.org/antiadblockfilters.txt

# Start Merge and Duplicate Removal
cat i*.txt > mergd.txt
cat user-rules.dd >> mergd.txt
cat mergd.txt | grep -v '^!' | grep -v '^！' | grep -v '^# ' | grep -v '^# ' | grep -v '^\[' | grep -v '^\【' > all.txt
sort -n all.txt | uniq > rules.txt

# Start Count Rules
num=`cat rules.txt | wc -l`

# Start Add title and date
echo "! Version: `date +"%Y-%m-%d %H:%M:%S"`" >> tpdate.txt
echo "! Total count: $num " >> tpdate.txt
echo " " >> tpdate.txt
cat title.dd tpdate.txt Cats-Team.dd rules.txt > ../../filter.txt
rm *.txt
cd ../../
exit
