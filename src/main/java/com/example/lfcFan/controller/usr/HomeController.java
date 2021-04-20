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
		List<Article> newsArticles = homeService.getForPrintnews();

		for (Article article : newsArticles) {
			GenFile genFile = genFileService.getGenFile("article", article.getId(), "common", "attachment", 1);

			if (genFile != null) {
				article.setExtra__thumbImg(genFile.getForPrintUrl());
			}
		}
		
		/*공지게시판 5개*/
		List<Article> noticeArticles = homeService.getForPrintnotice();
		for (Article article : noticeArticles) {
			GenFile genFile = genFileService.getGenFile("article", article.getId(), "common", "attachment", 1);

			if (genFile != null) {
				article.setExtra__thumbImg(genFile.getForPrintUrl());
			}
		}
		homeService.formatTimeString(noticeArticles);
		
		/*축구게시판 5개*/
		List<Article> soccerArticles = homeService.getForPrintsoccer();
		for (Article article : soccerArticles) {
			GenFile genFile = genFileService.getGenFile("article", article.getId(), "common", "attachment", 1);

			if (genFile != null) {
				article.setExtra__thumbImg(genFile.getForPrintUrl());
			}
		}
		homeService.formatTimeString(soccerArticles);
		
		/*자유게시판 5개*/
		List<Article> freeArticles = homeService.getForPrintfree();
		for (Article article : freeArticles) {
			GenFile genFile = genFileService.getGenFile("article", article.getId(), "common", "attachment", 1);

			if (genFile != null) {
				article.setExtra__thumbImg(genFile.getForPrintUrl());
			}
		}
		homeService.formatTimeString(freeArticles);
		
		model.addAttribute("freeArticles", freeArticles);
		model.addAttribute("soccerArticles", soccerArticles);
		model.addAttribute("noticeArticles", noticeArticles);
		model.addAttribute("newsArticles", newsArticles);
		return "usr/article/home";
	}
}
