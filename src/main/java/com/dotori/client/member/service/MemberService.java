package com.dotori.client.member.service;

import com.dotori.client.member.vo.MemberVO;

public interface MemberService {

	int idCheck(String member_id);

	int memberJoin(MemberVO mvo);

	MemberVO memberSession(String member_id,String member_pwd);

	int passwordConfirm(String member_pwd);

}
