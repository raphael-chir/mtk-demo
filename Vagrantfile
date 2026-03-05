Vagrant.configure("2") do |config|

  # oracle to migrate
  config.vm.define "oracle" do |oracle|
    oracle.vm.box = "oraclelinux/8"
    oracle.vm.box_url = "https://oracle.github.io/vagrant-projects/boxes/oraclelinux/8.json"
    oracle.vm.hostname = "oracle-xe"
    oracle.vm.network "private_network", ip: "192.168.56.10"
    oracle.vm.provider ":libvirt" do |lv|
      lv.name    = "oracle-xe"
      lv.memory  = 4096
      lv.cpus    = 2
    end
    oracle.vm.provision "shell", path: "01-install-oracle.sh"
    oracle.vm.provision "shell", path: "02-setup-oracle-schema.sh"
    oracle.vm.provision "shell", path: "03-import-oracle-data.sh"
  end

  # oracle references by dblinks
  config.vm.define "oraref" do |oraref|
    oraref.vm.box = "oraclelinux/8"
    oraref.vm.box_url = "https://oracle.github.io/vagrant-projects/boxes/oraclelinux/8.json"
    oraref.vm.hostname = "oraref"
    oraref.vm.network "private_network", ip: "192.168.56.14"
    oraref.vm.provider ":libvirt" do |lv|
      lv.name    = "oraref"
      lv.memory  = 4096
      lv.cpus    = 2
    end
    oraref.vm.provision "shell", path: "01-install-oracle.sh"
    oraref.vm.provision "shell", path: "02-setup-oracle-schema.sh"
  end

  config.vm.define "mtkepas" do |epas|
    epas.vm.box = "generic/rocky9"
    epas.vm.hostname = "mtk-epas"
    epas.vm.network "private_network", ip: "192.168.56.12"
    epas.vm.provider ":libvirt" do |lv|
      lv.cpus = 2
      lv.memory = 2048
    end
    epas.vm.provision "shell", path: "04-install-managed-epas.sh"
    epas.vm.provision "shell", path: "05-install-mtk.sh"
  end

  # Shared folder
  config.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_udp: false
end
