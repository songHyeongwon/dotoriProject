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
@AllArgsConstructor			// 모든 객체 만들어서 주입
public class MemberController {

	private MemberService memberService;

	// 로그인 화면으로 전송
	@RequestMapping(value="/login")
	public String memberLogin() {
		return "member/memberLogin";
	}
	
	// 회원가입 화면으로 전송
	@RequestMapping(value="/join")
	public String memberJoin() {
		return "member/memberJoin";
	}
	
	// 회원가입 중 ID 중복체크 버튼 컨트롤러
	@ResponseBody
	@RequestMapping(value="/idCheck", produces="text/plain; charset=UTF-8")
	public String idCheck(@ModelAttribute MemberVO mvo) {
		log.info("idCheck 호출 성공");
		
		int result = 0;
		String member_id=mvo.getMember_id();
		String value="";
		
		result = memberService.idCheck(member_id);
		
	    if(result==0) {
	    	value="성공";
	    }else {
	    	value="실패";
	    }
	    
		return value;
	}
}
