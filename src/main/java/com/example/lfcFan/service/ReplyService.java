package com.example.lfcFan.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
		List<Reply> rep=replyDao.getForPrintReplies(relTypeCode, relId);
		formatTimeString(rep);
		return rep;
	}
	
	public Reply getReply(int id) {
		return replyDao.getReply(id);
	}

	public void deleteReplyById(int id) {
		replyDao.deleteReplyById(id);
	}
	
	public void formatTimeString(List<Reply> replies){
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		for (int i = 0; i < replies.size(); i++) {
			String datetime = replies.get(i).getUpdateDate();
			try {
				String time=Util.calculateTime(transFormat.parse(datetime));
				replies.get(i).setTime(time);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
}
