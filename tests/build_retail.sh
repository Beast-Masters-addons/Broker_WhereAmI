#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
python3 $SCRIPT_DIR/build_utils/utils/parse_toc.py $SCRIPT_DIR/../Broker_WhereAmI.toc