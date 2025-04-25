import java.io.*;
import java.net.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Client_Secure {
    private static final String STUDENT_ID = "B22DCAT251";
    private static final String NAME = "Dang Duc Tai";
    private static final String HOST = "127.0.0.1";
    private static final int PORT = 65432;
    private static final String SECRET_KEY = "SecretKey123"; 

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
            Socket socket = new Socket(HOST, PORT);

            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            
            String message = "Hello, I am " + STUDENT_ID + " client.";
            String hash = calculateHash(message + SECRET_KEY);
            out.println(message);
            out.println(hash);
            System.out.println("Sent: " + message);
            System.out.println("Sent hash: " + hash);

            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            String data = in.readLine();
            System.out.println("Received from server: " + data);

            out.close();
            in.close();
            socket.close();
        } catch (IOException | NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
    }
}