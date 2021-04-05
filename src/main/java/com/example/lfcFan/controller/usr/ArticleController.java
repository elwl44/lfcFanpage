package com.example.lfcFan.controller.usr;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(@RequestParam Map<String, Object> param) {
		int id = articleService.writeArticle(param);

		return String.format("<script> alert('%d번 글이 생성되였습니다.'); location.replace('/usr/article/detail?id=%d'); </script>", id, id);
	}

}
