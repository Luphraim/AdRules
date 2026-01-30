BEGIN {
    IGNORECASE = 1
    OFS = "\n"

    # ========= 输出文件 =========
    out_filter = "filter.txt"
    out_filter_lite = "filter-lite.txt"
    out_adg = "adguard.txt"
    out_adg_elem = "adguard-element.txt"
    out_adg_dns = "adguard-dns.txt"
    out_dns = "dns.txt"
    out_hosts = "hosts"

    # ========= 清空旧文件 =========
    system("> " out_filter)
    system("> " out_filter_lite)
    system("> " out_adg)
    system("> " out_adg_elem)
    system("> " out_adg_dns)
    system("> " out_dns)
    system("> " out_hosts)

    # ========= 统计 =========
    c_filter = c_lite = c_adg = c_adg_elem = c_adg_dns = c_dns = c_hosts = 0
    drop_cnt = 0
}

###############################################################################
# 工具函数
###############################################################################
function trim(s) {
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", s)
    return s
}

function is_comment(s) { return s ~ /^[[:space:]]*$/ || s ~ /^[!#\[]/ }

function basename(path, a, n) {
    n = split(path, a, "/")
    return a[n]
}

function detect_source(f) {
    f = tolower(basename(f))

    # === 精确优先 ===
    if (f == "static.txt") return "STATIC"

    # === hosts ===
    if (f ~ /^hosts/) return "HOSTS"

    # === DNS ===
    if (f ~ /^dns_/) return "DNS"

    # === allow ===
    if (f ~ /^allow/) return "ALLOW"

    # === adblock ===
    if (f ~ /^adblock_lite/) return "LITE"

    if (f ~ /^adblock_full/) return "FULL"

    if (f ~ /^adblock_uni/) return "UNI"

    # === uBlock ===
    if (f ~ /^ublock/) return "UBLOCK"

    # === AdGuard ===
    if (f ~ /^adguard/) return "ADGUARD"

    return "UNKNOWN"
}

function is_hosts(rule) {
    return rule ~ /^(0\.0\.0\.0|127\.0\.0\.1|::)[[:space:]]+[A-Za-z0-9._-]+$/
}

function is_allow(rule) { return rule ~ /^@@(\|\|)?[A-Za-z0-9._-]+\^$/ }

function is_dns(rule) { return rule ~ /^(\|\|)?[A-Za-z0-9._-]+\^$/ }

function is_element(rule) { return rule ~ /[#@$]/ || s ~ /\$/ }

function is_ubo_dns(rule) {
    # 基础 hostname 规则
    if (rule ~ /^\|\|[a-z0-9._-]+\^$/) return 1

    # 带路径的网络规则
    if (rule ~ /^\|\|[a-z0-9._-]+\/[^ ]+\^?$/) return 1

    # uBO 支持的网络 option
    if (\
        rule ~ /^\|\|[a-z0-9._-]+\^.*\$(script|image|media|xhr|third-party|popup|subdocument|font|stylesheet|websocket|ping|other)(,|$)/\
    ) return 1

    return 0
}

function is_ubo_element(rule) {
    # 基础 CSS
    if (rule ~ /^[^#@]*##[^#]/) return 1

    # uBO procedural cosmetic
    if (rule ~ /##:(has|has-text|matches-css|matches-attr|xpath)\(/) return 1

    # uBO JS 注入
    if (rule ~ /##\+js\(/) return 1

    # scriptlet 形式
    if (rule ~ /##\^script:/) return 1

    return 0
}

function is_lite_dns(rule) {
    # 只允许最纯 hostname
    if (rule ~ /^\|\|[a-z0-9._-]+\^$/) return 1

    return 0
}

function is_lite_element(rule) {
    # 仅基础 CSS selector
    if (rule ~ /^[^#@]*##[a-zA-Z0-9.#\[\]=_"'-]+$/) return 1

    return 0
}

function is_adguard_dns(rule) {
    if (rule ~ /^\|\|[a-z0-9._-]+\^$/) return 1

    # AdGuard DNS option（有限）
    if (rule ~ /^\|\|[a-z0-9._-]+\^.*\$(important|badfilter)(,|$)/) return 1

    return 0
}

function is_adguard_element(rule) {
    # 标准 cosmetic
    if (rule ~ /^[^#@]*##[^#]/) return 1

    # 排除 uBO-only 语法
    if (rule ~ /##:(has|has-text|matches-css|xpath)\(/) return 0

    if (rule ~ /##\+js\(/) return 0

    if (rule ~ /##\^script:/) return 0

    return 0
}

function domain_from(s, d) {
    d = s
    sub(/^@@/, "", d)
    sub(/^\|\|/, "", d)
    sub(/\^$/, "", d)
    return d
}

###############################################################################
# 主处理
###############################################################################
{
    src = detect_source(FILENAME)
    line = trim($0)

    if (is_comment(line)) {
        drop_cnt++
        next
    }

    # ===== HOSTS 上游：只进 hosts =====
    if (src == "HOSTS" && is_hosts(line)) {
        split(line, a, /[[:space:]]+/)
        d = a[2]

        if (d !~ /^(localhost|loopback)$/) { hosts[d] = d }

        next
    }

    # ===== DNS 上游 =====
    if (src == "DNS") {
        if (is_dns(line)) {
            d = domain_from(line)
            dns[d] = d

            if (is_ubo_dns(line)) { ubo_dns[d] = d }

            if (is_lite_dns(line)) { lite_dns[d] = d }

            if (is_adguard_dns(line)) { adg_dns[d] = d }

            next
        }
    }

    # ===== ALLOW（通用） =====
    if (is_allow(line)) {
        d = domain_from(line)
        allow[d] = "@@||" d "^"
        next
    }

    # ===== uBlock =====
    if (src == "UBLOCK" || src == "UNI") {
        if (is_dns(line)) {
            d = domain_from(line)
            dns[d] = d

            if (is_ubo_dns(line)) { ubo_dns[d] = d }

            if (is_lite_dns(line)) { lite_dns[d] = d }

            if (is_adguard_dns(line)) { adg_dns[d] = d }

            next
        }

        if (is_ubo_element(line)) {
            ubo_elem[line] = 1
            next
        }
    }

    # ===== filter-lite =====
    if (src == "LITE") {
        if (is_dns(line)) {
            d = domain_from(line)
            dns[d] = d

            if (is_ubo_dns(line)) { ubo_dns[d] = d }

            if (is_lite_dns(line)) { lite_dns[d] = d }

            if (is_adguard_dns(line)) { adg_dns[d] = d }

            next
        }

        if (is_lite_element(line)) {
            if (line !~ /\$/) { lite_elem[line] = 1 }

            next
        }
    }

    # ===== AdGuard =====
    if (src == "ADGUARD") {
        if (is_dns(line)) {
            d = domain_from(line)
            dns[d] = d

            if (is_ubo_dns(line)) { ubo_dns[d] = d }

            if (is_lite_dns(line)) { lite_dns[d] = d }

            if (is_adguard_dns(line)) { adg_dns[d] = d }

            next
        }

        if (is_adguard_element(line)) { adg_elem[line] = 1 }

        if (is_lite_element(line)) { lite_elem[line] = 1 }

        next
    }

    drop_cnt++
}

###############################################################################
# END：输出 + 排序 + 统计
###############################################################################
END {
    # ===== DNS → hosts（仅 DNS）=====
    for (d in dns) { hosts[d] = d }

    # ===== 输出 hosts =====
    n = asorti(hosts, ks)

    for (i = 1; i <= n; i++) {
        print "0.0.0.0 " ks[i] >> out_hosts
        c_hosts++
    }

    # ===== 输出 dns.txt =====
    n = asorti(dns, ks)

    for (i = 1; i <= n; i++) {
        print ks[i] >> out_dns
        c_dns++
    }

    # ===== filter =====
    for (d in ubo_dns) {
        if (!(d in allow)) {
            print "||" d "^" >> out_filter
            c_filter++
        }
    }

    for (d in allow) {
        print allow[d] >> out_filter
        c_filter++
    }

    n = asorti(ubo_elem, ks)

    for (i = 1; i <= n; i++) {
        print ks[i] >> out_filter
        c_filter++
    }

    # ===== filter-lite =====
    for (d in lite_dns) {
        if (!(d in allow)) {
            print "||" d "^" >> out_filter_lite
            c_lite++
        }
    }

    n = asorti(lite_elem, ks)

    for (i = 1; i <= n; i++) {
        print ks[i] >> out_filter_lite
        c_lite++
    }

    # ===== adguard =====
    for (d in adg_dns) {
        print "||" d "^" >> out_adg
        c_adg++
    }

    for (d in allow) {
        print allow[d] >> out_adg
        c_adg++
    }

    n = asorti(adg_elem, ks)

    for (i = 1; i <= n; i++) {
        print ks[i] >> out_adg
        c_adg++
    }

    # ===== adguard-element =====
    n = asorti(adg_elem, ks)

    for (i = 1; i <= n; i++) {
        print ks[i] >> out_adg_elem
        c_adg_elem++
    }

    # ===== adguard-dns =====
    n = asorti(adg_dns, ks)

    for (i = 1; i <= n; i++) {
        print "||" ks[i] "^" >> out_adg_dns
        c_adg_dns++
    }

    # ===== 统计输出 =====
    print "===== RULES COMPILER DONE =====" > "/dev/stderr"
    print "filter.txt        :", c_filter > "/dev/stderr"
    print "filter-lite.txt   :", c_lite > "/dev/stderr"
    print "adguard.txt       :", c_adg > "/dev/stderr"
    print "adguard-element   :", c_adg_elem > "/dev/stderr"
    print "adguard-dns       :", c_adg_dns > "/dev/stderr"
    print "dns.txt           :", c_dns > "/dev/stderr"
    print "hosts             :", c_hosts > "/dev/stderr"
    print "dropped lines     :", drop_cnt > "/dev/stderr"
}
