package com.example.lfcFan.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.lfcFan.dto.Article;
import com.example.lfcFan.dto.Board;
import com.example.lfcFan.dto.League;
import com.example.lfcFan.dto.MatchSchedule;
import com.example.lfcFan.dto.Player;

@Mapper
public interface ArticleDao {
	List<MatchSchedule> getForPrintMatch(String match);
	
	List<Player> getForPrintPlayers(Map<String, Object> param);

	List<Article> getForPrintArticles(Map<String, Object> param);
	
	int writeArticle(Map<String, Object> param);

	Article getForPrintArticleById(@Param("id") int id);
	
	Player getForPrintPlayerById(@Param("id") int id);
	
	League getForPrintLeagueById(@Param("id") int id);

	MatchSchedule getForPrintMatchById(@Param("id") int id);
	
	void deleteArticleById(@Param("id") int id);
	
	void deletePlayerById(@Param("id") int id);
	
	void modifyArticle(Map<String, Object> param);
	
	void modifyPlayer(Map<String, Object> param);
	
	void modifyLeague(Map<String, Object> param);
	
	void modifyMatch(Map<String, Object> param);
	
	int getTotalCount(Map<String, Object> param);

	Board getBoardByCode(String boardCode);

	void addArticleReading(@Param("id") int id);

	void writePlayer(Map<String, Object> param);

	void writeMatch(Map<String, Object> param);
	
	List<League> getForPrintLeagues();
}
