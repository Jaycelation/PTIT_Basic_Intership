import java.io.*;
import java.net.*;

public class Server {
    private static final String STUDENT_ID = "B22DCAT251";
    private static final String NAME = "Dang Duc Tai";
    private static final String HOST = "127.0.0.1";
    private static final int PORT = 65432;

    public static void main(String[] args) {
        try {
            ServerSocket serverSocket = new ServerSocket(PORT);
            System.out.println("Server is listening...");

            Socket conn = serverSocket.accept();
            System.out.println("Connected by " + conn.getInetAddress().getHostAddress());

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String data = in.readLine();
            System.out.println("Received from client: " + data);
            PrintWriter out = new PrintWriter(conn.getOutputStream(), true);
            String reply = "Hello, I am " + STUDENT_ID + " server";
            out.println(reply);
            in.close();
            out.close();
            conn.close();
            serverSocket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}