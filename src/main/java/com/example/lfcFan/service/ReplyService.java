package com.example.lfcFan.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lfcFan.dao.ReplyDao;
import com.example.lfcFan.dto.Reply;
import com.example.lfcFan.util.Util;

@Service
public class ReplyService {
	@Autowired
	private ReplyDao replyDao;

	public int write(Map<String, Object> param) {
		replyDao.write(param);

		int id = Util.getAsInt(param.get("id"));

		return id;
	}
	
	public List<Reply> getForPrintReplies(String relTypeCode, int relId) {
		return replyDao.getForPrintReplies(relTypeCode, relId);
	}
}
