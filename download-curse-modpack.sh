#!/bin/bash
rm -rf modpack
java -jar cmpdl.jar "https://minecraft.curseforge.com/projects/$1" latest | tee cmpdl.log
out=`grep 'Output Path: ' cmpdl.log | tail -n 1 | sed 's/Output Path: //'`
mv "$out" modpack
mv modpack/minecraft modpack/src
mkdir -p modpack/loaders

mc_version=`grep 'IntendedVersion' modpack/instance.cfg  |cut -d= -f 2`
forge_version="$mc_version-`grep 'The Forge version you need is ' cmpdl.log |cut -d ' ' -f 7`"

curl -L https://files.minecraftforge.net/maven/net/minecraftforge/forge/$forge_version/forge-$forge_version-installer.jar -o modpack/loaders/forge-$forge_version-installer.jar
