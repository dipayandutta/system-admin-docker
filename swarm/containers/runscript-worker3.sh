docker container run -dit --cgroupns=host -v /sys/fs/cgroup/:/sys/fs/cgroup --cap-add SYS_ADMIN -p 3000:3000  --tmpfs /tmp:exec --tmpfs /run/:exec --network ansiblenetwork --ip 192.168.60.13  --name swarm-worker3 dockercommit/dipayandutta:rocky-systemd-ansibleclient-1

