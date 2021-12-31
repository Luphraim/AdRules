#!/bin/bash
cd dns/rules

# Start Download
curl -o Cats-Team.dd https://raw.githubusercontent.com/Cats-Team/AdRules/main/script/adblock/src/user-rules.dd
curl -o i1.txt https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
curl -o i2.txt https://raw.githubusercontent.com/badmojr/1Hosts/master/lite/adblock.txt
curl -o i3.txt https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt
curl -o i4.txt https://curben.gitlab.io/malware-filter/urlhaus-filter-agh-online.txt
curl -o i5.txt https://easylist-downloads.adblockplus.org/antiadblockfilters.txt

# Start Merge and Duplicate Removal
cat i*.txt > mergd.txt
cat user-rules.dd >> mergd.txt
cat mergd.txt | grep -v '^!' | grep -v '^！' | grep -v '^# ' | grep -v '^# ' | grep -v '^\[' | grep -v '^\【' > all.txt
sort -n all.txt | uniq > rules.txt

# Start Count Rules
num=`cat rules.txt | wc -l`

# Merge title, date, and rules
echo "! Version: `date +"%Y-%m-%d %H:%M:%S"`" >> tpdate.txt
echo "! Total count: $num " >> tpdate.txt
echo " " >> tpdate.txt
cat title.dd tpdate.txt Cats-Team.dd rules.txt > ../../dns.txt
rm *.txt
cd ../../
exit