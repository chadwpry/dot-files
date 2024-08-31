# https://apple.stackexchange.com/questions/287760/set-the-hostname-computer-name-for-macos

echo Update this file first!
exit

sudo scutil --set HostName <name>
sudo scutil --set LocalHostName <name>
sudo scutil --set ComputerName <name>

dscacheutil -flushcache
