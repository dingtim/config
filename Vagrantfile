Vagrant.configure("2") do |config|
    (1..2).each do |i|
        config.vm.define "docker#{i}" do |docker|
        # 设置虚拟机的Box
        docker.vm.box = "centos/7"
        # 设置虚拟机的主机名
        docker.vm.hostname="docker#{i}.node"
        # 设置虚拟机的IP
        docker.vm.network "public_network", ip: "192.168.1.1#{i}", bridge: "wlp2s0"
        # 设置主机与虚拟机的共享目录
        #docker.vm.synced_folder "~/Desktop/share", "/home/vagrant/share"
        # 自定义执行脚本
        docker.vm.provision "shell", path: "init.sh"
        # 检查 box 更新
        #docker.vm.box_check_update = true
        # VirtaulBox相关配置
        docker.vm.provider "virtualbox" do |v|
            # 设置虚拟机的名称
            v.name = "docker#{i}"
            # 设置虚拟机的内存大小  
            v.memory = 1024
            # 设置虚拟机的CPU个数
            v.cpus = 1
            # 增加磁盘
            docker_disk = "/data/vm/disk/docker-disk#{i}.vdi"
            #data_disk = "/data/vm/disk/data-disk#{i}.vdi"
            v.customize [
                'storagectl', :id,
                '--name', 'SATA Controller',
                '--add', 'sata',
                '--portcount', '5',
                '--controller', 'IntelAhci',
                '--bootable', 'on'
            ]
            if ARGV[0] == "up" && ! File.exist?(docker_disk) 
                v.customize [
                    'createhd', 
                    '--filename', docker_disk, 
                    '--format', 'VDI', 
                    '--size', 100000 * 1024 # 10 GB
                ] 
                v.customize [
                    'storageattach', :id, 
                    '--storagectl', 'SATA Controller', 
                    '--port', 1, '--device', 0, 
                    '--type', 'hdd', '--medium', 
                    docker_disk
                ]
            end 
            #if ARGV[0] == "up" && ! File.exist?(data_disk) 
            #    v.customize [
            #        'createhd', 
            #        '--filename', docker_disk, 
            #        '--format', 'VDI', 
            #        '--size', 100000 * 1024 # 10 GB
            #    ] 
            #    v.customize [
            #        'storageattach', :id, 
            #        '--storagectl', 'SATA Controller', 
            #        '--port', 1, '--device', 0, 
            #        '--type', 'hdd', '--medium', 
            #        data_disk
            #    ]
            #end 
        end
        # 使用shell脚本进行软件安装和配置
        docker.vm.provision "shell", inline: <<-SHELL
            systemctl restart network
            systemctl restart sshd
            echo -e "\033[32mvirtual machine docker#{i} init success!\033[0m"
        SHELL
        end
    end
end
