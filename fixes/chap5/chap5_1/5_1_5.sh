sudo sed -i '/^\s*#*\s*Banner\b/ { s/^#*\s*Banner\b.*/Banner \/etc\/issue.net/; t; s/^#*\s*$/Banner \/etc\/issue.net/; }' /etc/ssh/sshd_config