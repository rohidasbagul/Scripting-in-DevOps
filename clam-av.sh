#!/bin/bash
#USE_ME
#ROHIDAS_BAGUL

LOGFILE="/var/log/clamav/clamav-$(date +'%Y-%m-%d').log";
EMAIL_FROM="Example@email.com";
EMAIL_TO="Example@email.com";
DIRTOSCAN="/home /opt";
 
echo "Subject: ClamAV Scan Report" >> /home/clamav/mail
 
echo "Scan Date: $(date +'%Y-%m-%d') \nScan Time: $(date +'%T')" >> "$LOGFILE";
 
for S in ${DIRTOSCAN}; do
DIRSIZE=$(du -sh "$S" 2>/dev/null | cut -f1);
 
echo "\nStarting a daily scan of $S directory.\nAmount of data to be scanned is $DIRSIZE." >> "$LOGFILE";
clamscan -ri "$S" >> "$LOGFILE";
 
# get the value of "Infected lines"
MALWARE=$(tail "$LOGFILE"|grep Infected|cut -d" " -f3);
 
# if the value is not equal to zero, send an email with the log file attached
if [ "$MALWARE" -ne "0" ];then
# using heirloom-mailx below
cat /home/clamav/mail $LOGFILE |/usr/sbin/sendmail -f "$EMAIL_FROM" "$EMAIL_TO";
fi
done
 
rm -rf /home/clamav/mail
 
exit 0