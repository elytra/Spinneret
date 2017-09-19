#!/bin/bash
java -jar cmpdl.jar "https://minecraft.curseforge.com/projects/$1" latest | tee cmpdl.log
out=`grep 'Output Path: ' cmpdl.log | tail -n 1 | sed 's/Output Path: //'`
mv $out modpack
