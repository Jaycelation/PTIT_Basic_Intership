import socket

student_id = "B22DCAT251"
name = "Dang Duc Tai"

HOST = '127.0.0.1'
PORT = 65432

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((HOST, PORT))
    message = f"Hello, I am {student_id} client."
    s.sendall(message.encode())
    data = s.recv(1024).decode()
    print(f"Received from server: {data}")
