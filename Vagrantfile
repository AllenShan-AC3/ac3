# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.ssh.insert_key = false
  config.vm.box = "generic/rhel8"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.1.2"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.hostname = "ac3"
  config.vm.provider "vmware_desktop" do |vb|
    vb.vmx["memsize"] = "4096"
    vb.vmx["numvcpus"] = 4
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.synced_folder "~/.aws", "/home/vagrant/.aws"
  config.vm.synced_folder "shared", "/home/vagrant/shared"
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    
    # Subscribe to RHEL
    sudo subscription-manager register --username allen.shan --password Ziwen910627 --auto-attach
    
    # Update package cache
    sudo dnf -y update
    
    # Install AWS CDK
    sudo dnf -y install python39 unzip
    sudo dnf module install -y nodejs:16
    sudo alternatives --set python3 /usr/bin/python3.9
    sudo npm install -g aws-cdk

    # Install AWS CLI
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

    # Install VirutalEnv
    sudo pip3 install virtualenv

    # Install Docker Engine
    sudo dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
    sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo dnf update -y
    sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo systemctl start docker.service
    sudo systemctl enable docker.service
  SHELL

  config.trigger.before [:destroy] do |trigger|
    trigger.info = "Unsubscribe RHEL"
    trigger.run_remote = {inline: "sudo subscription-manager unregister || exit 0"}
  end
end
