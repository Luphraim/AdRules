# AdKiller

### 说明

本规则仅用于个人自用，参考了 [Cats-Team](https://github.com/Cats-Team)/[AdRules](https://github.com/Cats-Team/AdRules) 的脚本，出于对上游规则列表及使用途径的个人需求，对其进行自定义配置与修改。项目通过 Github-Actions 自动提交更新。

个人使用对象分别为：PC 端的 uBlock Origin，移动端的 Adguard 及 via，DNS 层面的 Adguard Home，对其他使用方式未作适配，如有需求，可自行调整。

移动端 AdGuard 推荐 AdGuard-DNS 和 AdGuard-Element 结合使用，不想开 DNS 过滤的只订阅 AdGuard 即可。

- 2023.6.14 更新：AdGuard for Android 更新 4.0 稳定版，建议把“烦人元素拦截”全部打开，跟踪保护选择“隐私保护级别——高”。故规则里相应上游规则也一并删除了，以作精简。更新了一部分上游规则列表。
- 2024.8.8 更新：AdGuard For Android由于耗电、网络延迟等因素，已不再使用，随缘检测上游规则有效性。
- 2025.2.25 更新：检测上游规则有效性，更新合并去重脚本。PS：本仓库只负责上游脚本的合并去重，规则有问题的建议向对应上游仓库提交。
- 2026.1.30 更新：检测上游规则有效性，重构规则分类与合并脚本，修复高级网络规则丢失问题，优化体积。

### 规则说明


| 名称            | 描述                                                           | 订阅                                                                                   |
| --------------- | -------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| AdGuard         | 推荐用于移动端 AdGuard，主要为 Adguard For Android             | [Link](https://raw.githubusercontent.com/Luphraim/AdRules/release/adguard.txt)         |
| AdKiller        | 推荐用于 PC 端浏览器，如 AdGuard, Ublock Origin, AdBlock 等    | [Link](https://raw.githubusercontent.com/Luphraim/AdRules/release/filter.txt)          |
| AdKiller-Lite   | 推荐用于移动端轻量浏览器，如 via, Vivaldi, X Browser, ALook 等 | [Link](https://raw.githubusercontent.com/Luphraim/AdRules/release/filter-lite.txt)     |
| DNSFilter       | 适用于 AdGuard Home 及各类路由器的 DNS 拦截                    | [Link](https://raw.githubusercontent.com/Luphraim/AdRules/release/dns.txt)             |
| Hosts           | 广告过滤 hosts ，可直接替换系统 hosts 文件，重定向至 0.0.0.0   | [Link](https://raw.githubusercontent.com/Luphraim/AdRules/release/hosts)               |
| AdGuard-DNS     | AdGuard 的 DNS 提取规则，适用于 AdGuard 的 DNS 模块            | [Link](https://raw.githubusercontent.com/Luphraim/AdRules/release/adguard-dns.txt)     |
| AdGuard-Element | AdGuard 的元素提取规则，适用于 AdGuard 的内容拦截模块          | [Link](https://raw.githubusercontent.com/Luphraim/AdRules/release/adguard-element.txt) |

### 上游规则


| 组分类                                          | 包含的核心规则库                                                                                                                                                                                                          |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **UBLOCK 专属规则**                             | `uBlock filters` (含 Base, Badware, Privacy, Quick-fixes, Unbreak 等)<br>`Annoyances` (基础, 其他, Cookies)<br>`uBO Link Shorteners`<br>`ClearURLs` (去除跟踪尾巴)<br>`LegitimateURLShortener`                            |
| **ADGUARD 专属规则**                            | `AdGuard 基础过滤器` (Web / Android)<br>`AdGuard 防跟踪保护`<br>`AdGuard 社交媒体`<br>`AdGuard 恼人广告`<br>`AdGuard 中文过滤器` (Web / Android)<br>`URL 跟踪过滤器`                                                      |
| **通用 ABP 桌面端**<br>*(分发至 PC)*            | `halflife-pc` (合并乘风视频、Easylist、EasyPrivacy等)<br>`halflife-edentw` (防反广告拦截)<br>`乘风视频过滤规则` & `乘风通用过滤规则`                                                                                      |
| **通用 ABP 移动端**<br>*(分发至 移动端及 Lite)* | `ADgk` (坂本大佬 - 去除各种繁杂广告)<br>`百度超级净化` (坂本大佬)<br>`主要去除手机盗版网站广告` (大萌主)<br>`去 APP 下载广告规则`<br>`AWAvenue-Ads-Rule` (秋风广告规则)<br>`halflife-mobile`<br>`uBlock filters - Mobile` |
| **DNS 过滤规则**<br>*(分发至 DNS)*              | `Anti-AD for AdGuardHome` (泛用性极佳)<br>`AdGuard DNS filter`<br>`AdRules DNS`<br>`HostsVN adservers-all`<br>`urlhaus-filter-agh-online`<br>`LWJ's black list`<br>`Smart-TV AGH`                                         |
| **HOSTS 过滤**<br>*(提取纯域名)*                | `大圣净化规则`<br>`NoCoin adblock list`<br>`yhosts` (智能设备专用)<br>`HostsVN`                                                                                                                                           |
| **白名单规则**                                  | `AdGuard Chinese Filters allowlist`<br>`GOODBYEADS allow`<br>`LWJ's white list`                                                                                                                                           |
| **本地自定义**                                  | `rules/mod/static.txt` (自行添加在本地的自定义规则)                                                                                                                                                                       |

### 推荐项目

以下推荐一些比较成熟的规则整合项目，主要面向中文过滤：

- [anti-AD](https://anti-ad.net/)
- [Cats-Team / AdRules](https://github.com/Cats-Team/AdRules)
- [NEO DEV HOST](https://github.com/neodevpro/neodevhost)
- [halflife-list](https://github.com/sbwml/halflife-list)