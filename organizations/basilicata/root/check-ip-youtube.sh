#!/bin/bash
# find ASN with https://www.ultratools.com/tools/asnInfo
# Al momento è utilizzabile questo script solo da pc, non c'è whois su LEDE/OpenWRT

whois -h whois.radb.net -- '-i origin AS36561' | grep ^route > /tmp/youtube-AS36561.txt
whois -h whois.radb.net -- '-i origin AS43515' | grep ^route > /tmp/youtube-AS43515.txt

cat /tmp/youtube-AS36561.txt /tmp/youtube-AS43515.txt > /tmp/youtube-AS36561-43515.txt
sed "s/[route6:     ]//g" /tmp/youtube-AS36561-43515.txt > ip-youtube.txt
rm -rf /tmp/youtube-AS*
