package com.example.lfcFan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lfcFan.dao.HomeDao;
import com.example.lfcFan.dto.Article;

@Service
public class HomeService {
	@Autowired
	private HomeDao homeDao;
	
	public List<Article> getForPrintnews() {
		List<Article> articles = homeDao.getForPrintnews();
		return articles;
	}

}
