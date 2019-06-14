package com.dotori.manager.member.dao;

import java.util.List;
import com.dotori.manager.member.vo.MemberMVO;

public interface MemberMDao {

	public List<MemberMVO> getMemberList(MemberMVO mvo);

	public int memberListCnt(MemberMVO mvo);

	public MemberMVO memberDetail(MemberMVO mvo);
	public int deleteMemberInsert(MemberMVO memvo);
	public int deleteMember(MemberMVO memvo);
	public MemberMVO memberAll(MemberMVO mvo);

}
