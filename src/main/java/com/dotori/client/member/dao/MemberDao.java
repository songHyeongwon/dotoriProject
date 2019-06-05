package com.dotori.client.member.dao;

import com.dotori.client.member.vo.MemberVO;

public interface MemberDao {

	public int idCheck(String member_id);

	public int memberJoin(MemberVO mvo);

	public MemberVO memberSession(MemberVO ivo);

	public int passwordConfirm(String member_pwd);

}
