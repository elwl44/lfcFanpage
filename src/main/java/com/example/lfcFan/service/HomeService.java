package com.example.lfcFan.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lfcFan.dao.HomeDao;
import com.example.lfcFan.dto.Article;
import com.example.lfcFan.util.Util;

@Service
public class HomeService {
	@Autowired
	private HomeDao homeDao;
	
	public List<Article> getForPrintnews() {
		List<Article> articles = homeDao.getForPrintnews();
		return articles;
	}
	
	public List<Article> getForPrintnotice() {
		List<Article> articles = homeDao.getForPrintnotice();
		return articles;
	}
	
	public List<Article> getForPrintsoccer() {
		return homeDao.getForPrintsoccer();
	}
	
	public List<Article> getForPrintfree() {
		return homeDao.getForPrintfree();
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
}
