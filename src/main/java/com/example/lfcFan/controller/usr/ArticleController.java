package com.example.lfcFan.controller.usr;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartRequest;

import com.example.lfcFan.dto.Article;
import com.example.lfcFan.dto.Board;
import com.example.lfcFan.dto.GenFile;
import com.example.lfcFan.dto.League;
import com.example.lfcFan.dto.MatchSchedule;
import com.example.lfcFan.dto.Member;
import com.example.lfcFan.dto.Player;
import com.example.lfcFan.dto.Reply;
import com.example.lfcFan.service.ArticleService;
import com.example.lfcFan.service.GenFileService;
import com.example.lfcFan.service.ReplyService;
import com.example.lfcFan.util.Util;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;

	@Autowired
	private ReplyService replyService;

	@Autowired
	private GenFileService genFileService;

	@RequestMapping("/usr/article-{boardCode}/list")
	public String showList(HttpServletRequest req, Model model, @RequestParam Map<String, Object> param,
			@PathVariable("boardCode") String boardCode) {
		Board board = articleService.getBoardByCode(boardCode);

		if (board == null) {
			model.addAttribute("msg", "존재하지 않는 게시판 입니다.");
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		param.put("boardId", board.getId());

		int totalCount = articleService.getTotalCount(param);
		int itemsCountInAPage = 10;
		int totalPage = (int) Math.ceil(totalCount / (double) itemsCountInAPage);

		int pageMenuArmSize = 5;
		int page = Util.getAsInt(param.get("page"), 1);

		int pageMenuStart = page - pageMenuArmSize;
		if (pageMenuStart < 1) {
			pageMenuStart = 1;
		}
		int pageMenuEnd = page + pageMenuArmSize;
		if (pageMenuEnd > totalPage) {
			pageMenuEnd = totalPage;
		}

		param.put("itemsCountInAPage", itemsCountInAPage);

		if (boardCode.equals("news")) {
			List<Article> articles = articleService.getForPrintArticles(loginedMember, param);

			for (Article article : articles) {
				GenFile genFile = genFileService.getGenFile("article", article.getId(), "common", "attachment", 1);

				if (genFile != null) {
					article.setExtra__thumbImg(genFile.getForPrintUrl());
				}
			}
			articleService.formatTimeString(articles);
			model.addAttribute("board", board);
			model.addAttribute("totalCount", totalCount);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("pageMenuArmSize", pageMenuArmSize);
			model.addAttribute("pageMenuStart", pageMenuStart);
			model.addAttribute("pageMenuEnd", pageMenuEnd);
			model.addAttribute("page", page);
			model.addAttribute("articles", articles);
			return "usr/article/list-news";
		}

		List<Article> articles = articleService.getForPrintArticles(loginedMember, param);

		model.addAttribute("board", board);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("pageMenuArmSize", pageMenuArmSize);
		model.addAttribute("pageMenuStart", pageMenuStart);
		model.addAttribute("pageMenuEnd", pageMenuEnd);
		model.addAttribute("page", page);
		model.addAttribute("articles", articles);
		return "usr/article/list";
	}

	@RequestMapping("/usr/article/team")
	public String showTeam(HttpServletRequest req, Model model, @RequestParam Map<String, Object> param) {
		Board board = articleService.getBoardByCode("player");
		param.put("boardId", board.getId());

		List<Player> players = articleService.getForPrintPlayers(param);
		for (Player article : players) {
			GenFile genFile = genFileService.getGenFile("player", article.getId(), "common", "attachment", 1);

			if (genFile != null) {
				article.setExtra__thumbImg(genFile.getForPrintUrl());
			}
		}
		model.addAttribute("board", board);
		model.addAttribute("players", players);
		return "usr/article/team";
	}
	
	@RequestMapping("/usr/article/match")
	public String showMatch(HttpServletRequest req, Model model, @RequestParam Map<String, Object> param, String input_month) {
		String month="";
		if(input_month!=null) {
			month=input_month;
		}
		if(month.equals("")) {
			Calendar cal = Calendar.getInstance(); //객체 생성 및 현재 일시분초...셋팅
			month=String.valueOf(cal.get(Calendar.MONTH)+1);
		}
		List<MatchSchedule> matchschedule = articleService.getForPrintMatch(month);
		model.addAttribute("month", month);
		model.addAttribute("matchschedule", matchschedule);
		return "usr/article/match-list";
	}
	
	@RequestMapping("/usr/article/leaguetable")
	public String showLeaguetable(HttpServletRequest req, Model model, @RequestParam Map<String, Object> param) {
		List<League> leaguetables = articleService.getForPrintLeagues();
		model.addAttribute("leaguetables", leaguetables);
		return "usr/article/league-table";
	}

	@RequestMapping("/usr/article-{boardCode}/write")
	public String showWrite(HttpServletRequest req, Model model, @PathVariable("boardCode") String boardCode) {
		Board board = articleService.getBoardByCode(boardCode);
		if (board == null) {
			model.addAttribute("msg", "존재하지 않는 게시판 입니다.");
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		model.addAttribute("board", board);
		if (board.getCode().equals("player")) {
			return "usr/article/write-player";
		}
		else if (board.getCode().equals("match")) {
			return "usr/article/write-match";
		}
		return "usr/article/write";
	}

	@RequestMapping("/usr/article-{boardCode}/doWrite")
	public String doWrite(HttpServletRequest req, @RequestParam Map<String, Object> param, Model model,
			@PathVariable("boardCode") String boardCode, MultipartRequest multipartRequest) {
		Board board = articleService.getBoardByCode(boardCode);
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		param.put("boardId", board.getId());
		param.put("memberId", loginedMemberId);

		if (boardCode.equals("player")) {
			articleService.writePlayer(param);

			model.addAttribute("replaceUri", String.format("/usr/article/team"));
		}
		else {
			int id = articleService.writeArticle(param);

			model.addAttribute("msg", String.format("%d번 글이 생성되였습니다.", id));
			model.addAttribute("replaceUri", String.format("/usr/article-%s/detail?id=%d", boardCode, id));
		}
		return "common/redirect";
	}
	@RequestMapping("/usr/article-{boardCode}/doWriteMatch")
	public String doWriteMatch(HttpServletRequest req, @RequestParam Map<String, Object> param, Model model, @PathVariable("boardCode") String boardCode) {
		Board board = articleService.getBoardByCode(boardCode);
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		param.put("boardId", board.getId());
		param.put("memberId", loginedMemberId);

		articleService.writeMatch(param);

		model.addAttribute("replaceUri", String.format("/usr/article/match"));
		return "common/redirect";
	}
	@RequestMapping("/usr/article-{boardCode}/detail")
	public String showDetail(HttpServletRequest req, Model model, int id, String listUrl,
			@PathVariable("boardCode") String boardCode) {

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		Board board = articleService.getBoardByCode(boardCode);

		if (listUrl == null && boardCode != null) {
			listUrl = "/usr/article-" + boardCode + "/list";
		}

		if (boardCode.equals("player")) {
			Player player = articleService.getForPrintPlayerById(id);
			GenFile genFile = genFileService.getGenFile("player", player.getId(), "common", "attachment", 1);

			if (genFile != null) {
				player.setExtra__thumbImg(genFile.getForPrintUrl());
			}

			List<GenFile> files = genFileService.getGenFiles("player", player.getId(), "common", "attachment");

			Map<String, GenFile> filesMap = new HashMap<>();

			for (GenFile file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			player.getExtraNotNull().put("file__common__attachment", filesMap);
			model.addAttribute("player", player);
			model.addAttribute("listUrl", listUrl);
			return "usr/article/detail-player";
		} else {
			articleService.addArticleReading(id);
			Article article = articleService.getForPrintArticleById(loginedMember, id);
			List<Reply> replies = replyService.getForPrintReplies(loginedMember, "article", id);
			GenFile genFile = genFileService.getGenFile("article", article.getId(), "common", "attachment", 1);

			if (genFile != null) {
				article.setExtra__thumbImg(genFile.getForPrintUrl());
			}

			model.addAttribute("board", board);
			model.addAttribute("article", article);
			model.addAttribute("replies", replies);
			model.addAttribute("listUrl", listUrl);
		}

		return "usr/article/detail";
	}

	@RequestMapping("/usr/article-{boardCode}/doDelete")
	public String doDelete(HttpServletRequest req, int id, Model model, String listUrl,
			@PathVariable("boardCode") String boardCode) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");

		if (boardCode.equals("player")) {
			articleService.deletePlayerById(id);

			model.addAttribute("replaceUri", listUrl);
			return "common/redirect";
		} else {
			Article article = articleService.getForPrintArticleById(loginedMember, id);

			if ((boolean) article.getExtra().get("actorCanDelete") == false) {
				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("historyBack", true);
				return "common/redirect";
			}

			articleService.deleteArticleById(id);
		}
		model.addAttribute("msg", String.format("%d번 글을 삭제하였습니다.", id));
		model.addAttribute("replaceUri", listUrl);
		return "common/redirect";
	}

	@RequestMapping("/usr/article-{boardCode}/modify")
	public String showModify(HttpServletRequest req, Model model, int id, String redirectUrl,
			@PathVariable("boardCode") String boardCode) {
		Board board = articleService.getBoardByCode(boardCode);
		Member loginedMember = (Member) req.getAttribute("loginedMember");

		if (redirectUrl == null) {
			redirectUrl = "/usr/article-free/list";
		}

		if (boardCode.equals("player")) {
			Player player = articleService.getForPrintPlayerById(id);

			List<GenFile> files = genFileService.getGenFiles("player", player.getId(), "common", "attachment");

			Map<String, GenFile> filesMap = new HashMap<>();

			for (GenFile file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			player.getExtraNotNull().put("file__common__attachment", filesMap);

			model.addAttribute("board", board);
			model.addAttribute("redirectUrl", redirectUrl);
			model.addAttribute("player", player);

			return "usr/article/modify-player";
		} else {
			Article article = articleService.getForPrintArticleById(loginedMember, id);

			List<GenFile> files = genFileService.getGenFiles("article", article.getId(), "common", "attachment");

			Map<String, GenFile> filesMap = new HashMap<>();

			for (GenFile file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			article.getExtraNotNull().put("file__common__attachment", filesMap);

			if ((boolean) article.getExtra().get("actorCanModify") == false) {
				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("historyBack", true);
				return "common/redirect";
			}

			model.addAttribute("board", board);
			model.addAttribute("redirectUrl", redirectUrl);
			model.addAttribute("article", article);
		}

		return "usr/article/modify";
	}

	@RequestMapping("/usr/article-{boardCode}/doModify")
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req, Model model,
			String redirectUrl, @PathVariable("boardCode") String boardCode) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		int id = Util.getAsInt(param.get("id"), 0);

		if (redirectUrl.equals("")) {
			model.addAttribute("replaceUri", String.format("/usr/article-%s/detail?id=%d", boardCode, id));
		} else {
			model.addAttribute("replaceUri", redirectUrl);
		}

		if (boardCode.equals("player")) {
			articleService.modifyPlayer(param);
		} else {
			Article article = articleService.getForPrintArticleById(loginedMember, id);

			if ((boolean) article.getExtra().get("actorCanModify") == false) {
				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("historyBack", true);
				return "common/redirect";
			}
			articleService.modifyArticle(param);

			model.addAttribute("msg", String.format("%d번 글을 수정하였습니다.", id));
			model.addAttribute("replaceUri", String.format("/usr/article-%s/detail?id=%d", boardCode, id));
		}
		return "common/redirect";
	}

	@RequestMapping("/usr/article/modify-league")
	public String showModifyLeague(HttpServletRequest req, Model model, String redirectUrl, int id) {
		if (redirectUrl == null) {
			redirectUrl = "/usr/article-free/list";
		}
		Member loginedMember = (Member) req.getAttribute("loginedMember");

		League leaguetable = articleService.getForPrintLeagueById(id);

		model.addAttribute("loginedMember", loginedMember);
		model.addAttribute("leaguetable", leaguetable);
		model.addAttribute("redirectUrl", redirectUrl);

		return "usr/article/modify-league";
	}

	@RequestMapping("/usr/article/doModifyLeague")
	public String doModifyLeague(@RequestParam Map<String, Object> param, HttpServletRequest req, Model model,
			String redirectUrl) {
		articleService.modifyLeague(param);
		model.addAttribute("replaceUri", String.format("/usr/article/leaguetable"));
		return "common/redirect";
	}
}
