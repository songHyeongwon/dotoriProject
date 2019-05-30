package com.dotori.client.member.controller;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String memberLogin() {
		return "member/memberLogin";
	}
	
	// 회원가입 화면으로 전송
	@RequestMapping(value="/join",method=RequestMethod.GET)
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
	
	@RequestMapping(value="/memberJoin",method=RequestMethod.POST)
	public String memberJoin(@ModelAttribute MemberVO mvo, Model model) {
		int result = 0;
		String url="";
		
		result=memberService.memberJoin(mvo);
		if(result==1) {
			model.addAttribute("success",1);
			url="/member/memberLogin";
		}else {
			url="/member/memberJoin";
		}
		
		return url; 
		
	}
	
	@PostMapping(value="/session")
	public ModelAndView session(@ModelAttribute MemberVO mvo, ModelAndView mav,HttpSession session) {
		
		MemberVO result;
		
		String member_id = mvo.getMember_id();
		String member_pwd = mvo.getMember_pwd();
		
		result=memberService.memberSession(member_id,member_pwd);
		
		if(result==null) {
			mav.addObject("codeNumber",1);
			mav.setViewName("member/memberLogin");
			return mav;
		}else {
			session.setAttribute("data", result);
			mav.addObject("login",result);
			mav.setViewName("member/loginSuccess");
			return mav;
		}		
	}
}
