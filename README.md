# AdKiller

### 说明

本规则仅用于个人自用，参考了[Cats-Team](https://github.com/Cats-Team)/[AdRules](https://github.com/Cats-Team/AdRules)的脚本，出于对上游规则列表及使用途径的个人需求，对其进行自定义配置与修改。项目通过 Github-Actions 自动提交更新。

个人使用对象分别为：PC 端的 uBlock Origin，移动端的 Adguard 及 via，DNS 层面的 Adguard Home，对其他使用方式未作适配，如有需求，可自行调整。

移动端 AdGuard 推荐 AdGuard-DNS 和 AdGuard-Element 结合使用，不想开 DNS 过滤的只订阅 AdGuard 即可。

- 2023.6.14 更新：AdGuard for Android 更新 4.0 稳定版，建议把“烦人元素拦截”全部打开，跟踪保护选择“隐私保护级别——高”。故规则里相应上游规则也一并删除了，以作精简。更新了一部分上游规则列表。

- 2024.8.8 更新：AdGuard For Android由于耗电、网络延迟等因素，已不再使用，随缘检测上游规则有效性。

- 2025.2.25更新：检测上游规则有效性，更新合并去重脚本。PS：本仓库只负责上游脚本的合并去重，规则有问题的建议向对应上游仓库提交。

### 规则说明

| 名称            | 描述                                                         | 订阅                                                                                  |
| --------------- | ------------------------------------------------------------ | ------------------------------------------------------------------------------------- |
| AdGuard         | 推荐用于移动端 AdGuard，主要为 Adguard For Android           | [Link](https://raw.githubusercontent.com/PhoenixLjw/AdRules/main/adguard.txt)         |
| AdKiller        | 推荐用于 PC 端浏览器，如 AdGuard, Ublock Origin, AdBlock 等  | [Link](https://raw.githubusercontent.com/PhoenixLjw/AdRules/main/filter.txt)          |
| AdKiller-Lite   | 推荐用于移动端浏览器，如 via, Vivaldi, X Browser 等          | [Link](https://raw.githubusercontent.com/PhoenixLjw/AdRules/main/filter-lite.txt)     |
| DNSFilter       | 适用于 AdGuard Home                                          | [Link](https://raw.githubusercontent.com/PhoenixLjw/AdRules/main/dns.txt)             |
| Hosts           | 广告过滤 hosts ，可直接替换系统 hosts 文件，重定向至 0.0.0.0 | [Link](https://raw.githubusercontent.com/PhoenixLjw/AdRules/main/hosts)               |
| AdGuard-DNS     | AdGuard 的 DNS 提取规则，适用于 AdGuard 的 DNS 功能          | [Link](https://raw.githubusercontent.com/PhoenixLjw/AdRules/main/adguard-dns.txt)     |
| AdGuard-Element | AdGuard 的元素提取规则，适用于 AdGuard 的内容拦截功能        | [Link](https://raw.githubusercontent.com/PhoenixLjw/AdRules/main/adguard-element.txt) |

### 上游规则

| 组                       | 规则                                                                                                                                                                                                   |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| uBlock Origin 规则       | [uBlock filters](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt)                                                                                                    |
|                          | [uBlock filters – Badware risks](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt)                                                                                    |
|                          | [uBlock filters – Privacy](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt)                                                                                          |
|                          | [uBlock filters – Quick fixes](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt)                                                                                  |
|                          | [uBlock filters – Unbreak](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt)                                                                                          |
|                          | [uBlock filters – Annoyances](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt)                                                                                    |
| Adguard For Android 规则 | [基础过滤器](https://filters.adtidy.org/android/filters/2_optimized.txt)                                                                                                                               |
|                          | [中文过滤器](https://filters.adtidy.org/android/filters/224_optimized.txt)                                                                                                                             |
| 通用元素过滤规则         | [乘风通用过滤规则](https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt)，适用于 UBO 或 ADG                                                                                     |
|                          | [乘风视频过滤规则](https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt)，适用于 UBO 或 ADG                                                                                       |
|                          | [秋风广告规则](https://raw.githubusercontent.com/TG-Twilight/AWAvenue-Adblock-Rule/main/AWAvenue-Adblock-Rule.txt)                                                                                     |
|                          | [GOODBYEADS Rules](https://raw.githubusercontent.com/8680/GOODBYEADS/master/data/rules/adblock.txt)                                                                                                    |
|                          | [百度超级净化](https://raw.githubusercontent.com/banbendalao/ADgk/master/kill-baidu-ad.txt) @坂本大佬                                                                                                  |
| 元素过滤规则，推荐移动端 | [adgk 规则](https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt) @坂本大佬                                                                                                              |
|                          | [Anti-AD for Adguard](https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-adguard.txt)                                                                                   |
|                          | [主要去除手机盗版网站广告](https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt) @酷安：大萌主                                                                                          |
|                          | [去 APP 下载广告规则](https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt)                                                                                               |
| 元素过滤规则，推荐 PC 端 | [halflife](https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-pc.txt)规则，[推荐桌面端]合并自乘风视频广告过滤规则、Easylist、EasylistChina、EasyPrivacy、CJX'sAnnoyance，以及补充的一些规则 |
|                          | [halflife](https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-edentw.txt)规则，合并自 Adblock Warning Removal List、ABP filters、anti-adblock-killer-filters                                |
|                          | [I don't care about cookies](https://www.i-dont-care-about-cookies.eu/abp/)                                                                                                                            |
| DNS 过滤规则             | [AdGuard DNS filter](https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt)                                                                                                               |
|                          | [Anti-AD for AdGuardHome](https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt)（DNS 过滤）                                                                  |
|                          | [Online Malicious URL Blocklist](https://curben.gitlab.io/malware-filter/urlhaus-filter-agh-online.txt) Domain-based (AdGuard Home)                                                                    |
| HOSTS 过滤               | [大圣净化规则](https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts)                                                                                                                        |
|                          | [NoCoin adblock list](https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt)                                                                                                |
|                          | [yhosts](https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts) 智能设备专用(更全,用电脑看视频网站可能出错)                                                                                   |
|                          | [hostsVN](https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts)                                                                                                                            |
| 白名单规则               | [Energized Protection - unblock](https://raw.githubusercontent.com/EnergizedProtection/unblock/master/basic/formats/filter)                                                                            |
|                          | [AdGuard Chinese Filters whitelist](https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/ChineseFilter/sections/whitelist.txt)                                                          |
| 其他（rules/mod 下)      | 自定义元素过滤规则(element.txt)                                                                                                                                                                        |
|                          | 自定义 url 过滤规则(dns.txt)                                                                                                                                                                           |
|                          | 自定义白名单规则(allowlist.txt)                                                                                                                                                                        |

### 推荐项目

以下推荐一些比较成熟的规则整合项目，主要面向中文过滤。

- [anti-AD](https://anti-ad.net/)
- [Cats-Team](https://github.com/Cats-Team)/[AdRules](https://github.com/Cats-Team/AdRules)
- [NEO DEV HOST](https://github.com/neodevpro/neodevhost)
