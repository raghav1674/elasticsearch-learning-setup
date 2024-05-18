Vagrant.configure('2') do |config|
    config.ssh.username = "ec2-user"
    config.ssh.private_key_path = "~/.ssh/localec2"
    config.vm.synced_folder '.', '/vagrant', disabled: true
    config.vm.provision "file", source: "certs", destination: "/tmp/certs"
    config.vm.provision "file", source: "hosts", destination: "/tmp/hosts"
    config.vm.provision "file", source: "configs", destination: "/tmp/configs"


    (0..ENV['MASTER_NODE_COUNT'].to_i).each do |i|
        config.vm.define "master#{i}" do |master|
            master.vm.box = "localec2"
            master.vm.hostname = "#{ENV['VM_PREFIX']}master#{i}.example.local"
            master.vm.network "private_network",ip: "#{ENV['MASTER_NETWORK_RANGE']}#{i+4}"
            master.vm.provider "virtualbox" do |v|
                v.memory = 2048
                v.cpus = 2
            end
            master.vm.provision "shell", path: "scripts/elasticsearch.sh", args: "\'#{ENV['CLUSTER_NAME']}\' \'['master']\' \'#{ENV['MASTER_SEED_HOSTS']}\' \'#{ENV['BOOTSTRAP_PASSWORD']}\'"
        end 
    end

    (0..ENV['HOT_DATA_NODE_COUNT'].to_i).each do |i|
        config.vm.define "hot#{i}" do |hot|
            hot.vm.box = "localec2"
            hot.vm.hostname = "#{ENV['VM_PREFIX']}hot#{i}.example.local"
            hot.vm.network "private_network",ip: "#{ENV['HOT_DATA_NETWORK_RANGE']}#{i+4}"
            hot.vm.provider "virtualbox" do |v|
                v.memory = 2048
                v.cpus = 2
            end
            hot.vm.provision "shell", path: "scripts/elasticsearch.sh", args: "\'#{ENV['CLUSTER_NAME']}\' \'['data_content','data_hot','ingest','ml','remote_cluster_client','transform']\' \'#{ENV['MASTER_SEED_HOSTS']}\' \'#{ENV['BOOTSTRAP_PASSWORD']}\'"
        end
    end

    (0..ENV['WARM_DATA_NODE_COUNT'].to_i).each do |i|
        config.vm.define "warm#{i}" do |warm|
            warm.vm.box = "localec2"
            warm.vm.hostname = "#{ENV['VM_PREFIX']}warm#{i}.example.local"
            warm.vm.network "private_network",ip: "#{ENV['WARM_DATA_NETWORK_RANGE']}#{i+4}"
            warm.vm.provider "virtualbox" do |v|
                v.memory = 2048
                v.cpus = 2
            end
            warm.vm.provision "shell", path: "scripts/elasticsearch.sh", args: "\'#{ENV['CLUSTER_NAME']}\' \'['data_content','data_warm','data_cold','data_frozen,'ingest','ml','remote_cluster_client','transform']\' \'#{ENV['MASTER_SEED_HOSTS']}\' \'#{ENV['BOOTSTRAP_PASSWORD']}\'"
        end
    end

    config.vm.define "kibana" do |kibana|
        kibana.vm.box = "localec2"
        kibana.vm.hostname = "#{ENV['VM_PREFIX']}kibana.example.local"
        kibana.vm.network "private_network",ip: "#{ENV['KIBANA_NETWORK_RANGE']}4"
        kibana.vm.provider "virtualbox" do |v|
            v.memory = 2048
            v.cpus = 2
        end
      kibana.vm.provision "shell", path: "scripts/kibana.sh", args: "\'#{ENV['ELASTICSEARCH_HOSTS']}\' \'#{ENV['KIBANA_TOKEN']}\'"
    end 

    (0..ENV['MASTER_NODE_COUNT'].to_i).each do |i|
        config.vm.define "drmaster#{i}" do |master|
            master.vm.box = "localec2"
            master.vm.hostname = "#{ENV['VM_PREFIX']}master#{i}.example.local"
            master.vm.network "private_network",ip: "#{ENV['MASTER_NETWORK_RANGE']}#{i+4}"
            master.vm.provider "virtualbox" do |v|
                v.memory = 2048
                v.cpus = 2
            end
            master.vm.provision "shell", path: "scripts/elasticsearch.sh", args: "\'#{ENV['CLUSTER_NAME']}\' \'['master']\' \'#{ENV['MASTER_SEED_HOSTS']}\' \'#{ENV['BOOTSTRAP_PASSWORD']}\'"
        end 
    end

    (0..ENV['HOT_DATA_NODE_COUNT'].to_i).each do |i|
        config.vm.define "drhot#{i}" do |hot|
            hot.vm.box = "localec2"
            hot.vm.hostname = "#{ENV['VM_PREFIX']}hot#{i}.example.local"
            hot.vm.network "private_network",ip: "#{ENV['HOT_DATA_NETWORK_RANGE']}#{i+4}"
            hot.vm.provider "virtualbox" do |v|
                v.memory = 2048
                v.cpus = 2
            end
            hot.vm.provision "shell", path: "scripts/elasticsearch.sh", args: "\'#{ENV['CLUSTER_NAME']}\' \'['data_content','data_hot','ingest','ml','remote_cluster_client','transform']\' \'#{ENV['MASTER_SEED_HOSTS']}\' \'#{ENV['BOOTSTRAP_PASSWORD']}\'"
        end
    end

    (0..ENV['WARM_DATA_NODE_COUNT'].to_i).each do |i|
        config.vm.define "drwarm#{i}" do |warm|
            warm.vm.box = "localec2"
            warm.vm.hostname = "#{ENV['VM_PREFIX']}warm#{i}.example.local"
            warm.vm.network "private_network",ip: "#{ENV['WARM_DATA_NETWORK_RANGE']}#{i+4}"
            warm.vm.provider "virtualbox" do |v|
                v.memory = 2048
                v.cpus = 2
            end
            warm.vm.provision "shell", path: "scripts/elasticsearch.sh", args: "\'#{ENV['CLUSTER_NAME']}\' \'['data_content','data_warm','data_cold','data_frozen,'ingest','ml','remote_cluster_client','transform']\' \'#{ENV['MASTER_SEED_HOSTS']}\' \'#{ENV['BOOTSTRAP_PASSWORD']}\'"
        end
    end

    config.vm.define "drkibana" do |kibana|
        kibana.vm.box = "localec2"
        kibana.vm.hostname = "#{ENV['VM_PREFIX']}kibana.example.local"
        kibana.vm.network "private_network",ip: "#{ENV['KIBANA_NETWORK_RANGE']}4"
        kibana.vm.provider "virtualbox" do |v|
            v.memory = 2048
            v.cpus = 2
        end
      kibana.vm.provision "shell", path: "scripts/kibana.sh", args: "\'#{ENV['ELASTICSEARCH_HOSTS']}\' \'#{ENV['KIBANA_TOKEN']}\'"
    end 

    config.vm.define "dcmetricbeat" do |metricbeat|
        metricbeat.vm.box = "localec2"
        metricbeat.vm.hostname = "#{ENV['VM_PREFIX']}metricbeat.example.local"
        metricbeat.vm.network "private_network",ip: "#{ENV['METRICBEAT_NETWORK_RANGE']}4"
        metricbeat.vm.provider "virtualbox" do |v|
            v.memory = 1024
            v.cpus = 1
        end
      metricbeat.vm.provision "shell", path: "scripts/metricbeat.sh"
    end

end

