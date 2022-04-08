# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.6.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

# ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'
  # config.vm.box = "base"
    config.vm.box = "clouddood/RH7.5_baserepo"
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "private_network", ip: "192.168.33.10"

  # config.ssh.forward_agent = true

  # config.vm.synced_folder "../data", "/vagrant_data"

  #
# config.vm.provider "docker" do |d|
#   d.build_dir = "."
#   d.cmd = ["/sbin/init", "--enable-insecure-key"]
#   d.has_ssh = true
# end
  config.ssh.port = 22
  config.vm.network :forwarded_port, guest: 22, host: 2522, auto_correct: false, id: "ssh"
  config.vm.network "forwarded_port", guest: 80, host: 8080
# config.ssh.username = "root"
# config.ssh.private_key_path = "./insecure_key"

  # Kibana Client Node
  config.vm.define "elk" do |elk_config|
#   elk_config.vm.box = "bento/centos-6.10"
    elk_config.vm.box = "clouddood/RH7.5_baserepo"
    elk_config.vm.host_name = "elk.test.dev"
    elk_config.ssh.forward_agent = true

    elk_config.vm.provision :shell,
      :inline => "sudo echo '10.0.1.16  elk.test.dev' >> /etc/hosts"

    elk_config.vm.provision "ansible" do |ansible|
      ansible.playbook = "deploy_elk.yml"
      ansible.inventory_path = "vagrant_hosts"
#     ansible.tags = ansible_tags
#     ansible.verbose = ansible_verbosity
#     ansible.extra_vars = ansible_extra_vars
#     ansible.limit = ansible_limit
    end

    elk_config.vm.network :private_network, ip: "10.0.1.16"
  end

  # Elastic Search Cluster
  (1..3).each do |i|
    config.vm.define "es#{i}" do |es_config|
#     es_config.vm.box = "bento/centos-6.10"
      es_config.vm.box = "clouddood/RH7.5_baserepo"
      es_config.vm.host_name = "es#{i}.test.dev"
      es_config.ssh.forward_agent = true

      es_config.vm.provision :shell,
        :inline => "sudo echo '10.0.1.16  elk.test.dev' >> /etc/hosts"

      es_config.vm.provision "ansible" do |ansible|
        ansible.playbook = "deploy_elastic_search.yml"
        ansible.inventory_path = "vagrant_hosts"
#       ansible.tags = ansible_tags
#       ansible.verbose = ansible_verbosity
#       ansible.extra_vars = ansible_extra_vars
#       ansible.limit = ansible_limit
      end

      es_config.vm.network :private_network, ip: "10.0.1.#{i+12}"
    end
  end

end

