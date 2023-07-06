package com.test.spring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class HomeController {

    // 이 프로젝트의 최상위 경로 요청이 오면
    @RequestMapping("/")
    // 생성자에 임의로 객체를 선언할 수 있다.
    public String home(HttpServletRequest request) {

        return "home";
    }
    @RequestMapping("/test")
    public String test(){
        return "test";
    }

    @RequestMapping("/ttt")
    public String ttt(){
        return "ttt";
    }

    @RequestMapping("/footer")
    public String footer(){
        return "footer";
    }
}
