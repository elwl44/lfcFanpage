package com.example.lfcFan.controller.usr;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.lfcFan.dto.Article;
import com.example.lfcFan.dto.GenFile;
import com.example.lfcFan.service.GenFileService;
import com.example.lfcFan.service.HomeService;

@Controller
public class HomeController {
	@Autowired
	private GenFileService genFileService;
	
	@Autowired
	private HomeService homeService;
	
	@RequestMapping("/")
	public String showMain() {
		return "redirect:/usr/article/home";
	}
	
	@RequestMapping("/usr/article/home")
	public String showHome(Model model) {
		/*뉴스 4개*/
		List<Article> articles = homeService.getForPrintnews();

		for (Article article : articles) {
			GenFile genFile = genFileService.getGenFile("article", article.getId(), "common", "attachment", 1);

			if (genFile != null) {
				article.setExtra__thumbImg(genFile.getForPrintUrl());
			}
		}
		model.addAttribute("articles", articles);
		return "usr/article/home";
	}
}
