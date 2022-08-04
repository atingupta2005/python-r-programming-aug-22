# Trainer Tasks

```
sudo apt -y update
sudo apt -y install openssl tree ranger zip wget unzip gcc
```

## Add Swap Space
- Create new Premium SSD and attach to the VM
- Increase main disk space of VM to 8 GB
- Follow: https://devconnected.com/how-to-add-swap-space-on-ubuntu-20-04/
- Run below commands:
```
sudo swapon --show
sudo fdisk -l
sudo fdisk /dev/sdc
	# Specify n command and create primary partition
	# Specify t command and use 82 code to change partition type to Swap
	# Specify w to write the changes
sudo mkswap /dev/sdc1
sudo swapon /dev/sdc1
sudo swapon --show
sudo blkid | grep "swap"
sudo nano /etc/fstab
	# UUID=<copied value>   none   swap  defaults   0   0
sudo reboot
sudo swapon --show
```

## Setup multiple users in Ubuntu
- For each participant, we need to setup login accounts
```
for ((i=1;i<=50;i++)); do
	export username="u$i"
	sudo useradd -m -p "p2" $username;sudo usermod -aG sudo $username;sudo echo $username:p | sudo /usr/sbin/chpasswd;sudo chown -R  $username:root /home/$username
done
```

- Customize linux prompt
```
cat ~/.bashrc
echo 'export PS1="\e[0;31m\e[50m\u@\h\n\w \e[m\n$ "'   >> ~/.bashrc
cat ~/.bashrc
exit
```

## Setup R Studio for Ubuntu
```
sudo apt -y update
sudo apt-get -y install r-base
```
```
sudo apt-get  -y install gdebi-core
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2021.09.0-351-amd64.deb
sudo gdebi rstudio-server-2021.09.0-351-amd64.deb
```
```
free -h
curl http://localhost:8787
```

## Install Jupyterhub
```
curl https://raw.githubusercontent.com/jupyterhub/the-littlest-jupyterhub/master/bootstrap/bootstrap.py | sudo -E python3 - --admin \atingupta2005
curl http://vmubuntu20.eastus2.cloudapp.azure.com/
```

##  Clone Git Repo
```
cd
git clone
cd
```
