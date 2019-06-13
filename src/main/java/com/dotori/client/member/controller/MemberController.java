package com.dotori.client.member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dotori.client.member.email.Email;
import com.dotori.client.member.email.EmailSender;
import com.dotori.client.member.service.MemberService;
import com.dotori.client.member.vo.MemberVO;
import com.dotori.client.project.vo.ProjectVO;
import com.dotori.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor			// ��� ��ü ���� ����
public class MemberController {

	private MemberService memberService;
	
	@Autowired
	private EmailSender emailSender;
	
	@Autowired
	private Email email;
	
	// �α��� ȭ������ ����
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String memberLogin() {
		return "member/memberLogin";
	}
	
	// ȸ������ ȭ������ ����
	@RequestMapping(value="/join",method=RequestMethod.GET)
	public String memberJoin() {
		return "member/memberJoin";
	}
	
	// ȸ���� ������������ �̵�
	@RequestMapping(value="/memberMyPage",method=RequestMethod.GET)
	public String memberMyPage() {
		return "member/memberMyPage";
	}
	
	// ���������� ������������ ������ �� ��й�ȣ Ȯ�� ȭ������ ����
	@GetMapping(value="/confirmPassword")
	public String confirmPassword() {
		return "member/passwordConfirm";
	}
	
	// ���� ���� ���� �������� �̵�
	@RequestMapping(value="/personalModify")
	public String personalModify() {
		return "member/personalModify";
	}
	
	// ���̵� ã�� �������� �̵�
	@RequestMapping(value="/idSearch")
	public String idSearch() {
		return "member/idSearch";
	}
	
