package com.dotori.manager.member.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dotori.client.member.vo.MemberVO;
import com.dotori.manager.member.dao.MemberMDao;
import com.dotori.manager.member.vo.MemberMVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class MemberMServiceImpl implements MemberMService{
	private MemberMDao memberMDao;

	@Override
	public List<MemberMVO> getMemberList(MemberMVO mvo) {
		List<MemberMVO> list = memberMDao.getMemberList(mvo);
		return list;
	}

	@Override
	public int memberListCnt(MemberMVO mvo) {
		int result = memberMDao.memberListCnt(mvo);
		return result;
	}

	@Override
	public MemberMVO memberDetail(MemberMVO mvo) {
		MemberMVO result = memberMDao.memberDetail(mvo);
		return result;
	}

	@Override
	public int deleteMember(MemberMVO mvo) {
		int result = 0;
		
		MemberMVO memvo = memberMDao.memberAll(mvo);
		log.info("가져온값 = "+memvo);
		result = memberMDao.deleteMemberInsert(memvo);
		
		result = memberMDao.deleteMember(memvo);
		
		return result;
	}
}
