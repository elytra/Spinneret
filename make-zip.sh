#!/bin/bash
mkdir out
cd modpack/src
zip -r9 "../../out/$JOB_BASE_NAME.zip" *
