package com.example.lfcFan.controller.usr;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping("/")
	public String showMain() {
		return "redirect:/usr/article/home";
	}
}
