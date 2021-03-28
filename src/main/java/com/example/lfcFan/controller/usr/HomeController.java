package com.example.lfcFan.controller.usr;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@ResponseBody
public class HomeController {
	@RequestMapping("/usr/home/main")
	public String showMain() {
		return "프로젝트 시작";
	}
}
