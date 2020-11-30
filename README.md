# Simple Minecraft Personal Server Enviroment

## Setup infrastructure

1. Change directory to env/prd or env/stg.
1. Edit main.tf(as proprietly).
1. Copy ssh public key(e.g id_rsa.pub) to prd or stg folder.
1. Execute terraform commands
1. `terraform init`
1. `terraform apply`

## Setup application

1. Check elastic ip

```
aws ec2 describe-instances --region=ap-south-1 | grep PublicIpAddress
```

2. Connect to elastic ip with private key

```
ssh -i path/to/private/key ec2-user@<elasticip>
```

3. After login EC2, get to be superuser

```
sudo su
```

4. Update enviroment

```
yum update -y
```

5. Install openjdk 8

```
yum -y install java-1.8.0-openjdk-devel.x86_64
```

6. Download server program from [here](https://www.minecraft.net/en-us/download/server)

```
wget https://launcher.mojang.com/v1/objects/f02f4473dbf152c23d7d484952121db0b36698cb/server.jar
```

7. Initialize server program

```
java -Xms1G -Xmx1G -jar server.jar --nogui
```

8. After "eura.txt" created, open it with text editor and change `eula=false` to `eula=true`
9. create boot script (e.g. `touch start.sh`) with executable permission settings

```
#!/bin/sh
cd "$(dirname "$0")"
nohup exec java -Xms1G -Xmx1G -jar server.jar --nogui &
```

### Auto Restart process(\*Optional)

1. Edit `start.sh`

```
#!/bin/bash
cd /usr/local/bin/minecraft # change path to server.jar

# check process count
PCOUNT=$(ps -ef | grep "server.jar --nogui" | grep -v "grep" | wc -l)

# start process if it's not started
if [ "$PCOUNT" -lt 1 ]; then
  nohup java -Xms1G -Xmx1G -jar server.jar --nogui & 2>>error.log
fi
```

2. Set crontab with interval time

```
# minecraft process checker
*/15 * * * * /home/ec2-user/minecraftserver.sh
```
