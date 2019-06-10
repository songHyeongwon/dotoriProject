package com.dotori.client.member.dao;

import com.dotori.client.member.vo.MemberVO;

public interface MemberDao {

	public int idCheck(String member_id);

	public int memberJoin(MemberVO mvo);

	public MemberVO memberSession(MemberVO ivo);

	public int passwordConfirm(String member_pwd);

	public int memberUpdate(MemberVO mvo);

	public int memberFunding(String member_id);

	public int usingDotori(String member_id);

	public int deleteMember(MemberVO mvo);

	public int deleteMemberInsert(MemberVO mvo);

}
