package com.dotori.client.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dotori.client.member.dao.MemberDao;

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
		log.info("idCheck ServiceImpl »£√‚");
		
		int result=0;
		
		result=memberDao.idCheck(member_id);
		
		return result;
	}

}
