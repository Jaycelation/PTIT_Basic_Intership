import java.io.*;
import java.net.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Server_Secure {
    private static final String STUDENT_ID = "B22DCAT251";
    private static final String NAME = "Dang Duc Tai";
    private static final String HOST = "127.0.0.1";
    private static final int PORT = 65432;
    private static final String SECRET_KEY = "SecretKey123"; // Key

    // Hàm tạo giá trị băm SHA-256 từ chuỗi
    private static String calculateHash(String input) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(input.getBytes());
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }

    public static void main(String[] args) {
        try {
            ServerSocket serverSocket = new ServerSocket(PORT);
            System.out.println("Server is listening...");
            Socket conn = serverSocket.accept();
            System.out.println("Connected by " + conn.getInetAddress().getHostAddress());
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String data = in.readLine();
            String receivedHash = in.readLine();
            System.out.println("Received from client: " + data);
            System.out.println("Received hash: " + receivedHash);
            PrintWriter out = new PrintWriter(conn.getOutputStream(), true);
            String computedHash = calculateHash(data + SECRET_KEY);
            if (computedHash.equals(receivedHash)) {
                String reply = "Hello, I am " + STUDENT_ID + " server";
                out.println(reply);
                System.out.println("Sent: " + reply);
            } else {
                String errorMsg = "The received message has lost its integrity.";
                out.println(errorMsg);
                System.out.println("Sent: " + errorMsg);
            }
            in.close();
            out.close();
            conn.close();
            serverSocket.close();
        } catch (IOException | NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
    }
}