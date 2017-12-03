#!/bin/bash -e
if [ -z "$1" ]; then
	echo must specify output path
	exit 1
fi
if [ -e "$1/server.pid" ]; then
	echo Waiting for server to stop...
	pid=`cat "$1/server.pid"`
	tail --pid=$pid -f /dev/null
fi
mkdir -p "$1"
rm -rf "$1/mods" "$1/config" "$1/oresources" "$1/scripts"
java -cp skcraft.jar com.skcraft.launcher.builder.ServerCopyExport --source skcraft-modpack/src --dest "$1"
installer=`readlink -f skcraft-modpack/loaders/forge-*`
cd "$1"
rm -f minecraft_server*.jar
rm -f forge-*-universal.jar
java -jar "$installer" -installServer
rm forge-*.log
unlink server.jar
ln -s forge-*-universal.jar server.jar
rm -f mods/mod_list.json
echo 'eula=true' > eula.txt
cat > server.sh <<'EOF'
#!/bin/bash
function rmpid() {
	rm server.pid
}
trap rmpid EXIT
java -Xms2G -Xmx2G -jar server.jar nogui "$@" &
echo $! > server.pid
wait
EOF
