#! /bin/bash

echo --------Backup-----------------------
 cp/etc/login.defs/etc/login.defs.bak
 cp/etc/security/limits.conf/etc/security/limits.conf.bak
 cp/etc/pam.d/su/etc/pam.d/su.bak
 cp/etc/profile/etc/profile.bak
 cp/etc/issue.net/etc/issue.net.bak
 cp/etc/shadow/etc/shadow.bak
 cp/etc/passwd/etc/passwd.bak
 cp/etc/pam.d/passwd/etc/pam.d/passwd.bak
 cp/etc/pam.d/common-password/etc/pam.d/common-password.bak
 cp/etc/host.conf/etc/host.conf.bak
 cp/etc/hosts.allow/etc/hosts.allow.bak
 cp/etc/ntp.conf/etc/ntp.conf.bak
 cp -p/etc/sysctl.conf/etc/sysctl.conf.bak

echo --------Check whether to set the minimum number of days between password changes-----
MINDAY = ` cat -n/etc/login.defs |  grep -v ".*#.*" |  grep PASS_MIN_DAYS | awk  '{print $1 }' `
 sed -i '' $MINDAY 's/.*PASS_MIN_DAYS.*/PASS_MIN_DAYS 6/'/etc/login.defs
 echo  "Check the minimum number of days between password changes completed" 
echo --Check whether the number of days to warn before password expiration is set ---
WARNAGE = ` cat -n/etc/login.defs |  grep -v ".*#.*" |  grep PASS_WARN_AGE | awk  '{print $1 }' `
 sed -i '' $WARNAGE 's/.*PASS_WARN.*/PASS_WARN_AGE 30/'/etc/login.defs
 echo  "Check the number of warning days before the password expires complete"

echo ---Check password life cycle------
MAXDAY = ` cat -n/etc/login.defs |  grep -v ".*#.*" |  grep PASS_MAX_DAYS | awk  '{print $1 }' `
 sed -i '' $MAXDAY 's/.*PASS_MAX.*/PASS_MAX_DAYS 90/'/etc/login.defs
 echo  "Check password life cycle completed"

echo ---Check the minimum password length----
MINLEN = ` cat -n/etc/login.defs |  grep -v ".*#.*" |  grep PASS_MIN_LEN | awk  '{print $1 }' `
 sed -i '' $MINDAY 's/.*PASS_MIN_LEN.*/PASS_MIN_ LEN 6/'/etc/login.defs
 echo  "Check the minimum password length"

echo ----Check the number of times the password is reused
kk = ` cat -n/etc/pam.d/system-auth |  grep -v ".*#.*" |  grep md5 | awk  '{print $1 }' ` 
t = "password sufficient pam_unix.so md5 shadow nullok try_first_pass use_authtok remember=5" 
sed -i "" $kk "c $t "/etc/pam.d/system-auth

echo ------User authentication login failure limit ------
w = ` cat -n/etc/pam.d/login | grep PAM-1.0 | awk  '{print $1 }' ` 
t = "auth required pam_tally2.so onerr=fail deny=3 unlock_time=30 even_deny_root root_unlock_time=100" 
sed -i "" $w "a $t "/etc/pam.d/login

echo  "--------Set password complexity----------" 
q =  ` cat -n/etc/pam.d/system-auth |  grep -v ".*#. *"  |  grep'password  .*.requisite'  |  awk  '{print $1 }' ` 
t = "password requisite pam_crackilb.so difok=3 minlen=8 ucredit=-1 lcredit=-1 dcredit=1" 
sed -i ' ' $ Q ' C $ T '/etc/pam.d/system-auth

echo  "---------Add login timeout setting---------" 
echo  export TMOUT = 180 >>/etc/profile
 source/etc/profile

echo  "to history timestamped -------- ---------" 
echo  Export HISTTIMEFORMAT = "% T F.% ` the whoami ` "  >>/etc/Profile
 Source/etc/Profile

echo -----------test grub,lilo----------- #Start the boot program and add a password 
grub = "/etc/grub.conf" 
if  [  ! -x " $ grub "  ] ; then 
touch  " $grub " 
echo password = 123456 >>  " $grub " 
else  
echo password = 123456 >>  " $grub " 
fi 
lilo = "/etc/lilo.conf" 
if  [  ! -x " $lilo " ]; then 
touch  " $lilo " 
echo password = 123456 >>  " $lilo " 
else 
echo password = 123456 >>  " $lilo " 
fi

echo -------text ctrl-alt-del-----------
a =/usr/lib/systemd/system/ctrl-alt-del.target
 if  [  ! -e " $a "   ] ; then 
echo ok ! 
else 
rm -rf/usr/lib/systemd/system/ctrl-alt- del.target
init q
echo  set ok ! 
fi

echo -------history number-------
 sed -i 's/^HISTSIZE=1000/HISTSIZE=200/'/etc/profile
 source/etc/profile
 echo ------- text wheel----- Only users in the #wheel group can use su root 
echo -e auth "\t\t" required "\t" pam_wheel.so use_uid >> "/etc/pam.d/su"  
echo -e auth "\t\t" sufficient "\t" pam_rootok.so >> "/etc/pam.d/su" 
echo ok !

echo -------test issue------ #Delete the statement in the welcome interface at boot 
if  [ -f/etc/issue.net ] 
then 
mv/etc/issue.net/etc/issue.net.bak
 else 
echo  "issue.net file does not exist" 
fi 
if  [ -f/etc/issue ] 
then 
mv/etc/issue/etc/issue.bak
 else 
echo  "issue file does not exist" 
fi

echo  "check blank password account -------- -------" 
I = ` awk -F: '( $ 2 ==" ") {Print $. 1 }'/etc/Shadow `
 echo -e   " $i/n  --empty password" >> info_temp
 echo     " $i " 
echo  "---------Check the user whose uid is 0--------" 
# awk -F: ' ($. 3 == 0) {}. 1 Print $ '/etc/the passwd 
I = ` awk -F: ' {IF ( $. 3 == 0) Print $. 1 } '/etc/the passwd `
 echo -e "$i/n --uid=0" >> info_temp
 echo -e " $i/n --Save in info_temp"

echo  "---------File permission setting is complete--------" 
chmod 644/etc/passwd
 chmod 644/etc/group
 chmod 400/etc/shadow
 #chmod 600/etc/xinetd. conf 
chmod 644/etc/services
 chmod 600/etc/security
 chmod 600/etc/grub.conf
 chmod 600/boot/grub/grub.conf
 chmod 600/etc/lilo.conf


To be added: 4. Modify the root umask value:/etc/ash.cssrc set to 027
5. For important directories, only root can read and write values. Execute the script
chmod -R 750/etc/rc.d/init.d/*
6. Find unauthorized suid and sgid files.
7. Check the directories and files that anyone has write permission.
10./etc/ssh/sshd_config.
Set PERmitRootLogin to no.
Modify ssh to use protocol version.

11. Check the opened service chkconfig --list and confirm with the administrator