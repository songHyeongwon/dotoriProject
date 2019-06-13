package com.dotori.client.member.service;

import java.util.Map;

import com.dotori.client.member.vo.MemberVO;

public interface MemberService {

	int idCheck(String member_id);

	int memberJoin(MemberVO mvo);

	MemberVO memberSession(String member_id,String member_pwd);

	int passwordConfirm(MemberVO mvo);

	int memberUpdate(MemberVO mvo);

	String myFunding(String member_id);

	String usingDotori(String member_id);

	int deleteMember(String member_id);

	int updatePasswordConfirm(MemberVO mvo);

	int dotoriCharge(MemberVO mvo);

	//int memberListCnt(String member_id);

	int emailCheck(String member_eMail);

	MemberVO logIdCheck(MemberVO mvo);

	int eMailIdCheck(MemberVO mvo);

	String logPasswordCheck(MemberVO mvo);

	


}
