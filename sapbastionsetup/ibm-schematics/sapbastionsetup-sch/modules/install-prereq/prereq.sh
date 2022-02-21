#!/bin/bash
###########

# Updating OS
sudo dnf update -y;
# Installing basic needed packages
sudo dnf install --nogpgcheck -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm;
sudo dnf install -y python3 ansible wget unzip git screen crudini dos2unix nc;

# Preparing FS
echo -e "\nPreparing FS"
sudo sgdisk -n 0:0:0 /dev/vdd
sudo mkfs.xfs /dev/vdd1
sudo mkdir /storage
sudo echo "/dev/vdd1       /storage       xfs     defaults        0       0" >> /etc/fstab
sudo mount -a
echo -e "\nListing block devices:"
sudo lsblk;
echo -e "\nChecking the mount sizes:"
sudo df -h;

# Installing IBM CLI
echo -e "\nInstalling IBM CLI plugins and needed packages"
sudo dnf  install jq perl-JSON-PP -y
curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
ibmcloud plugin install vpc-infrastructure
ibmcloud plugin update
ibmcloud -v

# Installing Terraform
echo -e "\nInstalling Terraform"
wget https://releases.hashicorp.com/terraform/1.0.3/terraform_1.0.3_linux_amd64.zip -P /tmp/
unzip /tmp/terraform_1.0.3_linux_amd64.zip -d /usr/local/bin
terraform -v

# Preparing Ansible
echo -e "\nSetting ANSIBLE_HOST_KEY_CHECKING to False"
echo "export ANSIBLE_HOST_KEY_CHECKING=False" >> ~/.bash_profile
crudini --set --format=lines /etc/ansible/ansible.cfg defaults host_key_checking False
crudini --set --format=lines /etc/ansible/ansible.cfg ssh_connection ssh_args "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
crudini --set --format=lines /etc/ansible/ansible.cfg defaults log_path /var/log/ansible.log
crudini --set --format=lines /etc/ansible/ansible.cfg  ssh_connection transfer_method smart

# Adding Storage user
mkdir /storage/.ssh && cp .ssh/authorized_keys /storage/.ssh/
sudo useradd -c "Storage sftp user" storage -d /storage -M -s "/bin/bash"; sudo chown storage -R /storage
chown storage -R /storage/

# Configuring SSH Server
echo "AllowTcpForwarding yes
ClientAliveInterval 1200
ClientAliveCountMax 10
TCPKeepAlive yes" >> /etc/ssh/sshd_config
sudo service sshd reload
