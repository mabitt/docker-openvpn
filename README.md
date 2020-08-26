docker-openvpn
--------------
This container runs OpenVPN.

Running manually
----------------
    docker build -t mabitt/openvpn .
    docker run -d --name openvpn --privileged -p 1194:1194 -p 1194:1194/udp -v /srv/openvpn:/data mabitt/openvpn

Running with systemd
-----------------------
```
[Unit]
Description=openvpn
After=docker.service
After=etcd.service
Requires=docker.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker pull mabitt/openvpn
ExecStartPre=-/usr/bin/docker stop openvpn
ExecStartPre=-/usr/bin/docker kill openvpn
ExecStartPre=-/usr/bin/docker rm openvpn
ExecStart=/usr/bin/sudo docker run --name openvpn --privileged -p 1194:1194 -p 1194:1194/udp -v /srv/openvpn:/data mabitt/openvpn
ExecStop=/usr/bin/docker stop openvpn
Restart=always
RestartSec=10s

[Install]
WantedBy=multi-user.target
```

OpenVPN configuration
-------------------------
Configurations files and certificates are created at:
> $DATADIR/conf
