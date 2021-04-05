package com.example.lfcFan.controller.usr;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.lfcFan.dto.Article;
import com.example.lfcFan.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;

	@RequestMapping("/usr/article/list")
	public String showMain(Model model) {
		return "usr/article/list";
	}

	@RequestMapping("/usr/article/home")
	public String showHome(Model model) {
		return "usr/article/home";
	}
	@RequestMapping("/usr/article/notice")
	public String showNotice(Model model) {
		List<Article> articles = articleService.getArticles();
		model.addAttribute("articles", articles);
		return "usr/article/notice";
	}
}
