package com.example.lfcFan.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.lfcFan.dto.Article;
import com.example.lfcFan.dto.League;

@Mapper
public interface HomeDao {
	List<Article> getForPrintnews();
	
	List<Article> getForPrintnotice();
	
	List<Article> getForPrintsoccer();
	
	List<Article> getForPrintfree();
	
	List<League> getForPrintLeagues();
}
