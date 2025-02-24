# Cài đặt PSTools
choco install pstools -y
# Bật các mục trong Network discovery trên Windows và Server (Windows PS với quyền Admin)
Set-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled True -Profile Domain,Private,Public
# Kết nối bằng PSTools tới Server
PsExec.exe -i \\IP_SERVER -u administrator -p PASSWD cmd