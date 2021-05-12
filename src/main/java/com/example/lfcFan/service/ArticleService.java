package com.example.lfcFan.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lfcFan.dao.ArticleDao;
import com.example.lfcFan.dto.Article;
import com.example.lfcFan.dto.Board;
import com.example.lfcFan.dto.League;
import com.example.lfcFan.dto.MatchSchedule;
import com.example.lfcFan.dto.Member;
import com.example.lfcFan.dto.Player;
import com.example.lfcFan.util.Util;

@Service
public class ArticleService {
	@Autowired
	private GenFileService genFileService;
	
	@Autowired
	private ArticleDao articleDao;

	public List<League> getForPrintLeagues(){
		List<League> leaguetables=articleDao.getForPrintLeagues();
		return leaguetables;
	}
	
	public List<MatchSchedule> getForPrintMatch(String match){
		List<MatchSchedule> matches = articleDao.getForPrintMatch(match);
		return Util.splitLeague(matches);
	}
	
	public List<Player> getForPrintPlayers(Map<String, Object> param) {
		List<Player> players = articleDao.getForPrintPlayers(param);
		for(Player player : players) {
			if(player.getBackNumber()==1 || player.getBackNumber()==3 || player.getBackNumber()==6 || player.getBackNumber()==13)
			{	
				String firstname=player.getFirstName();
				player.setFirstName(player.getLastName());
				player.setLastName(firstname);
			}
		}
		return players;
	}
	
	public List<Article> getForPrintArticlesByid(int id){
		return articleDao.getForPrintArticlesByid(id);
	}
	
	public List<Article> getForPrintArticles(Member actorMember, Map<String, Object> param) {
		int page = Util.getAsInt(param.get("page"), 1);

		// 한 리스트에 나올 수 있는 게시물 게수
		int itemsCountInAPage = Util.getAsInt(param.get("itemsCountInAPage"), 10);
		
		if ( itemsCountInAPage > 100 ) {
			itemsCountInAPage = 100;
		}
		else if ( itemsCountInAPage < 1 ) {
			itemsCountInAPage = 1;
		}

		int limitFrom = (page - 1) * itemsCountInAPage;
		int limitTake = itemsCountInAPage;

		param.put("limitFrom", limitFrom);
		param.put("limitTake", limitTake);
		
		List<Article> articles = articleDao.getForPrintArticles(param);

		for ( Article article : articles ) {
			
			if ( article.getExtra() == null ) {
				article.setExtra(new HashMap<>()); 
			}
			
			boolean actorCanDelete = false;
			
			if (actorMember != null) {
				actorCanDelete = actorMember.getId() == article.getMemberId();
			}
			
			boolean actorCanModify = actorCanDelete;

			article.getExtra().put("actorCanDelete", actorCanDelete);
			article.getExtra().put("actorCanModify", actorCanModify);
		}
		
		return articles;
	}

	public int writeArticle(Map<String, Object> param) {
		articleDao.writeArticle(param);
		int id = Util.getAsInt(param.get("id"));
		
		changeInputFileRelIds(param, id);
		
		return id;
	}
	
	private void changeInputFileRelIds(Map<String, Object> param, int id) {
		String genFileIdsStr = Util.ifEmpty((String)param.get("genFileIdsStr"), null);

		if ( genFileIdsStr != null ) {
			List<Integer> genFileIds = Util.getListDividedBy(genFileIdsStr, ",");

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int genFileId : genFileIds) {
				genFileService.changeRelId(genFileId, id);
			}
		}
	}
	
	public Article getForPrintArticleById(Member actorMember, int id) {
		Article article = articleDao.getForPrintArticleById(id);

		if (article == null) {
			return null;
		}

		
		if (article.getExtra() == null) {
			article.setExtra(new HashMap<>());
		}

		boolean actorCanDelete = false;

		if (actorMember != null) {
			actorCanDelete = actorMember.getId() == article.getMemberId();
		}

		boolean actorCanModify = actorCanDelete;

		article.getExtra().put("actorCanDelete", actorCanDelete);
		article.getExtra().put("actorCanModify", actorCanModify);

		return article;
	}
	
	public Player getForPrintPlayerById(int id) {
		Player article = articleDao.getForPrintPlayerById(id);
		return article;
	}
	
	public League getForPrintLeagueById(int id) {
		League league = articleDao.getForPrintLeagueById(id);
		return league;
	}
	
	public MatchSchedule getForPrintMatchById(int id) {
		MatchSchedule match=articleDao.getForPrintMatchById(id);
		Util.checkLeague(match);
		return match;
	}
	
	public void addArticleReading(int id) {
		articleDao.addArticleReading(id);
	}
	
	public void deleteArticleById(int id) {
		articleDao.deleteArticleById(id);
		genFileService.deleteGenFiles("article", id);
	}
	
	public void deletePlayerById(int id) {
		articleDao.deletePlayerById(id);
		genFileService.deleteGenFiles("player", id);
	}
	
	public void deleteMatchById(int id) {
		articleDao.deleteMatchById(id);
	}
	
	public void deleteArticlesByMemberId(int memberid) {
		articleDao.deleteArticlesByMemberId(memberid);
	}
	
	public void modifyArticle(Map<String, Object> param) {
		articleDao.modifyArticle(param);
	}

	public void modifyPlayer(Map<String, Object> param) {
		articleDao.modifyPlayer(param);
	}
	
	public void modifyLeague(Map<String, Object> param) {
		param.put("game", Util.sumGame(param));
		param.put("goalGap", Util.goalGap(param));
		param.put("point", Util.getPoint(param));
		articleDao.modifyLeague(param);
	}
	
	public void modifyMatch(Map<String, Object> param) {
		if(param.get("League").equals("direct")) {
			param.replace("League",Util.changeParam(param));
		}
		articleDao.modifyMatch(param);
	}
	
	public int getTotalCount(Map<String, Object> param) {
		return articleDao.getTotalCount(param);
	}

	public Board getBoardByCode(String boardCode) {
		return articleDao.getBoardByCode(boardCode);
	}
	
	public void formatTimeString(List<Article> articles){
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		for (int i = 0; i < articles.size(); i++) {
			String datetime = articles.get(i).getRegDate();
			try {
				String time=Util.calculateTime(transFormat.parse(datetime));
				articles.get(i).getExtra().put("time", time);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}

	public void writePlayer(Map<String, Object> param) {
		articleDao.writePlayer(param);
		int id = Util.getAsInt(param.get("id"));
		changeInputFileRelIds(param, id);		
	}
	
	public void writeMatch(Map<String, Object> param) {
		String month=Util.getMonth(param);
		if(param.get("League").equals("direct")) {
			param.replace("League",Util.changeParam(param));
		}
		param.put("month", month);
		articleDao.writeMatch(param);
	}
	
	public void getWrtieCountMembers(List<Member> members) {
		for (Member member : members) {
			member.setWrtieCount(articleDao.getWrtieCountMembers(member.getId()));
		}
	}
}
