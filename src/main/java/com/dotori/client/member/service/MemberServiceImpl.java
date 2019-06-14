package com.dotori.client.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dotori.client.member.dao.MemberDao;
import com.dotori.client.member.vo.MemberVO;
import com.dotori.client.orders.vo.OrdersVO;
import com.dotori.client.project.vo.ProjectVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService{
	
	@Setter(onMethod_ = @Autowired)
	private MemberDao memberDao;
	
	@Autowired
	private JavaMailSender mailSender;
	
	// 아이디 중복 확인
	@Override
	public int idCheck(String member_id) {
		// TODO Auto-generated method stub
		log.info("idCheck ServiceImpl 호출");
		
		int result=0;
		
		result=memberDao.idCheck(member_id);
		
		return result;
	}
	
	// 회원가입  
	@Override
	public int memberJoin(MemberVO mvo) {
		// TODO Auto-generated method stub
		log.info("memberJoin ServiceImpl 호출");
		
		String member_eMail = mvo.getMember_eMail();
		
		int result=memberDao.emailCheck(member_eMail);
		
		int result1=memberDao.memberJoin(mvo);
		
		if(result==0 && result1==1) {
			return 1;
		}else {
			return 0;
		}
	}
	
	// 로그인
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
	
	// 비밀번호 중복 확인
	@Override
	public int passwordConfirm(MemberVO mvo) {
		// TODO Auto-generated method stub
		int result;
		
		result=memberDao.passwordConfirm(mvo);
		
		return result;
	}
	
	// 회원 수정
	@Override
	public int memberUpdate(MemberVO mvo) {
		// TODO Auto-generated method stub
		int result;
		
		result=memberDao.memberUpdate(mvo);
		
		return result;
	}
	
	// '마이 펀딩' 리스트
	@Override
	public String myFunding(String member_id) {
		// TODO Auto-generated method stub
		List<ProjectVO> list = null;
		ObjectMapper mapper = new ObjectMapper();
		String listData = "";
		
		list = memberDao.myFunding(member_id);
		
		try {
			listData = mapper.writeValueAsString(list);
		}catch(JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return listData;
	}
	
	// 도토리 사용내역
	@Override
	public String usingDotori(String member_id) {
		// TODO Auto-generated method stub
		List<OrdersVO> list = null;
		ObjectMapper mapper = new ObjectMapper();
		String listData = "";
		
		list = memberDao.usingDotori(member_id);
		
		try {
			listData= mapper.writeValueAsString(list);
		}catch(JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return listData;
		
	}
	
	// '펀딩 중' 리스트
		@Override
		public String fundingProcess(String member_id) {
			// TODO Auto-generated method stub
			List<ProjectVO> list = null;
			ObjectMapper mapper = new ObjectMapper();
			String listData ="";
			
			list = memberDao.fundingProcess(member_id);
			
			try {
				listData = mapper.writeValueAsString(list);
			}catch(JsonProcessingException e) {
				e.printStackTrace();
			}
			
			return listData;
		}

	// 회원 탈퇴
	@Override
	public int deleteMember(String member_id) {
		// TODO Auto-generated method stub
		int result;
		
		MemberVO memvo = memberDao.memberAll(member_id);
		
		result = memberDao.deleteMemberInsert(memvo);
		
		result = memberDao.deleteMember(memvo);
		
		return result;
	}

	
	@Override
	public int updatePasswordConfirm(MemberVO mvo) {
		// TODO Auto-generated method stub
		int result;
		
		result = memberDao.updatePasswordConfirm(mvo);
		
		return result;
	}

	// 포인트(도토리) 충전
	@Override
	public int dotoriCharge(MemberVO mvo) {
		// TODO Auto-generated method stub
		
		int result = memberDao.dotoriCharge(mvo);
		
		return result;
	}
	
	// 펀딩 중 리스트 회원 아이디에 따른 개수 구하기
	//@Override
	/*public int memberListCnt(String member_id) {
		// TODO Auto-generated method stub
		int result = memberDao.memberListCnt(member_id);
		
		return result;
	}*/

	// 입력받은 이메일 값이 테이블에 있는지 체크
	@Override
	public int emailCheck(String member_eMail) {
		// TODO Auto-generated method stub
		
		int result=memberDao.emailCheck(member_eMail);
		
		return result;
	}

	// 입력받은 이메일 값에 맞는 테이블의 아이디 값 찾기
	@Override
	public MemberVO logIdCheck(MemberVO mvo) {
		// TODO Auto-generated method stub
		MemberVO result = memberDao.logIdCheck(mvo);
		
		return result;
	}

	// 입력받은 이메일, 아이디 값으로 테이블에 있는 이메일인지 확인
	@Override
	public int eMailIdCheck(MemberVO mvo) {
		// TODO Auto-generated method stub
		int result = memberDao.emailCheck(mvo.getMember_eMail());
		
		return result;
	}
	
	// 입력받은 이메일, 아이디 값에 맞는 비밀번호 찾기
	@Override
	public String logPasswordCheck(MemberVO mvo) {
		// TODO Auto-generated method stub
		String result = memberDao.logPasswordCheck(mvo);
		
		return result;
	}

	@Override
	public int refund(int orders_num) {
		// TODO Auto-generated method stub
		int result = memberDao.refund(orders_num);
		
		return result;
	}

	@Override
	public int memberfundingListCnt(String member_id) {
		// TODO Auto-generated method stub
		int result = memberDao.memberfundingListCnt(member_id);
		
		return result;
	}

	
	

}