	// ��й�ȣ ã�� �������� �̵�
	@RequestMapping(value="/passwordSearch")
	public String passwordSearch() {
		log.info("�� �ȵ�?");
		return "member/passwordSearch";
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
	
	
	// ȸ������ ��Ʈ�ѷ�
	@ResponseBody
	@RequestMapping(value="/memberJoin",method=RequestMethod.POST,produces="text/plain; charset=UTF-8")
	public String memberJoin(@ModelAttribute MemberVO mvo, Model model) {
		int result = 0;
		
		result=memberService.memberJoin(mvo);
		if(result==1) {
			model.addAttribute("success",1);
			return "����";
		}else {
			return "����";
		}
		
	}
	
	
	// �α��� ��Ʈ�ѷ�
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
			mav.setViewName("redirect:/");		// redirect : ���ϴ� �ּ� = '���ϴ� �ּ�'�� ���������� �̵���Ų��.
			return mav;
		}		
	}
	
	// ȸ���� �α׾ƿ����� ���� session�� ���
	@ResponseBody
	@PostMapping(value="memberLogout", produces="text/plain; charset=UTF-8")
	public String memberLogout(@ModelAttribute MemberVO mvo,HttpSession session) {
		session.invalidate();
		
		return "����";
	}
		
	// ��й�ȣ Ȯ�� â ��Ʈ�ѷ�
	@ResponseBody
	@PostMapping(value="/passwordConfirm", produces="text/plain; charset=UTF-8")
	public String passwordConfirm(@ModelAttribute MemberVO mvo,Model model) {
		
		int result=memberService.passwordConfirm(mvo);
		
		if(result==1) {
			return "����";
		}else {
			return "����";
		}
	}
	
	
	// ȸ�� ���� ��Ʈ�ѷ�
	@ResponseBody
	@PostMapping(value="/memberUpdate", produces="text/plain; charset=UTF-8")
	public String memberUpdate(@ModelAttribute MemberVO mvo) {
		
		int result=memberService.memberUpdate(mvo);
		
		if(result==1) {
			return "����";
		}else {
			return "����";
		}
	}
	
	// ���������� '���� ���� �ݵ�' Ŭ�� �� ��Ʈ�ѷ�
	@ResponseBody
	@RequestMapping(value="/myFunding",produces="text/plain; charset=UTF-8")
	public String memberFunding(@ModelAttribute MemberVO mvo,Model model) {
		String member_id = mvo.getMember_id();
		
		String listData = memberService.myFunding(member_id);
		
		// ���ڵ� ���� ã��
		/*int memberTotal = memberService.memberListCnt(member_id);
		model.addAttribute("pageMaker",new PageDTO(mvo, memberTotal, 10));*/
	
		return listData;
		
	}
	
	// ���������� '����� ���丮 ����' Ŭ�� �� ȭ�� ��� ��Ʈ�ѷ�
	@ResponseBody
	@PostMapping(value="/usingDotori",produces="text/plain; charset=UTF-8")
	public String usingDotori(@ModelAttribute MemberVO mvo, Model model) {
		String member_id = mvo.getMember_id();
		
		String listData = memberService.usingDotori(member_id);
		
		return listData;
	}
	
	// ȸ�� Ż�� ��Ʈ�ѷ�
	@ResponseBody
	@RequestMapping(value="/deleteMember", produces = "text/plain; charset=UTF-8")
	public String deleteMember(Model model,HttpSession session) {
			
		MemberVO mvo = (MemberVO)session.getAttribute("data");
		
		String member_id = mvo.getMember_id();
		
		int result = memberService.deleteMember(member_id);
		
		if(result==1) {
			session.invalidate();
			return "����";
		}else {
			return "����";
		}
	}
	
	// ȸ�� ���� �� �� ��й�ȣ�� ������ Ȯ���ϴ� ��Ʈ�ѷ�
	@ResponseBody
	@PostMapping(value="/confirmPwd", produces="text/plain; charset=UTF-8")
	public String confirmPwd(@ModelAttribute MemberVO mvo) {
		int result = memberService.updatePasswordConfirm(mvo);
		
		if(result==1) {
			return "����";
		}else {
			return "����";
		}
	}
	
	// ���� ���������� ���丮 ���� �� ���Ǵ� ��Ʈ�ѷ�
	@ResponseBody
	@PostMapping(value="/dotoriCharge",produces="text/plain; charset=UTF-8")
	public String dotoriCharge(@ModelAttribute MemberVO mvo,HttpSession session) {
		int result = memberService.dotoriCharge(mvo);
		MemberVO mvo2 = (MemberVO)session.getAttribute("data");
		mvo2.setMember_point(mvo.getMember_point()+mvo.getMember_pointCharge());
		
		session.setAttribute("data", mvo2);
		if(result==1) {
			return "����";
		}else {
			return "����";
		}
	}
	
	// �̸��� üũ ��Ʈ�ѷ�
	@ResponseBody
	@RequestMapping(value="/emailCheck",produces="text/plain; charset=UTF-8")
	public String emailCheck(@ModelAttribute MemberVO mvo, Model model) {
		String member_eMail = mvo.getMember_eMail();
		log.info("member_eMail : "+member_eMail);
		
		int result = memberService.emailCheck(member_eMail);
		
		if(result==1) {
			return "����";
		}else {
			return "����";
		}
	}
	
	// �̸��� ���̵� ����
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
			email.setContent("���̵�� " + member_id+" �Դϴ�.");
			email.setReceiver(member_eMail);
			email.setSubject(member_name+"�� Dotori's Funding ���̵� ã�� �����Դϴ�.");
			emailSender.SendEmail(email);	
			return "����";
		}else {
			return "����";
		}
	}
	
	// �̸���,���̵� Ȯ�� ��Ʈ�ѷ�
	@ResponseBody
	@RequestMapping(value="/eMailIdCheck",produces="text/plain; charset=UTF-8")
	public String eMailIdCheck(@ModelAttribute MemberVO mvo, Model model) {
		log.info("eMailIdCheck ��Ʈ�ѷ�");
		log.info(mvo.getMember_id());
		log.info(mvo.getMember_eMail());
		
		int result = memberService.eMailIdCheck(mvo);
		
		if(result==1) {
			return "����";
		}else {
			return "����";
		}
	}
	
	// �̸��� ��й�ȣ ����
	@ResponseBody
	@RequestMapping(value="/logPasswordCheck",produces="text/plain; charset=UTF-8")
	public String logPasswordCheck(@ModelAttribute MemberVO mvo,Model model) throws Exception{
		String member_eMail = mvo.getMember_eMail();
		String member_id = mvo.getMember_id();
		String member_pwd = memberService.logPasswordCheck(mvo);
		
		log.info(member_id);
		
		if(member_pwd!=null) {
			email.setContent("��й�ȣ�� " + member_pwd+" �Դϴ�.");
			email.setReceiver(member_eMail);
			email.setSubject(member_id+"�� Dotori's Funding ��й�ȣ ã�� �����Դϴ�.");
			emailSender.SendEmail(email);		
			return "����";
		}else {
			return "����";
		}
	}
}
