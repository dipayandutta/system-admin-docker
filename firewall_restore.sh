
#Allowing loopback connections
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -i lo -j ACCEPT

#Allowing Related and Established Connections in INPUT Chain
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#SSH bot rejection
iptables -I INPUT -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --set
iptables -I INPUT -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --update --seconds 60 --hitcount 5 --j DROP 

#Allowing PING 
iptables -A INPUT -p icmp -m state --state NEW --icmp-type 8 -j ACCEPT
#Allowing Selected Ports 
iptables -A INPUT -p tcp -m tcp -m multiport -m state -i eth1 --state NEW -j ACCEPT --dports 21,22,25,80,110,143,443,465,587,993,995,8080,10000
#Allowing DNS
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp -m tcp -m state --dport 53 --state NEW -j ACCEPT
#Allowing SSH and Webmin from outside
iptables -A INPUT -p tcp -m tcp -m multiport -i eth0 -j ACCEPT --dports 22,10000
#Default INPUT Policy
iptables -A INPUT -j DROP

#Allowing Related and Established Connections in FORWARD Chain
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p udp -m udp --dport 53 -j ACCEPT
iptables -A FORWARD -p tcp -m tcp --dport 53 -m state --state NEW -j ACCEPT
#Forwading only those ports which are at the INPUT Chain
iptables -A FORWARD -p tcp -m tcp -m multiport -m state -i eth1 -o eth0 --state NEW -j ACCEPT --dports 21,22,25,80,110,143,443,465,587,993,995,8080,
#Default FORWARD Policy
iptables -A FORWARD -j DROP

#Creating Blacklist
ipset cre­ate black­list hash:ip 

#Downloading the blacklisted IP Addresses
wget -O badlist1 http://lists.blocklist.de/lists/all.txt
wget -O badlist2 http://cinsscore.com/list/ci-badguys.txt
wget -O badlist3 https://myip.ms/files/blacklist/htaccess/latest_blacklist.txt

cat badlist1 >> badips.txt
cat badlist2 >> badips.txt
cat badlist3 |  sed '/^#/ d' >>  badlips.txt

sort -u badips.txt >> block.txt

for ip in  $(cat block.txt);
do
	ipset add blacklist $ip
done
iptables -I INPUT -m set --match-set blacklist src -p TCP -m state --state NEW -j DROP
iptables -I OUTPUT -m set --match-set blacklist src -p TCP -m state --state NEW -j DROP

#iptables -t nat -A PREROUTING -i eth0 -p tcp -m set --match-set blacklist -p TCP -m state --state NEW -j DNAT --to-destination [destination:port]


#Creating Chain To Block Social Networking
#iptables -N socialblock

#Default Rule for socialblock
#iptables -A socialblock -j DROP

#Blocking Facebook
#iptables -A FORWARD -m string --string "www.facebook.com" --algo bm --from 1 --to 600 -j socialblock
#iptables -A FORWARD -m string --string "facebook.com" --algo bm --from 1 --to 600 -j socialblock
#iptables -A OUTPUT -m string --string  "facebook.com" --algo bm --from 1 --to 600 -j socialblock
#iptables -A OUTPUT -m string --string "www.facebook.com" --algo bm --from 1 --to 600 -j socialblock

#Blocking Youtube
#iptables -A FORWARD -m string --string "www.youtube.com" --algo bm --from 1 --to 600 -j socialblock
#iptables -A FORWARD -m string --string "youtube.com" --algo bm --from 1 --to 600 -j socialblock
#iptables -A OUTPUT -m string --string  "youtube.com" --algo bm --from 1 --to 600 -j socialblock
#iptables -A OUTPUT -m string --string "www.youtube.com" --algo bm --from 1 --to 600 -j socialblock

#Blocking Twitter
#iptables -A FORWARD -m string --string "www.twitter.com" --algo bm --from 1 --to 600 -j socialblock
#iptables -A FORWARD -m string --string "twitter.com" --algo bm --from 1 --to 600 -j socialblock
#iptables -A OUTPUT -m string --string  "twitter.com" --algo bm --from 1 --to 600 -j socialblock
#iptables -A OUTPUT -m string --string "www.twitter.com" --algo bm --from 1 --to 600 -j socialblock


#ALLOW Facebook for some user commented Code
#FACEBOOK_ALLOW="192.168.1.12 192.168.1.14 192.168.1.111"
#iptables -N FACEBOOK
#iptables -I FORWARD -m tcp -p tcp -m iprange --dst-range 66.220.144.0-66.220.159.255 --dport 443 -j FACEBOOK
#iptables -I FORWARD -m tcp -p tcp -m iprange --dst-range 69.63.176.0-69.63.191.255 --dport 443 -j FACEBOOK
#iptables -I FORWARD -m tcp -p tcp -m iprange --dst-range 204.15.20.0-204.15.23.255 --dport 443 -j FACEBOOK
#iptables -I FORWARD -m tcp -p tcp -m iprange --dst-range 66.220.144.0-66.220.159.255 --dport 80 -j FACEBOOK
#iptables -I FORWARD -m tcp -p tcp -m iprange --dst-range 69.63.176.0-69.63.191.255 --dport 80 -j FACEBOOK
#iptables -I FORWARD -m tcp -p tcp -m iprange --dst-range 204.15.20.0-204.15.23.255 --dport 80 -j FACEBOOK
#iptables -I FORWARD -m tcp -p tcp -m iprange --dst-range 69.171.242.0-69.171.242.255 --dport 80 -j FACEBOOK
#iptables -I FORWARD -m tcp -p tcp -m iprange --dst-range 69.171.229.0-69.171.229.255 --dport 80 -j FACEBOOK
#iptables -I FORWARD -m tcp -p tcp -m iprange --dst-range 69.171.224.0-69.171.224.255 --dport 80 -j FACEBOOK
#iptables -I FORWARD -m tcp -p tcp -m iprange --dst-range 69.171.242.0-69.171.242.255 --dport 443 -j FACEBOOK
#iptables -I FORWARD -m tcp -p tcp -m iprange --dst-range 69.171.229.0-69.171.229.255 --dport 443 -j FACEBOOK
#iptables -I FORWARD -m tcp -p tcp -m iprange --dst-range 69.171.224.0-69.171.224.255 --dport 443 -j FACEBOOK
 
## FACEBOOK ALLOW
#for face in $FACEBOOK_ALLOW; do
#     iptables -A FACEBOOK -s $face -j ACCEPT
# done
#iptables -A FACEBOOK -j REJECT

#iptables -t nat -A PREROUTING -i eth0 -p tcp -s banedip --dport 80 -j REDIRECT --to-port 8080

