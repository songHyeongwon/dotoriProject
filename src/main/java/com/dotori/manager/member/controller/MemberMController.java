package com.dotori.manager.member.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dotori.client.project.vo.ReplyVO;
import com.dotori.common.vo.PageDTO;
import com.dotori.manager.member.service.MemberMService;
import com.dotori.manager.member.vo.MemberMVO;
import com.dotori.manager.project.vo.ProjectMVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/memberManager/*")
@Log4j
@Controller
@AllArgsConstructor
public class MemberMController {
	private MemberMService memberMService;
	
	@RequestMapping(value="/memberManagerForm")
	public String memberManagerForm(@ModelAttribute MemberMVO mvo, Model model) {
		log.info("관리자페이지 리스트에 들어왔습니다.");
		List<MemberMVO> list = memberMService.getMemberList(mvo);
		model.addAttribute("list", list);
		
		int total = memberMService.memberListCnt(mvo);
		
		log.info("총 칼럼 갯수는 = "+total);
		model.addAttribute("pageMaker",new PageDTO(mvo,total,10));
		
		return "memberManager/memberManager";
	}
	
	@ResponseBody
	@RequestMapping(value="detail/{member_num}",produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<MemberMVO> memberDetail(@PathVariable("member_num") int member_num) {
		MemberMVO mvo= new MemberMVO();
		mvo.setMember_num(member_num);
		
		mvo = memberMService.memberDetail(mvo);
		ResponseEntity<MemberMVO> entity = null;
		entity = new ResponseEntity<>(mvo, HttpStatus.OK);
		return entity;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/del/{member_num}")
	public String deleteMember(@PathVariable("member_num") int member_num) {
		System.out.println("삭제할 번호 = "+member_num);
		log.info("삭제할 번호는 = "+member_num);
		MemberMVO mvo= new MemberMVO();
		mvo.setMember_num(member_num);
		int result = memberMService.deleteMember(mvo);
		if(result==1) {
			return "SUCCESS";
		}else {
			return "NO";
		}
	}
}
