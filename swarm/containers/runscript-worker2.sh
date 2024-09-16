docker container run -dit --cgroupns=host -v /sys/fs/cgroup/:/sys/fs/cgroup --cap-add SYS_ADMIN -p 81:80  --tmpfs /tmp:exec --tmpfs /run/:exec --network ansiblenetwork --ip 192.168.60.12  --name swarm-worker2 dockercommit/dipayandutta:rocky-systemd-ansibleclient-1

