#cloud-config
package_update: true
packages:
  - nftables

ssh_pwauth: false
disable_root: true

write_files:
  - path: /etc/ssh/sshd_config.d/99-hardening.conf
    permissions: "0644"
    owner: root:root
    content: |
      PermitRootLogin no
      PasswordAuthentication no
      KbdInteractiveAuthentication no
      ChallengeResponseAuthentication no
      PubkeyAuthentication yes
      X11Forwarding no

  - path: /etc/nftables.conf
    permissions: "0644"
    owner: root:root
    content: |
      # Managed by cloud-init
      flush ruleset

      table inet filter {
        chain input {
          type filter hook input priority 0;
          policy drop;

          iif "lo" accept
          ct state established,related accept

          tcp dport {22, 80, 443} accept

          ip protocol icmp accept
          ip6 nexthdr ipv6-icmp accept
        }

        chain forward {
          type filter hook forward priority 0;
          policy drop;
        }

        chain output {
          type filter hook output priority 0;
          policy accept;
        }
      }

runcmd:
  - systemctl enable nftables
  - systemctl restart nftables
  - systemctl restart ssh
  - echo 'OCI Ampere A1 Ubuntu baseline with SSH hardening + nftables.' >> /etc/motd
