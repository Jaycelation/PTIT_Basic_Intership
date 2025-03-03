# Phân tích log bằng grep 
## Cài đặt Apache Server
sudo apt install apache2 -y #Cài đặt
sudo systemctl start apache2 #Khởi động dịch vụ
sudo systemctl enable apache2 #Kích hoạt dịch vụ
sudo systemctl status apache2 #Kiểm tra trạng thái

## Quét cổng dịch vụ
sudo nmap -sS -sV -T4 192.168.127.136

## Curl
curl http://192.168.127.136 | grep test

## Đọc log Apache
cat /var/log/apache2/access.log

# Phân tích log bằng gawk
## Quét cổng dịch vụ 
sudo nmap -sS -sV -T4 192.168.127.136

## Tấn công vét cạn mật khẩu (File username, passwd
sudo hydra -L ptit_username.txt -P ptit_passwd.txt ssh://192.168.127.136 -t 4

## Thực hiện phiên ssh
ssh b22dcat251@192.168.127.136

## Đọc log hệ thống
cat /var/log/auth.log

## Phân tích log bằng grep, gawk
### Lọc theo đăng nhập thành công
grep "Accepted password" /var/log/auth.log | gawk '{print "User:", $7, "logged in from", $9, "at" $1}'

### Lọc theo người dùng được tạo
grep "useradd" /var/log/auth.log | gawk '{print "New user created:", $6, "at", $1}'

### Lọc theo lần thay đổi mật khẩu
grep "password changed" /var/log/auth.log | gawk '{print "Password changed for", $8, "at", $1 }'

## Lọc dữ liệu trên máy Attacker
### Lọc người dùng khả dụng
sudo cat /etc/passwd | grep /home

### Lọc người dùng vừa tạo
sudo cat /var/log/auth.log | grep "useradd" | gawk -F'[: ,=]+' '$0 ~ /new user/ {print "Thời gian:", $1, $2, $3, "| Tên User:", $10}'

### Lọc theo lần thay đổi mật khẩu
sudo cat /var/log/auth.log | grep "passwd" | grep "password changed" | awk '{print "Thời gian:", $1, $2, $3, "| Người dùng:", $NF}'

# Phân tích log bằng find
## Quét cổng dịch vụ 
nmap -F -sV 10.10.19.130

## Tấn công vét cạn mật khẩu
hydra -L ptit_username.txt -P ptit_passwd.txt ftp://10.10.19.130 ftp 10.10.19.130

## Đọc log FTP
type C:\inetpub\logs\LogFiles\u_ex250302.log

## Lọc theo trạng thái thành công (230), thất bại (530)
type u_ex250302.log | find "230"
type u_ex250302.log | find "530"




