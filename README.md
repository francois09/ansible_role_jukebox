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
* Temporary set `PermitRootLogin yes` in `/etc/ssh/sshd_config` (and `systemctl restart sshd`) to allow the following commands

From root account (`ssh root@ip_address`)
* `passwd` : Change default password
* `usermod -l <YOUR DEFAULT USERNAME> pi` : Change defaut userid
* `groupmod -n <YOUR DEFAULT USERNAME> pi` : Change group name
* `mv /home/pi /home/<YOUR DEFAULT USERNAME>
* `usermod -d /home/<YOUR DEFAULT USERNAME> <YOUR DEFAULT USERNAME>` : Change defaut directory
* Update `/etc/sudoers.d/010_pi-nopasswd` (or create 010_<YOUR DEFAULT USERNAME>-nopasswd)

Warning!
--------

The role don't install Iris (pip3 install Mopidy-Iris) nor Local (same), and don't make the initial `mopidyctl local scan`

Role Variables
--------------

`jukebox__install` For install only (default: False)
`jukebox__configure` For configuration  (default: False)
`jukebox__headless` Don't install WindowManager  (default: False)
`jukebox__default_user`: Scripts install path and owner  (default: pi)
`jukebox__initial_volume`: Initial volume in percent of max (default: 50)
`jukebox__initial_tracks_count`: Initial random tracks loaded on playlist (default: 40)


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
