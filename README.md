# Remote Monitoring

Remote monitoring using Ngrok, Pipedream and Discord

Add your Ngrok token and Pipedream-Discord webhook

```shell
# Required Auth token and Webhook
NGROK_AUTH_TOKEN="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
DISCORD_WEBHOOK="https://xxxxxxxxxxxxxxx.m.pipedream.net"
```

Add your local servers you want to monitor remotely

```shell
# Ngrok config file
cat <<-YAML > /tmp/ngrok.yml
authtoken: $NGROK_AUTH_TOKEN
tunnels:
  server1:
    addr: 192.168.0.x:80
    proto: http
  server2:
    addr: 192.168.0.x:80
    proto: http
YAML
```

Start your script `sudo sh remote.sh` and it should send a notification with Ngrok urls to your discord server.
