package com.dotori.client.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dotori.client.member.service.MemberService;
import com.dotori.client.member.vo.MemberVO;
import com.dotori.client.project.vo.ProjectVO;

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
	
	// 회원의 마이페이지로 이동
	@RequestMapping(value="/memberMyPage",method=RequestMethod.GET)
	public String memberMyPage() {
		return "member/memberMyPage";
	}
	
	// 마이페이지 개인정보수정 눌렀을 시 비밀번호 확인 화면으로 변경
	@GetMapping(value="/confirmPassword")
	public String confirmPassword() {
		return "member/passwordConfirm";
	}
	
	// 개인 정보 수정 페이지로 이동
	@RequestMapping(value="/personalModify")
	public String personalModify() {
		return "member/personalModify";
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
	
	
	// 회원가입 컨트롤러
	@ResponseBody
	@RequestMapping(value="/memberJoin",method=RequestMethod.POST,produces="text/plain; charset=UTF-8")
	public String memberJoin(@ModelAttribute MemberVO mvo, Model model) {
		int result = 0;
		
		result=memberService.memberJoin(mvo);
		if(result==1) {
			model.addAttribute("success",1);
			return "성공";
		}else {
			return "실패";
		}
		
	}
	
	
	// 로그인 컨트롤러
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
			//mav.setViewName("member/loginSuccess");
			mav.setViewName("redirect:/");		// redirect : 원하는 주소 = '원하는 주소'로 강제적으로 이동시킨다.
			return mav;
		}		
	}
	
	// 회원의 로그아웃으로 인한 session값 상실
	@ResponseBody
	@PostMapping(value="memberLogout", produces="text/plain; charset=UTF-8")
	public String memberLogout(@ModelAttribute MemberVO mvo,HttpSession session) {
		session.invalidate();
		
		return "성공";
	}
		
	// 비밀번호 확인 창 컨트롤러
	@ResponseBody
	@PostMapping(value="/passwordConfirm", produces="text/plain; charset=UTF-8")
	public String passwordConfirm(@ModelAttribute MemberVO mvo,Model model) {
		
		int result=memberService.passwordConfirm(mvo);
		
		if(result==1) {
			return "성공";
		}else {
			return "실패";
		}
	}
	
	
	// 회원 수정 컨트롤러
	@ResponseBody
	@PostMapping(value="/memberUpdate", produces="text/plain; charset=UTF-8")
	public String memberUpdate(@ModelAttribute MemberVO mvo) {
		
		int result=memberService.memberUpdate(mvo);
		
		if(result==1) {
			return "성공";
		}else {
			return "실패";
		}
	}
	
	// 마이페이지 '펀딩 중' 클릭 시 컨트롤러
	@ResponseBody
	@PostMapping(value="/memberFunding",produces="text/plain; charset=UTF-8")
	public String memberFunding(@ModelAttribute MemberVO mvo,Model model) {
		String member_id = mvo.getMember_id();
		
		int result = memberService.memberFunding(member_id);
		
		
		if(result==1) {
			return "성공";
		}else {
			return "실패";
		}
		
	}
	
	// 마이페이지 '사용한 도토리 내역' 클릭 시 화면 출력 컨트롤러
	@PostMapping(value="/usingDotori")
	public String usingDotori(@ModelAttribute MemberVO mvo, Model model) {
		String member_id = mvo.getMember_id();
		
		int result = memberService.usingDotori(member_id);
		
		model.addAttribute("judge",result);
		
		return "member/usingDotori";
	}
	
	// 회원 탈퇴 컨트롤러
	@ResponseBody
	@RequestMapping(value="/deleteMember", produces = "text/plain; charset=UTF-8")
	public String deleteMember(Model model,HttpSession session) {
			
		MemberVO mvo = (MemberVO)session.getAttribute("data");
		
		String member_id = mvo.getMember_id();
		
		int result = memberService.deleteMember(member_id);
		
		if(result==1) {
			session.invalidate();
			return "성공";
		}else {
			return "실패";
		}
	}
	
	// 회원 수정 시 전 비밀번호와 같은지 확인하는 컨트롤러
	@ResponseBody
	@PostMapping(value="/confirmPwd", produces="text/plain; charset=UTF-8")
	public String confirmPwd(@ModelAttribute MemberVO mvo) {
		int result = memberService.updatePasswordConfirm(mvo);
		
		if(result==1) {
			return "성공";
		}else {
			return "실패";
		}
	}
	
	// 마이 페이지에서 도토리 충전 시 사용되는 컨트롤러
	@ResponseBody
	@PostMapping(value="/dotoriCharge",produces="text/plain; charset=UTF-8")
	public String dotoriCharge(@ModelAttribute MemberVO mvo,HttpSession session) {
		int result = memberService.dotoriCharge(mvo);
		MemberVO mvo2 = (MemberVO)session.getAttribute("data");
		mvo2.setMember_point(mvo.getMember_point()+mvo.getMember_pointCharge());
		
		session.setAttribute("data", mvo2);
		if(result==1) {
			return "성공";
		}else {
			return "실패";
		}
	}
	
}
