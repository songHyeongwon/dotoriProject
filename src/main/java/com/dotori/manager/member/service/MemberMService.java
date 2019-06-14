package com.dotori.manager.member.service;

import java.util.List;

import com.dotori.manager.member.vo.MemberMVO;

public interface MemberMService {

	List<MemberMVO> getMemberList(MemberMVO mvo);

	int memberListCnt(MemberMVO mvo);

	MemberMVO memberDetail(MemberMVO mvo);

	int deleteMember(MemberMVO mvo);

}
