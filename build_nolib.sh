#!/usr/bin/env bash
python3 files/yaml_merge.py
curl -s https://raw.githubusercontent.com/BigWigsMods/packager/master/release.sh | bash -s -- -g ${GAME_VERSION:-retail} -d -s