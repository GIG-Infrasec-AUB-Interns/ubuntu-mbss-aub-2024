client_alive_interval="ClientAliveInterval 15"
client_alive_count_max="ClientAliveCountMax 3"


sudo sed -i "s/^\s*ClientAliveInterval\b.*/$client_alive_interval/" /etc/ssh/sshd_config
sudo sed -i "s/^\s*ClientAliveCountMax\b.*/$client_alive_count_max/" /etc/ssh/sshd_config