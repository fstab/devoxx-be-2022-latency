package de.fstab.demo;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import java.io.IOException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class LoadTest10 implements Runnable {

    private static final int N_THREADS = 10;

    private final OkHttpClient client = new OkHttpClient.Builder()
            .readTimeout(15, TimeUnit.SECONDS)
            .build();
    private final Request request = new Request.Builder().url("http://localhost:8080").build();

    @Override
    public void run() {
        while (true) {
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
    }

    public static void main(String[] args) throws IOException, InterruptedException {
        ExecutorService executor = Executors.newFixedThreadPool(N_THREADS);
        for (int i = 0; i < N_THREADS; i++) {
            executor.submit(new LoadTest10());
        }
        Thread.currentThread().join();
    }
}
