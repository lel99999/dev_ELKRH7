# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.6.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'
  # config.vm.box = "base"
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "private_network", ip: "192.168.33.10"

  # config.ssh.forward_agent = true

  # config.vm.synced_folder "../data", "/vagrant_data"

  #
  config.vm.provider "docker" do |d|
    d.build_dir = "."
#   d.cmd = ["/sbin/init", "--enable-insecure-key"]
    d.has_ssh = true
  end
  config.ssh.port = 22
  config.vm.network :forwarded_port, guest: 22, host: 2522, auto_correct: false, id: "ssh"
  config.vm.network "forwarded_port", guest: 80, host: 8080
# config.ssh.username = "root"
# config.ssh.private_key_path = "./insecure_key"

  # config.vm.provision "puppet" do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end

  # config.vm.provision "chef_solo" do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # config.vm.provision "chef_client" do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end

