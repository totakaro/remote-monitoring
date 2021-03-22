#!/bin/sh

# Remote monitoring using Ngrok, Pipedream and Discord
# By @totakaro 2021
# MIT License

# Required Auth token and Webhook
NGROK_AUTH_TOKEN="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
DISCORD_WEBHOOK="https://xxxxxxxxxxxxxxxxxx.m.pipedream.net"

# Ngrok config file
cat <<-YAML > /tmp/ngrok.yml
authtoken: $NGROK_AUTH_TOKEN
tunnels:
  server1:
    addr: 192.168.0.6:80
    proto: http
  server2:
    addr: 192.168.0.2:80
    proto: http
YAML

# Get Ngrok and run it
curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > ngrok-stable-linux-amd64.zip
unzip -o ngrok-stable-linux-amd64.zip
./ngrok authtoken $NGROK_AUTH_TOKEN
./ngrok start -config /tmp/ngrok.yml server1 server2 > /dev/null&
sleep 1

# Send new Ngrok url to Discord using Pipedream
# https://stackoverflow.com/a/45222497
URLS=`curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[].public_url | select(contains("https"))'`
curl -s -d "\"`date`:\n$URLS\"" -H "Content-Type: text/plain" $DISCORD_WEBHOOK > /dev/null
