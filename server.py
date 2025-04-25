import socket

student_id = "B22DCAT251"
name = "Dang Duc Tai"

HOST = '127.0.0.1'
PORT = 65432

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    print("Server is listening...")
    conn, addr = s.accept()
    with conn:
        print(f"Connected by {addr}")
        data = conn.recv(1024).decode()
        print(f"Received from client: {data}")
        reply = f"Hello, I am {student_id} server"
        conn.sendall(reply.encode())
