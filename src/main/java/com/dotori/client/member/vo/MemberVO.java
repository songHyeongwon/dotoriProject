package com.dotori.client.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private int member_num=0;				// 회원 번호
	private String member_id="";			// 회원 아이디
	private String member_pwd="";			// 회원 비밀번호
	private String member_name="";			// 회원 이름
	private String member_address="";		// 회원 주소
	private String member_phone="";		// 회원 번호
	private String member_eMail="";		// 회원 이메일
	private int member_kind=0;			// 법인,개인 구분
	private String member_sigNum="";		// 회원 주민번호 or 사업자 번호
	private String member_point="";		// 회원 도토리 개수
	private Date member_addDate;		// 회원 등록일
	private Date member_mPwdDate;		// 회원 비밀번호 변경일
	private String member_nickName="";		// 회원 닉네임
	private int member_infoAgree=0;		// 회원 정보처리 동의여부
	private int member_evenAgree=0;		// 회원 메시지,이메일에 정보를 주기 위한 동의여부
	private String member_detailAddress="";	// 회원 상세 주소
	private int member_chPwd=0;			// 회원 비밀번호 변경 확인 
}
