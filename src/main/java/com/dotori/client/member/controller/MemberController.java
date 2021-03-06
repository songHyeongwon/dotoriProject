package com.dotori.client.member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dotori.client.member.email.Email;
import com.dotori.client.member.email.EmailSender;
import com.dotori.client.member.service.MemberService;
import com.dotori.client.member.vo.MemberVO;
import com.dotori.common.vo.PageDTO;
import com.dotori.manager.orders.vo.OrdersMVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor			// 모든 객체 만들어서 주입
public class MemberController {

	private MemberService memberService;
	
	@Autowired
	private EmailSender emailSender;
	
	@Autowired
	private Email email;
	
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
	
	// 아이디 찾기 페이지로 이동
	@RequestMapping(value="/idSearch")
	public String idSearch() {
		return "member/idSearch";
	}
	
	// 비밀번호 찾기 페이지로 이동
	@RequestMapping(value="/passwordSearch")
	public String passwordSearch() {
		return "member/passwordSearch";
	}
	
	// 사용한 도토리 내역 페이지 출력
	@RequestMapping(value="/usingDotori")
	public String usingDotori() {
		return "member/usingDotori";
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
	public String memberJoin(@ModelAttribute MemberVO mvo) {
		int result = 0;
		
		result=memberService.memberJoin(mvo);
		if(result==1) {
			return "성공";
		}else if(result==2){
			return "이메일";
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
		log.info("반환되어 오는값"+result);
		if(result==1) {
			return "성공";
		}else {
			return "실패";
		}
	}
	
	
	// 회원 수정 컨트롤러
	@ResponseBody
	@PostMapping(value="/memberUpdate", produces="text/plain; charset=UTF-8")
	public String memberUpdate(@ModelAttribute MemberVO mvo,HttpSession session) {
		
		MemberVO mvo1 = (MemberVO)session.getAttribute("data");
		
		
		log.info(mvo.toString());
		int result=memberService.memberUpdate(mvo);
		
		mvo1.setMember_pwd(mvo.getMember_pwd());
		mvo1.setMember_nickName(mvo.getMember_nickName());
		mvo1.setMember_eMail(mvo.getMember_eMail());
		mvo1.setMember_phone(mvo.getMember_phone());
		mvo1.setMember_address(mvo.getMember_address());
		mvo1.setMember_detailAddress(mvo.getMember_detailAddress());
		mvo1.setMember_evenAgree(mvo.getMember_evenAgree());
		
		session.setAttribute("data", mvo1);
		
		if(result==1) {
			return "성공";
		}else {
			return "실패";
		}
	}
	
	// 마이페이지 '내가 만든 펀딩' 클릭 시 컨트롤러
	@ResponseBody
	@RequestMapping(value="/myFunding",produces="text/plain; charset=UTF-8")
	public String memberFunding(@ModelAttribute MemberVO mvo,Model model) {
		String member_id = mvo.getMember_id();
		
		String listData = memberService.myFunding(member_id);
		
		// 레코드 숫자 찾기
		/*int memberTotal = memberService.memberListCnt(member_id);
		model.addAttribute("myFundPageMaker",new PageDTO(mvo, memberTotal, 10));*/
	
		return listData;
		
	}
	
	// 마이페이지 '사용한 도토리 내역' 클릭 시 화면 출력 컨트롤러
	@ResponseBody
	@RequestMapping(value="/usingDotoriList",produces="text/plain; charset=UTF-8")
	public String usingDotori(@ModelAttribute MemberVO mvo, Model model) {
		log.info("usingDotoriList 출력");
		String member_id = mvo.getMember_id();
		log.info(member_id);
		String listData = memberService.usingDotori(member_id);
		
		return listData;
	}
	
	// 마이페이지 '펀딩중' 클릭 시 화면 출력 컨트롤러
	@ResponseBody
	@RequestMapping(value="/fundingProcess",produces="text/plain; charset=UTF-8")
	public String fundingProcess(@ModelAttribute MemberVO mvo,Model model) {
		log.info("fundingProcess 출력");
		
		String member_id = mvo.getMember_id();
		
		String listData = memberService.fundingProcess(member_id);
		
		int memberTotal = memberService.memberfundingListCnt(member_id);
		log.info(mvo.getPageNum());
		log.info(mvo.getAmount());
		model.addAttribute("fundingPageMaker",new PageDTO(mvo, memberTotal, 10));
		
		return listData;
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
	@RequestMapping(value="/dotoriCharge",produces="text/plain; charset=UTF-8")
	public String dotoriCharge(@ModelAttribute MemberVO mvo,HttpSession session) {
		log.info("들어왔니????");
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
	
	// 이메일 체크 컨트롤러
	@ResponseBody
	@RequestMapping(value="/emailCheck",produces="text/plain; charset=UTF-8")
	public String emailCheck(@ModelAttribute MemberVO mvo, Model model) {
		String member_eMail = mvo.getMember_eMail();
		log.info("member_eMail : "+member_eMail);
		
		int result = memberService.emailCheck(member_eMail);
		
		if(result==1) {
			return "성공";
		}else {
			return "실패";
		}
	}
	
	// 이메일 아이디 전송
	@ResponseBody
	@RequestMapping(value="/logIdCheck",produces="text/plain; charset=UTF-8")
	public String logIdCheck(@ModelAttribute MemberVO mvo,Model model) throws Exception{
		ModelAndView mav;
		String member_eMail = mvo.getMember_eMail(); 
		
		MemberVO mvoSId = memberService.logIdCheck(mvo);
		
		String member_id = mvoSId.getMember_id();
		String member_name = mvoSId.getMember_name();
		
		log.info(member_id);
		
		if(member_id!=null) {
			email.setContent("아이디는 " + member_id+" 입니다.");
			email.setReceiver(member_eMail);
			email.setSubject(member_name+"님 Dotori's Funding 아이디 찾기 메일입니다.");
			emailSender.SendEmail(email);	
			return "성공";
		}else {
			return "실패";
		}
	}
	
	// 이메일,아이디 확인 컨트롤러
	@ResponseBody
	@RequestMapping(value="/eMailIdCheck",produces="text/plain; charset=UTF-8")
	public String eMailIdCheck(@ModelAttribute MemberVO mvo, Model model) {
		log.info("eMailIdCheck 컨트롤러");
		log.info(mvo.getMember_id());
		log.info(mvo.getMember_eMail());
		
		int result = memberService.eMailIdCheck(mvo);
		
		if(result==1) {
			return "성공";
		}else {
			return "실패";
		}
	}
	
	// 이메일 비밀번호 전송
	@ResponseBody
	@RequestMapping(value="/logPasswordCheck",produces="text/plain; charset=UTF-8")
	public String logPasswordCheck(@ModelAttribute MemberVO mvo,Model model) throws Exception{
		String member_eMail = mvo.getMember_eMail();
		String member_id = mvo.getMember_id();
		String member_pwd = memberService.logPasswordCheck(mvo);
		
		log.info(member_id);
		
		if(member_pwd!=null) {
			email.setContent("비밀번호는 " + member_pwd+" 입니다.");
			email.setReceiver(member_eMail);
			email.setSubject(member_id+"님 Dotori's Funding 비밀번호 찾기 메일입니다.");
			emailSender.SendEmail(email);		
			return "성공";
		}else {
			return "실패";
		}
	}
	
	// 마이 페이지 '사용한 도토리 내역' 환불 요청 
	@ResponseBody
	@RequestMapping(value="/refund", produces="text/plain; charset=UTF-8")
	public String refund(@ModelAttribute OrdersMVO omvo,HttpSession session) {
		int orders_num = omvo.getOrders_num();
		MemberVO mvo = (MemberVO)session.getAttribute("data");
		
		log.info("변경 전 : " +mvo.getMember_point());
		
		mvo.setMember_point(mvo.getMember_point()+omvo.getOrders_price());
		
		log.info("변경 후 : "+mvo.getMember_point());
		
		session.setAttribute("data", mvo);
		
		MemberVO mvo1 = (MemberVO)session.getAttribute("data");
		
		log.info("갱신 후 : " +mvo1.getMember_point());
		
		try {
			memberService.refund(orders_num);
			return "성공/"+mvo1.getMember_point();
		}catch(Exception e) {
			e.printStackTrace();
			return "실패";
		}
	}
}
