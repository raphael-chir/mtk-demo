Vagrant.configure("2") do |config|

  # oracle
  config.vm.define "oracle" do |oracle|
    oracle.vm.box               = "oraclelinux/8"
    config.vm.box_url = "https://oracle.github.io/vagrant-projects/boxes/oraclelinux/8.json"

    oracle.vm.hostname          = "oracle-xe"
    oracle.vm.network "private_network", ip: "192.168.56.10"
    oracle.vm.provider :virtualbox do |vb|
      vb.name    = "oracle-xe"
      vb.memory  = 4096
      vb.cpus    = 2
    end
    oracle.vm.provision "shell", path: "01-install-oracle.sh"
    oracle.vm.provision "shell", path: "02-setup-oracle-schema.sh"
  end

  config.vm.define "mtkepas" do |epas|
    epas.vm.box = "generic/rocky9"
    epas.vm.hostname = "mtk-epas"
    epas.vm.network "private_network", ip: "192.168.56.12"
    epas.vm.provider "virtualbox" do |vb|
      vb.cpus = 2
      vb.memory = 2048
    end
    epas.vm.provision "shell", path: "03-install-managed-epas.sh"
    epas.vm.provision "shell", path: "04-install-mtk.sh"
  end

  # Shared folder
  config.vm.synced_folder ".", "/vagrant"
end
