package com.example.lfcFan.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lfcFan.dao.ReplyDao;
import com.example.lfcFan.dto.Member;
import com.example.lfcFan.dto.Reply;
import com.example.lfcFan.util.Util;

@Service
public class ReplyService {
	@Autowired
	private ReplyDao replyDao;

	public int write(Reply reply) {

		// replyDao.write(param);
		if (reply.getId() == null || "".equals(reply.getId())) {
            if (reply.getReparent() != null) {
                Reply replyInfo = replyDao.selectBoard6ReplyParent(reply.getReparent());
                reply.setRedepth(replyInfo.getRedepth());
                reply.setReorder(replyInfo.getReorder() + 1);
               replyDao.updateBoard6ReplyOrder(replyInfo);
            } else {//일반댓글등록
               Integer reorder = replyDao.selectBoard6ReplyMaxOrder(reply);
               String reparent = Util.getAsStr(replyDao.selectBoard6ReplyMaxOrder(reply),"");
                reply.setReorder(reorder);
                reply.setReparent(reparent);
                reply.setRedepth("0");
            }
            replyDao.insertBoard6Reply(reply);
        } else {
        	replyDao.updateBoard6Reply(reply);
        }
		
		int id = 1;

		return id;
	}

	public List<Reply> getForPrintReplies(Member actorMember, String relTypeCode, int relId, Map<String, Object> param) {
		/*댓글 페이징*/
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
		
		List<Reply> replies = replyDao.getForPrintReplies(relTypeCode, relId, param);
		formatTimeString(replies);

		for (Reply reply : replies) {
			if (reply.getExtra() == null) {
				reply.setExtra(new HashMap<>());
			}

			boolean actorCanDelete = false;

			if (actorMember != null) {
				actorCanDelete = actorMember.getId() == reply.getMemberId();
			}

			boolean actorCanModify = actorCanDelete;

			reply.getExtra().put("actorCanDelete", actorCanDelete);
			reply.getExtra().put("actorCanModify", actorCanModify);
		}

		return replies;
	}

	public Reply getReply(int id) {
		return replyDao.getReply(id);
	}

	public Reply getForPrintReply(Member actorMember, int id) {
		Reply reply = getReply(id);

		if (reply == null) {
			return null;
		}

		if (reply.getExtra() == null) {
			reply.setExtra(new HashMap<>());
		}

		boolean actorCanDelete = false;

		if (actorMember != null) {
			actorCanDelete = actorMember.getId() == reply.getMemberId();
		}

		boolean actorCanModify = actorCanDelete;

		reply.getExtra().put("actorCanDelete", actorCanDelete);
		reply.getExtra().put("actorCanModify", actorCanModify);

		return reply;
	}

	public void deleteReplyById(int id) {
		replyDao.deleteReplyById(id);
	}

	public void deleteReplysByMemberId(int memberId) {
		replyDao.deleteReplysByMemberId(memberId);
	}

	public void formatTimeString(List<Reply> replies) {
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		for (int i = 0; i < replies.size(); i++) {
			String datetime = replies.get(i).getUpdateDate();
			try {
				String time = Util.calculateTime(transFormat.parse(datetime));
				replies.get(i).setTime(time);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}

	public void modify(Map<String, Object> param) {
		replyDao.modify(param);
	}

	public int getArticleRelTotalCount(int id) {
		return replyDao.getArticleRelTotalCount(id);
	}

	public void deleteReplyByArticleId(int id) {
		replyDao.deleteReplyByArticleId(id);	
	}

}
