#!/bin/bash
tee /usr/local/bin/proxy <<EOF
#!/bin/bash
http_proxy=http://192.168.1.120:8123 https_proxy=http://192.168.1.120:8123 \$*
EOF

chmod +x /usr/local/bin/proxy

yum update -y
yum install tmux wget lrzsz vim net-tools zsh bind-utils git -y

