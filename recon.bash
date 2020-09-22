#!/bin/bash
echo "" > target.txt
timeout 120 netdiscover -PN > hosts.txt
