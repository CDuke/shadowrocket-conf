#! /bin/bash

LC_ALL=C

raw_list_file=proxy-ru-eu-raw.txt
shadowrocket_file=proxy-ru-eu.list
dnsmasq_file=openwrt/proxy-ru-eu.lst

print_header()
{
    printf "# NAME: Proxy Russia To Europe\n"
    printf "# AUTHOR: Denis Kulikov\n"
    printf "# REPO: https://github.com/CDuke/shadowrocket-conf\n"
    printf "# UPDATED: %s\n" "$date"  
}

convert_to_shadowrocket()
{
    print_header
    printf "# see doc https://manual.nssurge.com/rule/ruleset.html\n"
    awk '/^[^#]/ { print "DOMAIN-SUFFIX,"$1"" }' "$1"
}

convert_to_dnsmasq()
{
    print_header
    awk '/^[^#]/ { print "nftset=/"$1"/4#inet#fw4#vpn_rkn_domains" }' "$1"
}

printf -v date '%(%Y-%m-%d %H:%M:%S)T' -1
#sort -u -o $raw_list_file $raw_list_file
convert_to_shadowrocket $raw_list_file > "$shadowrocket_file"
convert_to_dnsmasq $raw_list_file > "$dnsmasq_file"