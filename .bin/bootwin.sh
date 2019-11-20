# ******************************************************************
# Reboot directly to windows 
#   Inspired by 
# http://askubuntu.com/questions/18170/how-to-reboot-into-windows-from-ubuntu and
# https://unix.stackexchange.com/questions/43196/how-can-i-tell-grub-i-want-to-reboot-into-windows-before-i-reboot/112284
# ******************************************************************
WINDOWS_TITLE=`sudo grep -i 'windows' /boot/grub/grub.cfg|cut -d"'" -f2`
sudo grub-reboot "$WINDOWS_TITLE"
sudo reboot
