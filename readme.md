### qBittorrent v4.3.0.1



Built-in rclone 21Vianet version

Inner upload script

[Upload script source](https://www.hostloc.com/thread-612238-1-1.html)

The loc boss is awesome!!

Run docker

```
docker run --name qbittorrent -d \
-p 6881:6881 \
-p 6881:6881/udp \
-p 8080:8080 \
-v /root/qbittorrent/config:/config \
-v /root/qbittorrent/downloads:/downloads \
-v /root/qbittorrent/upload:/upload \
--restart=always \
/benchao/qbittorrent-rclone:v1.4
```

The -v mapping address in docker can be modified by itself



qBittorrent v4.2.5

```
docker run --name qbittorrent -d \
-p 6881:6881 \
-p 6881:6881/udp \
-p 8080:8080 \
-v /root/qbittorrent/config:/config \
-v /root/qbittorrent/downloads:/downloads \
-v /root/qbittorrent/upload:/upload \
--restart=always \
/benchao/qbittorrent-rclone:v1.3
```



## rclone configuration

Create a new folder **rclone** under the config folder, and put your own **rclone.conf** configuration file



## Automatic upload file configuration

Edit the qb_auto.sh file in the upload folder! []()

```
the_dir="${save_dir//\/downloads\//}" #If you modify the main download address, please modify here

qb_version="4.3.0.1" #qb version
qb_username="admin" #qbUsername
qb_password="adminadmin" #qbPASSWORD
qb_web_url="http://localhost:8080" #qb's web address
leeching_mode="true" #Don't worry about this
log_dir="/config/log" #Log address to be printed
rclone_dest="yun" #The name of the rclone drive to be uploaded
rclone_parallel="32" #rclone upload thread
auto_del_flag="test" #Change the category name of the seed after the upload is complete
```

By default, the file is not deleted after uploading. If you need to delete it, delete all the # signs of **#qb_del** in sh



## qb command configuration

Settings **Run external program when Torrent is complete**

```shell
bash /upload/qb_auto.sh "%N" "%F" "%R" "%D" "%C" "%Z" "%I"
```





## Show results

![qb configuration](https://github.com/666wcy/qbittorent_rclone_upload/raw/main/qb.png)

![Upload log](https://github.com/666wcy/qbittorent_rclone_upload/raw/main/log.png)

![Upload content](https://github.com/666wcy/qbittorent_rclone_upload/raw/main/upload.png) 
More about this source text
Source text required for additional translation information
Send feedback
Side panels
