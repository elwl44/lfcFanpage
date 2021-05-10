package com.example.lfcFan.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.lfcFan.dto.Reply;

@Mapper
public interface ReplyDao {
	void write(Map<String, Object> param);

	List<Reply> getForPrintReplies( @Param("relTypeCode") String relTypeCode, @Param("relId") int id, Map<String, Object> param);

	Reply getReply(@Param("id") int id);

	void deleteReplyById(@Param("id") int id);

	void modify(Map<String, Object> param);
	
	void deleteReplysByMemberId(@Param("memberId") int memberId);

	Reply selectBoard6ReplyParent(String reparent);

	void updateBoard6ReplyOrder(Reply replyInfo);

	Integer selectBoard6ReplyMaxOrder(Reply reply);
	
	void insertBoard6Reply(Reply reply);

	void updateBoard6Reply(Reply reply);

	int getArticleRelTotalCount(int id);

	void deleteReplyByArticleId(int id);
}
