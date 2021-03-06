package com.dotori.client.cs_reply.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dotori.client.cs_reply.dao.Cs_ReplyDao;
import com.dotori.client.cs_reply.vo.Cs_ReplyVO;

import lombok.Setter;

//설정자
@Service
//@AllArgsConstructor
public class Cs_ReplyServiceImpl implements Cs_ReplyService{
	//접근자
	@Setter(onMethod_=@Autowired)
	private Cs_ReplyDao replyDao;

	@Override
	public List<Cs_ReplyVO> cs_replyList(Integer cs_num) {
		List<Cs_ReplyVO> list = null;
		list = new ArrayList<Cs_ReplyVO>();
		list = replyDao.cs_replyList(cs_num);
		return list;
	}

	@Override
	public int cs_replyInsert(Cs_ReplyVO rvo) {
		int result = 0;
		result = replyDao.cs_replyInsert(rvo);
		return result;
	}

	@Override
	public int cs_pwdConfirm(Cs_ReplyVO rvo) {
		int result = 0;
		result = replyDao.cs_pwdConfirm(rvo);
		return result;
	}

	@Override
	public int cs_replyUpdate(Cs_ReplyVO rvo) {
		int result = 0;
		result = replyDao.cs_replyUpdate(rvo);
		return result;
	}
	
	@Override
	public int cs_replyDelete(Integer r_num) {
		int result = 0;
		result = replyDao.cs_replyDelete(r_num);
		return result;
	}

	@Override
	public Cs_ReplyVO cs_replySelect(Integer r_num) {
		Cs_ReplyVO rvo = null;
		rvo = replyDao.cs_replySelect(r_num);
		return rvo;
	}

	@Override
	public int cs_replyAllDelete(int cs_num) {
		int result = 0;
		result = replyDao.cs_replyAllDelete(cs_num);
		return result;
	}
}
