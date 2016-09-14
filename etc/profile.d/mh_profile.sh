#!/usr/bin/env bash

force_color_prompt=1

# Temp dir
export TMP=$HOME/tmp
export TMPDIR=$HOME/tmp
export TEMP=$HOME/tmp
/bin/mkdir -m700 -p $TMPDIR

# No core dumps
ulimit -c 0
