#!/bin/bash
cd hosts/rules

# Start Download
curl -o i1.txt https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts
curl -o i2.txt https://cdn.jsdelivr.net/gh/neoFelhz/neohosts@gh-pages/127.0.0.1/full/hosts
curl -o i3.txt https://adaway.org/hosts.txt
curl -o i4.txt https://raw.githubusercontent.com/neodevpro/neodevhost/master/lite_host
curl -o i5.txt https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt
curl -o i6.txt https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt

# Start Merge and Duplicate Removal
cat *.txt > mergd.txt
cat user-rules.dd >> mergd.txt
cat mergd.txt | grep -v '^!' | grep -v '^！' | grep -v '^# ' | grep -v '^# ' | grep -v '^\[' | grep -v '^\【' > all.txt
sed -i 's/0.0.0.0/127.0.0.1/g' all.txt
sed -i 's/  / /g' all.txt
sort -n all.txt | uniq > rules.txt

# Start Count Rules
num=`cat rules.txt | wc -l`

# Merge title, date, and rules
echo "! Version: `date +"%Y-%m-%d %H:%M:%S"`" >> tpdate.txt
echo "! Total count: $num " >> tpdate.txt
echo " " >> tpdate.txt
cat title.dd tpdate.txt rules.txt > ../../hosts.txt
rm i*.txt
cd ../../
exit