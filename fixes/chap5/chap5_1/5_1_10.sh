sudo sed -i '/^\s*HostbasedAuthentication\b/d; /^\s*Include\b/i HostbasedAuthentication no' /etc/ssh/sshd_config