BEGIN {
    IGNORECASE = 1
    OFS = "\n"

    if (OUT_DIR == "") OUT_DIR = "."

    out_filter = OUT_DIR "/filter.txt"
    out_filter_lite = OUT_DIR "/filter-lite.txt"
    out_adg = OUT_DIR "/adguard.txt"
    out_adg_elem = OUT_DIR "/adguard-element.txt"
    out_adg_dns = OUT_DIR "/adguard-dns.txt"
    out_dns = OUT_DIR "/dns.txt"
    out_hosts = OUT_DIR "/hosts"

    system("> " out_filter)
    system("> " out_filter_lite)
    system("> " out_adg)
    system("> " out_adg_elem)
    system("> " out_adg_dns)
    system("> " out_dns)
    system("> " out_hosts)

    c_filter = c_lite = c_adg = c_adg_elem = c_adg_dns = c_dns = c_hosts = drop_cnt = 0
}

function trim(s) {
    sub(/^[[:space:]\r]+/, "", s)
    sub(/[[:space:]\r]+$/, "", s)
    return s
}

function is_comment(s) { return s == "" || s ~ /^[!\[]/ || s ~ /^# / }

function detect_source(path,   a, n, f) {
    n = split(path, a, "/")
    f = tolower(a[n])

    if (f == "static.txt") return "STATIC"

    if (f ~ /^ublock/) return "UBLOCK"

    if (f ~ /^adguard/) return "ADGUARD"

    if (f ~ /^abp_pc/) return "ABP_PC"

    if (f ~ /^abp_mobile/) return "ABP_MOBILE"

    if (f ~ /^dns/) return "DNS"

    if (f ~ /^hosts/) return "HOSTS"

    if (f ~ /^allow/) return "ALLOW"

    return "UNKNOWN"
}

function get_pure_domain(rule,   d) {
    if (rule ~ /^(@@)?\|\|[A-Za-z0-9._-]+\^$/) {
        d = rule
        sub(/^(@@)?\|\|/, "", d)
        sub(/\^$/, "", d)
        return d
    }

    return ""
}

function is_element(rule) {
    return rule ~ /##/ || rule ~ /#@#/ || rule ~ /#\?#/ || rule ~ /#\$#/
}

# uBO 接受所有元素规则
function is_ubo_element(rule) { return is_element(rule) }

# Lite 剔除复杂语法
function is_lite_element(rule) {
    if (!is_element(rule)) return 0

    if (rule ~ /##:(has|matches-css|xpath)/) return 0

    if (rule ~ /##\+js/) return 0

    if (rule ~ /#\?#/) return 0

    if (rule ~ /#\$#/) return 0

    if (rule ~ /##\^script/) return 0

    return 1
}

# AdGuard 剔除 uBO 专属语法
function is_adguard_element(rule) {
    if (!is_element(rule)) return 0

    if (rule ~ /##:(has-text|matches-css|xpath)/) return 0

    if (rule ~ /##\+js/) return 0

    if (rule ~ /##\^script/) return 0

    return 1
}

function is_allow(rule) { return rule ~ /^@@/ }

{
    line = trim($0)

    if (is_comment(line)) {
        drop_cnt++
        next
    }

    src = detect_source(FILENAME)

    # HOSTS 格式直通车
    if (\
        src == "HOSTS" &&
        line ~ /^(0\.0\.0\.0|127\.0\.0\.1|::)[[:space:]]+[A-Za-z0-9._-]+$/\
    ) {
        split(line, a, /[[:space:]]+/)
        d = a[2]

        if (d !~ /^(localhost|loopback)$/) { hosts[d] = 1 }

        next
    }

    domain = get_pure_domain(line)

    # 全局白名单提取
    if (is_allow(line)) {
        if (domain != "") allow_dns[domain] = 1

        allow_rule[line] = 1
        next
    }

    # 按类型路由规则
    if (src == "DNS") {
        if (domain != "") {
            dns[domain] = ubo_dns[domain] = lite_dns[domain] = adg_dns[\
                domain\
            ] = 1
        }

        next
    }

    if (src == "UBLOCK") {
        if (is_element(line)) {
            if (is_ubo_element(line)) ubo_elem[line] = 1
        }
        else {
            if (domain != "") ubo_dns[domain] = 1
            else ubo_net[line] = 1
        }

        next
    }

    if (src == "ADGUARD") {
        if (is_element(line)) {
            if (is_adguard_element(line)) adg_elem[line] = 1
        }
        else {
            if (domain != "") adg_dns[domain] = 1
            else adg_net[line] = 1
        }

        next
    }

    if (src == "ABP_PC") {
        if (is_element(line)) {
            if (is_ubo_element(line)) ubo_elem[line] = 1

            if (is_adguard_element(line)) adg_elem[line] = 1
        }
        else {
            if (domain != "") ubo_dns[domain] = adg_dns[domain] = 1
            else {
                ubo_net[line] = 1
                adg_net[line] = 1
            }
        }

        next
    }

    if (src == "ABP_MOBILE") {
        if (is_element(line)) {
            if (is_ubo_element(line)) ubo_elem[line] = 1

            if (is_adguard_element(line)) adg_elem[line] = 1

            if (is_lite_element(line)) lite_elem[line] = 1
        }
        else {
            if (domain != "") {
                ubo_dns[domain] = adg_dns[domain] = lite_dns[domain] = 1
            }
            else { ubo_net[line] = adg_net[line] = lite_net[line] = 1 }
        }

        next
    }

    drop_cnt++
}

END {
    # 纯域名同步给 Hosts
    for (d in dns) { hosts[d] = 1 }

    # ==== 写入 HOSTS 和 DNS ====
    n = asorti(hosts, ks)

    for (i = 1; i <= n; i++) {
        print "0.0.0.0 " ks[i] >> out_hosts
        c_hosts++
    }

    n = asorti(dns, ks)

    for (i = 1; i <= n; i++) {
        print ks[i] >> out_dns
        c_dns++
    }

    # ==== 写入 UBO (filter.txt) ====
    for (d in ubo_dns) {
        if (!(d in allow_dns)) {
            print "||" d "^" >> out_filter
            c_filter++
        }
    }

    for (r in ubo_net) {
        if (!(r in allow_rule)) {
            print r >> out_filter
            c_filter++
        }
    }

    for (r in ubo_elem) {
        print r >> out_filter
        c_filter++
    }

    for (r in allow_rule) {
        print r >> out_filter
        c_filter++
    }

    # ==== 写入 LITE (filter-lite.txt) ====
    for (d in lite_dns) {
        if (!(d in allow_dns)) {
            print "||" d "^" >> out_filter_lite
            c_lite++
        }
    }

    for (r in lite_net) {
        if (!(r in allow_rule)) {
            print r >> out_filter_lite
            c_lite++
        }
    }

    for (r in lite_elem) {
        print r >> out_filter_lite
        c_lite++
    }

    for (r in allow_rule) {
        print r >> out_filter_lite
        c_lite++
    }

    # ==== 写入 ADGUARD ====
    for (d in adg_dns) {
        if (!(d in allow_dns)) {
            print "||" d "^" >> out_adg
            c_adg++
        }
    }

    for (r in adg_net) {
        if (!(r in allow_rule)) {
            print r >> out_adg
            c_adg++
        }
    }

    for (r in adg_elem) {
        print r >> out_adg
        c_adg++
    }

    for (r in allow_rule) {
        print r >> out_adg
        c_adg++
    }

    n = asorti(adg_elem, ks)

    for (i = 1; i <= n; i++) {
        print ks[i] >> out_adg_elem
        c_adg_elem++
    }

    n = asorti(adg_dns, ks)

    for (i = 1; i <= n; i++) {
        if (!(ks[i] in allow_dns)) {
            print "||" ks[i] "^" >> out_adg_dns
            c_adg_dns++
        }
    }

    # ==== 打印统计信息 ====
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
