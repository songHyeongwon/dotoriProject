package com.dotori.client.cs_reply.service;

import java.util.List;

import com.dotori.client.cs_reply.vo.Cs_ReplyVO;

public interface Cs_ReplyService {
	public List<Cs_ReplyVO> cs_replyList(Integer b_num);
	public int cs_replyInsert(Cs_ReplyVO rvo);
	public int cs_pwdConfirm(Cs_ReplyVO rvo);
	public int cs_replyUpdate(Cs_ReplyVO rvo);
	public int cs_replyDelete(Integer r_num);
	public Cs_ReplyVO cs_replySelect(Integer r_num);
	public int cs_replyAllDelete(int cs_num);
}
