package de.fstab.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldResource {

    @GetMapping("/")
    public String hello() throws InterruptedException {
        Thread.sleep(1000);
        return "Hello, world!\n";
    }
}
