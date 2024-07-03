uci -q delete system.ntp.server
uci add_list system.ntp.server="0.fr.pool.ntp.org"
uci add_list system.ntp.server="1.fr.pool.ntp.org"
uci add_list system.ntp.server="2.fr.pool.ntp.org"
uci add_list system.ntp.server="3.fr.pool.ntp.org"
uci commit system
/etc/init.d/sysntpd restart


opkg update
opkg install ntpd
opkg install ntpclient
opkg install ntpd-ssl
opkg install ntpdate
opkg install ntp-utils


/etc/init.d/sysntpd disable
/etc/init.d/ntpd enable
/etc/init.d/ntpd start
netstat -l | grep ntp



# ntpq
ntpq> peer
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
 0.fr.pool.ntp.o .POOL.          16 p    -   64    0    0.000    0.000   0.000
 1.fr.pool.ntp.o .POOL.          16 p    -   64    0    0.000    0.000   0.000
 2.fr.pool.ntp.o .POOL.          16 p    -   64    0    0.000    0.000   0.000
 3.fr.pool.ntp.o .POOL.          16 p    -   64    0    0.000    0.000   0.000
+ntp-3.arkena.ne 138.96.64.10     2 u  134  256  375   11.838   -1.119   1.194
 nsr2.neoserveur 172.2.53.81      2 u 1520  512    2   17.462   -0.064   2.688
+62.210.28.176 ( 84.255.209.79    4 u  222  256  377   12.241    1.094   1.620
-time1.agiri.nin 213.246.39.118   3 u   28  256  377   12.385    2.388   0.767
*ns3.stoneartpro 193.52.184.106   2 u  107  256  377   11.448    0.467   1.243
