package com.dotori.client.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dotori.client.member.service.MemberService;
import com.dotori.client.member.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor			// ��� ��ü ���� ����
public class MemberController {

	private MemberService memberService;

	// �α��� ȭ������ ����
	@RequestMapping(value="/login")
	public String memberLogin() {
		return "member/memberLogin";
	}
	
	// ȸ������ ȭ������ ����
	@RequestMapping(value="/join")
	public String memberJoin() {
		return "member/memberJoin";
	}
	
	// ȸ������ �� ID �ߺ�üũ ��ư ��Ʈ�ѷ�
	@ResponseBody
	@RequestMapping(value="/idCheck", produces="text/plain; charset=UTF-8")
	public String idCheck(@ModelAttribute MemberVO mvo) {
		log.info("idCheck ȣ�� ����");
		
		int result = 0;
		String member_id=mvo.getMember_id();
		String value="";
		
		result = memberService.idCheck(member_id);
		
	    if(result==0) {
	    	value="����";
	    }else {
	    	value="����";
	    }
	    
		return value;
	}
}
