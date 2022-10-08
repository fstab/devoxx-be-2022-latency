package de.fstab.demo;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

public class LoadTestFinal implements Runnable {

    private static final int REQUESTS_PER_SECOND = 400;

    private final OkHttpClient client = new OkHttpClient.Builder()
            .readTimeout(30, TimeUnit.SECONDS)
            .build();
    private final Request request = new Request.Builder().url("http://localhost:8080").build();

    @Override
    public void run() {
        long start = System.nanoTime();
        try {
            Response response = client.newCall(request).execute();
            response.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            long duration = System.nanoTime() - start;
            System.out.printf("duration: %.3fs\n", duration / (double) TimeUnit.SECONDS.toNanos(1));
        }
    }

    public static void main(String[] args) throws InterruptedException {
        while (true) {
            Thread t = new Thread(new LoadTestFinal());
            t.setDaemon(true);
            t.start();
            Thread.sleep(TimeUnit.SECONDS.toMillis(1) / REQUESTS_PER_SECOND);
        }
    }
}
