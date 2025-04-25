import java.io.*;
import java.net.*;

public class Client {
    private static final String STUDENT_ID = "B22DCAT251";
    private static final String NAME = "Dang Duc Tai";
    private static final String HOST = "127.0.0.1";
    private static final int PORT = 65432;

    public static void main(String[] args) {
        try {
            Socket socket = new Socket(HOST, PORT);
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            String message = "Hello, I am " + STUDENT_ID + " client.";
            out.println(message);
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            String data = in.readLine();
            System.out.println("Received from server: " + data);
            out.close();
            in.close();
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}