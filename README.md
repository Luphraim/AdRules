# AdRules

### 说明

本规则仅用于个人自用，参考了[Cats-Team](https://github.com/Cats-Team)/[AdRules](https://github.com/Cats-Team/AdRules)的脚本，出于对上游规则列表及使用途径的个人需求，对其进行自定义配置与修改。

上游规则基本追溯到最上游规则，二次整合的规则基本不使用（如 halflife 的规则）。

个人使用对象分别为：PC 端的 uBlock Origin，移动端的 Adguard 及 via，DNS 层面的 Adguard Home，对其他使用方式未作适配，如有需求，可 fork 本仓库自行调整。

### 规则说明

| 名称          | 描述                                                        | 订阅                                                                              |
| ------------- | ----------------------------------------------------------- | --------------------------------------------------------------------------------- |
| AdGuard       | 推荐用于移动端 AdGuard，主要为 Adguard For Android          | [Link](https://raw.githubusercontent.com/PhoenixLjw/AdRules/main/adguard.txt)     |
| AdKiller      | 推荐用于 PC 端浏览器，如 AdGuard, Ublock Origin, AdBlock 等 | [Link](https://raw.githubusercontent.com/PhoenixLjw/AdRules/main/filter.txt)      |
| AdKiller-Lite | 推荐用于移动端浏览器，如 via, Vivaldi, X Browser 等         | [Link](https://raw.githubusercontent.com/PhoenixLjw/AdRules/main/filter-lite.txt) |
| DNSFilter     | 适用于 AdGuard Home                                         | [Link](https://raw.githubusercontent.com/PhoenixLjw/AdRules/main/dns.txt)         |
| Hosts         | 广告过滤 hosts ，重定向至 0.0.0.0                           | [Link](https://raw.githubusercontent.com/PhoenixLjw/AdRules/main/hosts.txt)       |

### 上游规则

| 组                             | 规则                                                                                                                                              |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| uBlock Origin 规则             | [uBlock filters](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt)                                               |
|                                | [uBlock filters – Badware risks](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt)                               |
|                                | [uBlock filters – Privacy](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt)                                     |
|                                | [uBlock filters – Quick fixes](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt)                             |
|                                | [uBlock filters – Resource abuse](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt)                       |
|                                | [uBlock filters – Unbreak](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt)                                     |
|                                | [uBlock filters – Annoyances](https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt)                               |
| Adguard For Android 规则       | [基础过滤器](https://filters.adtidy.org/android/filters/2_optimized.txt)                                                                          |
|                                | [移动设备过滤器](https://filters.adtidy.org/android/filters/11_optimized.txt)                                                                     |
|                                | [防跟踪保护过滤器](https://filters.adtidy.org/android/filters/3_optimized.txt)                                                                    |
|                                | [URL 跟踪过滤器](https://filters.adtidy.org/android/filters/17_optimized.txt)                                                                     |
|                                | [社交媒体过滤器](https://filters.adtidy.org/android/filters/4_optimized.txt)                                                                      |
|                                | [恼人广告过滤器](https://filters.adtidy.org/android/filters/14_optimized.txt)                                                                     |
|                                | [中文过滤器](https://filters.adtidy.org/android/filters/224_optimized.txt)                                                                        |
| Adguard For uBlock Origin 规则 | [基础过滤器](https://filters.adtidy.org/extension/ublock/filters/2_optimized.txt)                                                                 |
|                                | [防跟踪保护过滤器](https://filters.adtidy.org/extension/ublock/filters/3_optimized.txt)                                                           |
|                                | [URL 跟踪过滤器](https://filters.adtidy.org/extension/ublock/filters/17_optimized.txt)                                                            |
|                                | [社交媒体过滤器](https://filters.adtidy.org/extension/ublock/filters/4_optimized.txt)                                                             |
|                                | [恼人广告过滤器](https://filters.adtidy.org/extension/ublock/filters/14_optimized.txt)                                                            |
|                                | [中文过滤器](https://filters.adtidy.org/extension/ublock/filters/224_optimized.txt)                                                               |
| 通用元素过滤规则               | [I don't care about cookies](https://www.i-dont-care-about-cookies.eu/abp/)                                                                       |
|                                | [Adblock Warning Removal List](https://easylist-downloads.adblockplus.org/antiadblockfilters.txt)                                                 |
|                                | [乘风通用过滤规则](https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt)，适用于 UBO 或 ADG                                |
|                                | [乘风视频过滤规则](https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt)，适用于 UBO 或 ADG                                  |
|                                | [GoodbyeAds](https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Hosts/GoodbyeAds.txt)                                                   |
|                                | [GoodbyeAds YouTube Adblock](https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Extension/GoodbyeAds-YouTube-AdBlock.txt)               |
|                                | [GoodbyeAds Spotify AdBlock](https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Extension/GoodbyeAds-Spotify-AdBlock.txt)               |
| 元素过滤规则，推荐移动端       | [adgk 规则](https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt) @坂本大佬                                                         |
|                                | [百度超级净化](https://raw.githubusercontent.com/banbendalao/ADgk/master/kill-baidu-ad.txt) @坂本大佬                                             |
|                                | [Anti-AD for Adguard](https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-adguard.txt)                              |
|                                | [主要去除手机盗版网站广告](https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt) @酷安：大萌主                                     |
|                                | [去 APP 下载广告规则](https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt)                                          |
| 元素过滤规则，推荐 PC 端       | [EasyList](https://easylist-downloads.adblockplus.org/easylist.txt) (反广告主规则列表。主要面向英文网站，包含大量通用规则)                        |
|                                | [Easylist China](https://easylist-downloads.adblockplus.org/easylistchina.txt) (反广告主规则列表的补充。主要面向中文网站)                         |
|                                | [EasyPrivacy](https://easylist-downloads.adblockplus.org/easyprivacy.txt) (防隐私跟踪挖矿规则列表)                                                |
|                                | [CJX's Annoyance List](https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-annoyance.txt) (反自我推广,移除 anti adblock,防跟踪规则列表) |
|                                | (ubo 专用) [CJX's uBlock list](https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-ublock.txt) (CJX's Annoyance List 的补充。)          |
|                                | [Fanboy's Social Blocking List](https://easylist-downloads.adblockplus.org/fanboy-social.txt) (去社交媒体图标列表，去“分享”按钮)                  |
|                                | [BarbBlock For uBlock Origin](https://paulgb.github.io/BarbBlock/blacklists/ublock-origin.txt)                                                    |
|                                | [Hacamer's URL Filter](https://raw.githubusercontent.com/Cats-Team/AdRule/main/url-filter.txt)                                                    |
|                                | [Online Malicious URL Blocklist](https://curben.gitlab.io/malware-filter/urlhaus-filter-online.txt) URL-based                                     |
| DNS 过滤规则                   | [AdGuard DNS filter](https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt)                                                          |
|                                | [Anti-AD for AdGuardHome](https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt)（DNS 过滤）             |
|                                | [Online Malicious URL Blocklist](https://curben.gitlab.io/malware-filter/urlhaus-filter-agh-online.txt) Domain-based (AdGuard Home)               |
|                                | [LWJ's black list](https://raw.githubusercontent.com/liwenjie119/adg-rules/master/black.txt)                                                      |
|                                | [Spam404](https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt)                                                              |
|                                | [Hacamer's URL Filter](https://raw.githubusercontent.com/Cats-Team/AdRule/main/url-filter.txt)                                                    |
| HOSTS 过滤                     | [大圣净化规则](https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts)                                                                   |
|                                | [neoHosts - Basic Hosts](https://cdn.jsdelivr.net/gh/neoFelhz/neohosts@gh-pages/basic/hosts.txt) 基础、克制的数据，推荐所有用户使用。             |
|                                | [AdAway](https://adaway.org/hosts.txt)                                                                                                            |
|                                | [NEO DEV HOST - Lite version](https://raw.githubusercontent.com/neodevpro/neodevhost/master/lite_host) (Without Dead Domain inside)               |
|                                | [BarbBlock](https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt)                                                                         |
|                                | [NoCoin adblock list](https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt)                                           |
|                                | [yhosts](https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts) 智能设备专用(更全,用电脑看视频网站可能出错)                              |
|                                | [GoodbyeAds YouTube Adblock](https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Extension/GoodbyeAds-YouTube-AdBlock.txt)               |
|                                | [GoodbyeAds Spotify AdBlock](https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Extension/GoodbyeAds-Spotify-AdBlock.txt)               |
| 白名单规则                     | [LWJ's white list](https://raw.githubusercontent.com/liwenjie119/adg-rules/master/white.txt)                                                      |
|                                | [AdGuard Chinese Filters whitelist](https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/ChineseFilter/sections/whitelist.txt)     |
|                                | [AdGuard Spyware Filters whitelist](https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/SpywareFilter/sections/whitelist.txt)     |
|                                | 上述所有规则里的白名单规则                                                                                                                        |
| 其他（rules/mod 下)            | 自定义元素过滤规则(element.txt)                                                                                                                   |
|                                | 自定义 url 过滤规则(dns.txt)                                                                                                                      |
|                                | 自定义白名单规则(allowlist.txt)                                                                                                                   |
