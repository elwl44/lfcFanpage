package com.example.lfcFan.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.lfcFan.dto.Reply;

@Mapper
public interface ReplyDao {
	void write(Map<String, Object> param);

	List<Reply> getForPrintReplies( @Param("relTypeCode") String relTypeCode, @Param("relId") int id);

	Reply getReply(@Param("id") int id);

	void deleteReplyById(@Param("id") int id);

	void modify(Map<String, Object> param);
}