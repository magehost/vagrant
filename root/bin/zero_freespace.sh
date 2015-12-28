#!/bin/bash
echo ""
echo "####  Writing zero file till no space left..."
echo ""
dd if=/dev/zero of=ZEROFILE bs=64K count=9999999999999999999
ls -lah ZEROFILE
echo ""
echo "####  Removing zero file..."
echo ""
rm ZEROFILE
df -h
echo ""
echo "####  Done."
echo ""
