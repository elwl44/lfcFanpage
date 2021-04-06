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
	public String showNotice(Model model, @RequestParam Map<String, Object> param) {
		List<Article> articles = articleService.getArticles(param);
		
		int totalCount = articleService.getTotalCount();

		model.addAttribute("totalCount", totalCount);
		model.addAttribute("articles", articles);
		model.addAttribute("board", "공지사항");
		return "usr/article/notice";
	}
	
	@RequestMapping("/usr/article/write")
	public String showWrite() {
		return "usr/article/write";
	}

	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(@RequestParam Map<String, Object> param) {
		int id = articleService.writeArticle(param);

		return String.format("<script> alert('%d번 글이 생성되였습니다.'); location.replace('/usr/article/detail?id=%d'); </script>", id, id);
	}
	
	@RequestMapping("/usr/article/detail")
	public String showDetail(Model model, int id) {
		Article article = articleService.getArticleById(id);

		model.addAttribute("article", article);

		return "usr/article/detail";
	}
	
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		articleService.deleteArticleById(id);

		return String.format("<script> alert('%d번 글을 삭제하였습니다.'); location.replace('/usr/article/notice'); </script>", id);
	}
	
	@RequestMapping("/usr/article/modify")
	public String showModify(Model model, int id) {
		Article article = articleService.getArticleById(id);

		model.addAttribute("article", article);

		return "usr/article/modify";
	}

	
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {
		articleService.modifyArticle(id, title, body);

		return String.format("<script> alert('%d번 글을 수정하였습니다.'); location.replace('/usr/article/detail?id=%d'); </script>", id, id);
	}
}
