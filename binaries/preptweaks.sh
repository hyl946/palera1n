mount -uw /
mount -uw /private/preboot
nvram auto-boot=false
mkdir /work
cd /work
echo "Downloading bootstrap"
curl -sLO https://cdn.discordapp.com/attachments/1017153024768081921/1026161261077090365/bootstrap-ssh.tar
echo "Downloading libswift"
curl -sLO https://github.com/coolstar/Odyssey-bootstrap/raw/master/org.swift.libswift_5.0-electra2_iphoneos-arm.deb
echo "Downloading Substitute"
curl -sLO https://cdn.discordapp.com/attachments/688126487588634630/1026673680387936256/com.ex.substitute_2.3.1_iphoneos-arm.deb
echo "Downloading Substrate Safe mode"
curl -sLO https://apt.bingner.com/debs/1443.00/com.saurik.substrate.safemode_0.9.6005_iphoneos-arm.deb
echo "Bootstrapping"
tar -xpf bootstrap-ssh.tar -C / --overwrite
/prep_bootstrap.sh
launchctl unload /Library/LaunchDaemons/com.openssh.sshd.plist & launchctl load /Library/LaunchDaemons/com.openssh.sshd.plist
launchctl bootstrap system /Library/LaunchDaemons
uicache -u /var/jb/Applications/Sileo.app
rm -rf /var/jb
rm -rf /private/preboot/$(cat /private/preboot/active)/procursus
apt update
apt upgrade -y
echo "Installing Sileo"
apt install org.coolstar.sileo
dpkg -i *.deb
cd ..
rm -rf /work
