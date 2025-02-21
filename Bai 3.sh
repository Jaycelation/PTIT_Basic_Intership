# Cài đặt Choco (Trên Windows PS)
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Cài đặt PuTTy bằng PS (Trên Windows PS)
choco install putty -y


# Cấu hình Samba
## Cài đặt Samba
sudo apt install samba -y
## Tài khoản User
sudo mkdir -p /home/TaiDDB22AT251/share
sudo chown TaiDDB22AT251:TaiDDB22AT251 /home/TaiDDB22AT251/share
sudo chmod 770 /home/TaiDDB22AT251/share
## Tài khoản admin
sudo mkdir -p /home/admin/share
sudo chown admin:admin /home/admin/share
sudo chmod 770 /home/admin/share

## File config
sudo tee -a /etc/samba/smb.conf > /dev/null <<EOF

[TaiDDB22AT251]
 path = /home/TaiDDB22AT251/share
 valid users = TaiDDB22AT251
 read only = no
 browsable = yes
 create mask = 0770
 directory mask = 0770

[admin]
 path = /home/admin/share
 valid users = admin
 read only = no
 browsable = yes
 create mask = 0770
 directory mask = 0770
EOF

## Khởi động lại dịch vụ Samba
sudo systemctl restart smbd
sudo systemctl restart nmbd

# Cấu hình SELinux
sudo apt install selinux-basics selinux-policy-default auditd -y
## Active & Reboot
sudo selinux-activate
sudo reboot

## Cấu hình FTP vào SELinux
sudo apt install policycoreutils -y
sudo semanage port -a -t ftp_port_t -p tcp 992

