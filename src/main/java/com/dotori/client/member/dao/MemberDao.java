package com.dotori.client.member.dao;

import java.util.List;
import java.util.Map;

import com.dotori.client.member.vo.MemberVO;
import com.dotori.client.orders.vo.OrdersVO;
import com.dotori.client.project.vo.ProjectVO;

public interface MemberDao {

	public int idCheck(String member_id);

	public int memberJoin(MemberVO mvo);

	public MemberVO memberSession(MemberVO ivo);

	public int passwordConfirm(MemberVO mvo);

	public int memberUpdate(MemberVO mvo);

	public List<ProjectVO> myFunding(String member_id);

	public List<OrdersVO> usingDotori(String member_id);

	public int deleteMember(MemberVO mvo);

	public int deleteMemberInsert(MemberVO mvo);

	public int updatePasswordConfirm(MemberVO mvo);

	public MemberVO memberAll(String member_id);

	public int dotoriCharge(MemberVO mvo);

	//public int memberListCnt(String member_id);

	public int emailCheck(String member_eMail);

	public MemberVO logIdCheck(MemberVO mvo);

	public String logPasswordCheck(MemberVO mvo);

	public List<ProjectVO> fundingProcess(String member_id);

	public int refund(int orders_num);

	//public int memberfundingListCnt(String member_id);

}
