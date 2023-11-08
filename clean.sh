#!/bin/bash

#set -e
echo "Starting cleaning..."

rm -rf chain/iconee
rm -rf data/gov
rm chain/iconee.log
rm data/ee.sock
rm data/cli.sock
rm data/auth.json
rm data/rconfig.json

rm -rf btp/data/*
rm -rf btp/logs/*

echo "Cleaned up..."