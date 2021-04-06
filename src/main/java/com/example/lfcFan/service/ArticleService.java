package com.example.lfcFan.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lfcFan.dao.ArticleDao;
import com.example.lfcFan.dto.Article;
import com.example.lfcFan.util.Util;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;

	public List<Article> getArticles() {
		return articleDao.getArticles();
	}

	public int writeArticle(Map<String, Object> param) {
		articleDao.writeArticle(param);
		int id = Util.getAsInt(param.get("id"));

		return id;
	}

	public Article getArticleById(int id) {
		return articleDao.getArticleById(id);
	}
	
	
}
