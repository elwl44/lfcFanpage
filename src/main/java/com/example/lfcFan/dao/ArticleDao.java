package com.example.lfcFan.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.lfcFan.dto.Article;
import com.example.lfcFan.dto.Board;

@Mapper
public interface ArticleDao {
	List<Article> getForPrintArticles(Map<String, Object> param);

	int writeArticle(Map<String, Object> param);

	Article getForPrintArticleById(@Param("id") int id);

	void deleteArticleById(@Param("id") int id);

	void modifyArticle(Map<String, Object> param);

	int getTotalCount(Map<String, Object> param);

	Board getBoardByCode(String boardCode);

	void addArticleReading(@Param("id") int id);
}
