package com.example.lfcFan.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.lfcFan.dto.Article;

@Mapper
public interface ArticleDao {
	List<Article> getArticles();

	int writeArticle(Map<String, Object> param);
}
