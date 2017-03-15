docker build --rm -t local/centos7 .
docker create --name phantom local/centos7
docker start phantom

sleep 5

docker cp phantom:/tmp/fontconfig fontconfig
docker cp phantom:/tmp/phantomjs-prebuilt phantomjs

docker rm -f phantom
docker rmi local/centos7

cp fonts.conf fontconfig/etc/fonts/fonts.conf
zip -r screenshot.zip index.js phantom-script.js phantomjs fontconfig
rm -rf fontconfig phantomjs
