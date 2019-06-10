package com.dotori.client.member.service;

import com.dotori.client.member.vo.MemberVO;

public interface MemberService {

	int idCheck(String member_id);

	int memberJoin(MemberVO mvo);

	MemberVO memberSession(String member_id,String member_pwd);

	int passwordConfirm(MemberVO mvo);

	int memberUpdate(MemberVO mvo);

	int memberFunding(String member_id);

	int usingDotori(String member_id);

	int deleteMember(MemberVO mvo);

	int updatePasswordConfirm(MemberVO mvo);

}
