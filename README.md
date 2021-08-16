JukeBox Ansible role
====================

Role to manage install of jukebox appliance on a Raspberry PI.

Requirements
------------

Before you use the RaspberryPi, you need to do the following operations:

* `touch /boot/ssh` : Allow ssh activation on boot
* update `/etc/wpa_supplicant/wpa_supplicant.conf` file with:
```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=FR

network={
 scan_ssid=1
 ssid="<YOUR SSID>"
 psk="<YOUR SSID PASSWORD>"
}
```
* `echo 0 > /var/lib/systemd/rfkill/platform-3f300000.mmcnr:wlan`
* `echo 0 > /var/lib/systemd/rfkill/platform-fe300000.mmcnr:wlan`

From pi account (`ssh pi@ip_address`)
* `passwd` : Change default password

From root account (`sudo -i`, or `ssh root@ip_address`)
* `passwd` : Change default password
* `usermod -l <YOUR DEFAULT USERNAME> pi` : Change defaut userid
* `groupmod -n <YOUR DEFAULT USERNAME> pi` : Change group name
* `mv /home/pi /home/<YOUR DEFAULT USERNAME>

Role Variables
--------------

`jukebox__install` For install only (default: False)
`jukebox__configure` For configuration  (default: False)

Dependencies
------------

None

Example Playbooks
-----------------

License
-------

GPL v3

Author Information
------------------

François TOURDE
