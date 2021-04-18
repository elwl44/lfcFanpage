package com.example.lfcFan.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lfcFan.dao.ArticleDao;
import com.example.lfcFan.dto.Article;
import com.example.lfcFan.dto.Board;
import com.example.lfcFan.dto.Member;
import com.example.lfcFan.dto.Reply;
import com.example.lfcFan.util.Util;

@Service
public class ArticleService {
	@Autowired
	private GenFileService genFileService;
	
	@Autowired
	private ArticleDao articleDao;

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
	
	public void addArticleReading(int id) {
		articleDao.addArticleReading(id);
	}
	
	public void deleteArticleById(int id) {
		articleDao.deleteArticleById(id);
		genFileService.deleteGenFiles("article", id);
	}

	public void modifyArticle(Map<String, Object> param) {
		articleDao.modifyArticle(param);
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
			String datetime = articles.get(i).getUpdateDate();
			try {
				String time=Util.calculateTime(transFormat.parse(datetime));
				articles.get(i).getExtra().put("time", time);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}
}
