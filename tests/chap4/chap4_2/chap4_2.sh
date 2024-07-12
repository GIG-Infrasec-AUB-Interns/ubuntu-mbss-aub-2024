# 4.2 Configure nftables
nft -f /etc/nftables.rules
nft list ruleset > /etc/nftables.rules
sudo sh -c 'echo "include \"/etc/nftables.rules\"" >> /etc/nftables.conf'