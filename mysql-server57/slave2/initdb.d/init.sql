SET GLOBAL time_zone = 'Asia/Shanghai';
change master to master_host='mysql-57-master',
                 master_user='root',
                 master_password='MyMaster',
                 master_log_file='mysql-bin.000001';
start slave;
