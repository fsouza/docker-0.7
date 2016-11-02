Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/precise64"
  config.vm.provision "shell", path: "setup.sh"

  config.vm.provider "virtualbox" do |v|
    v.memory = 3072
    v.cpus = 2
  end
end
