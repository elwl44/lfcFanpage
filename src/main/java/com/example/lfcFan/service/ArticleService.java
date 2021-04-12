package com.example.lfcFan.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lfcFan.dao.ArticleDao;
import com.example.lfcFan.dto.Article;
import com.example.lfcFan.dto.Board;
import com.example.lfcFan.dto.Member;
import com.example.lfcFan.util.Util;

@Service
public class ArticleService {
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

		return id;
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

	public void deleteArticleById(int id) {
		articleDao.deleteArticleById(id);
	}

	public void modifyArticle(int id, String title, String body) {
		articleDao.modifyArticle(id, title, body);
	}

	public int getTotalCount(Map<String, Object> param) {
		return articleDao.getTotalCount(param);
	}

	public Board getBoardByCode(String boardCode) {
		return articleDao.getBoardByCode(boardCode);
	}
}