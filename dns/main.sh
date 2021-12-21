#!/bin/bash
cd dns/rules

# Start Download
curl -o i1.txt https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
curl -o i2.txt https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts
curl -o i3.txt https://raw.githubusercontent.com/badmojr/1Hosts/master/lite/adblock.txt
curl -o i4.txt https://cdn.jsdelivr.net/gh/neoFelhz/neohosts@gh-pages/127.0.0.1/full/hosts
curl -o i5.txt https://adaway.org/hosts.txt
curl -o i6.txt https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt
curl -o i7.txt https://raw.githubusercontent.com/neodevpro/neodevhost/master/lite_host
curl -o i8.txt https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt

# Start Merge and Duplicate Removal
cat i*.txt > mergd.txt
# cat mergd.txt | grep '^|' | grep -v './' | grep -v '.\$' > block.txt
# cat mergd.txt | grep '^@' | grep -v './' | grep -v '.\$' > allow.txt
# cat block.txt allow.txt > all.txt
cat mergd.txt | grep -v '^!' | grep -v '^！' | grep -v '^# ' | grep -v '^# ' | grep -v '^\[' | grep -v '^\【' > all.txt
sort -n all.txt | uniq > rules.txt

# Start Count Rules
num=`cat rules.txt | wc -l`

# Merge title, date, and rules
echo "! Version: `date +"%Y-%m-%d %H:%M:%S"`" >> tpdate.txt
echo "! Total count: $num" >> tpdate.txt
cat title.dd tpdate.txt rules.txt > ../../dns.txt
rm *.txt
cd ../../
exit