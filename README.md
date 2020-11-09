# Simple Minecraft Personal Server Enviroment

## Setup infrastructure

1. Change directory to env/prd or env/stg.
1. Edit main.tf(as proprietly).
1. Copy ssh public key(e.g id_rsa.pub) to prd or stg folder.
1. Execute terraform commands
1. `terraform init`
1. `terraform apply`

## Setup minecraft server

1. Connect to elastic ip with private key `"ssh -i path/to/private/key ec2-user@elasticip"`
1. After login EC2, get to be superuser `sudo su`
1. `yum update -y`
1. `yum -y install java-1.8.0-openjdk-devel.x86_64 `
1. `wget https://launcher.mojang.com/v1/objects/f02f4473dbf152c23d7d484952121db0b36698cb/server.jar`
1. `java -Xms1G -Xmx1G -jar minecraft_server.1.16.3.jar --nogui`
1. open "eura.txt" with text editor and change `eula=false` to `eula=true` .
1. create boot script (`vi start.sh`) and change permission to executable

```
#!/bin/sh
cd "$(dirname "$0")"
exec java -Xms1G -Xmx1G -jar server.jar --nogui
```

9. execute boot script with nohup command like

```
nohup sh start.sh &
```
