package com.dotori.client.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dotori.client.member.dao.MemberDao;
import com.dotori.client.member.vo.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService{
	
	@Setter(onMethod_ = @Autowired)
	private MemberDao memberDao;

	@Override
	public int idCheck(String member_id) {
		// TODO Auto-generated method stub
		log.info("idCheck ServiceImpl 호출");
		
		int result=0;
		
		result=memberDao.idCheck(member_id);
		
		return result;
	}

	@Override
	public int memberJoin(MemberVO mvo) {
		// TODO Auto-generated method stub
		log.info("memberJoin ServiceImpl 호출");
		
		int result=0;
		
		result=memberDao.memberJoin(mvo);
		
		return result;
	}

	@Override
	public MemberVO memberSession(String member_id,String member_pwd) {
		// TODO Auto-generated method stub
		MemberVO result;
		
		MemberVO ivo = new MemberVO();
		
		ivo.setMember_id(member_id);
		ivo.setMember_pwd(member_pwd);
		
		result=memberDao.memberSession(ivo);
		
		return result;
	}

}
