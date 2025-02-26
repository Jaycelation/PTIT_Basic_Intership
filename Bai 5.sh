# Internal Network (192.168.127.0/24): Windows 10 (.10), Ubuntu (.132), Kali Linux (.129), Windows Server 2019 (.99)
# Sao lưu ổ đĩa mạng
## Tạo thư mục sao lưu (Windows 10)
mkdir C:\share
### Kiểm tra thư mục sao lưu
net share
## Cấu hình map ổ đĩa (Windows Server)
net use Z: \\192.168.127.10\share /user:USERNAME PASSWD
### Kiểm tra kết nối
net use 
## Cấu hình thư mục cho phép sao lưu (Windows 10)
icacls C:\share /grant Everyone:F
### Kiểm tra thư mục sao lưu
dir \\192.168.127.10\share 
## Cài đặt Windows Server Backup(WSB) (Windows Server)
Install-WindowsFeature -Name Windows-Server-Backup #Windows PS với quyền Admin
## Tiến hành sao lưu
wbadmin start backup -backupTarget:\\192.168.127.10\share -include:C:\Users -quiet

# Sao lưu tệp lên FTP
## Cài đặt FTP Client (Windows 10)
Enable-WindowsOptionalFeature -Online -FeatureName "TFTP-Client"
## Cài đặt FTP (Kali Linux)
sudo apt install vsftpd -y
## Config file FTP Server
sudo nano /etc/vsftpd.conf 
## Bật các dòng sau
anonymous_enable=NO
local_enable=YES
write_enable=YES
## Restart vsftpd
sudo systemctl restart vsftpd
## Tạo thư mục backup & cấp quyền
sudo mkdir -p /backup
sudo chmod 777 /backup
## Chạy file ftp 
ftp -s:PATH_TO_SCRIPT_FILE

# Sao lưu sử dụng SCP
## Cài đặt
sudo apt install openssh-server -y
sudo systemctl enable ssh
sudo systemctl start ssh
## Tạo key
ssh-keygen -t rsa -b 4096 -C "Dang Duc Tai B22DCAT251" 
## Chia sẻ key
ssh-copy-id -i ~/.ssh/id_rsa.pub b22dcat251@192.168.127.132
## Sao lưu (Ubuntu)
scp -r backup/ jayce@192.168.127.129:/backup

