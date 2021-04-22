package com.example.lfcFan.controller.usr;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.lfcFan.dto.Article;
import com.example.lfcFan.dto.GenFile;
import com.example.lfcFan.dto.League;
import com.example.lfcFan.dto.MatchSchedule;
import com.example.lfcFan.dto.Player;
import com.example.lfcFan.service.ArticleService;
import com.example.lfcFan.service.GenFileService;
import com.example.lfcFan.service.HomeService;

@Controller
public class HomeController {
	@Autowired
	private GenFileService genFileService;
	
	@Autowired
	private HomeService homeService;
	
	@Autowired
	private ArticleService articleService;
	
	@RequestMapping("/")
	public String showMain() {
		return "redirect:/usr/article/home";
	}
	
	@RequestMapping("/usr/article/home")
	public String showHome(Model model, @RequestParam Map<String, Object> param) {
		/*경기일정 4개*/
		List<MatchSchedule> matches = homeService.getForPrintMatches();
		
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
		
		/*리그 테이블*/
		List<League> leaguetables = homeService.getForPrintLeagues();
		
		/*선수 소개*/
		List<Player> players = articleService.getForPrintPlayers(param);
		for (Player article : players) {
			GenFile genFile = genFileService.getGenFile("player", article.getId(), "common", "attachment", 1);

			if (genFile != null) {
				article.setExtra__thumbImg(genFile.getForPrintUrl());
			}
		}
		
		model.addAttribute("matches", matches);
		model.addAttribute("players", players);
		model.addAttribute("leaguetables", leaguetables);
		model.addAttribute("freeArticles", freeArticles);
		model.addAttribute("soccerArticles", soccerArticles);
		model.addAttribute("noticeArticles", noticeArticles);
		model.addAttribute("newsArticles", newsArticles);
		return "usr/article/home";
	}
}
