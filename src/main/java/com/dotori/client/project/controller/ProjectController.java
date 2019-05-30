package com.dotori.client.project.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.dotori.client.project.service.ProjectService;
import com.dotori.client.project.vo.ContentVO;
import com.dotori.client.project.vo.OptionVO;
import com.dotori.client.project.vo.ProjectVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/project/*")
@Log4j
@Controller
@AllArgsConstructor
public class ProjectController {
	
	@InitBinder
	public void initBiner(WebDataBinder binder) {
		binder.registerCustomEditor(MultipartFile.class, "file", new StringTrimmerEditor(true));
	}
	//������Ʈ ����
	private ProjectService projectService;
	
	//������Ʈ�� insertForm���� ����
	@RequestMapping(value="/insertForm")
	public String projectInsertFrom() {
		//������ �����ϸ� �������� ���ϵ��� ���� �޾Ƽ� �������ش�.
		//ArrayList<ProjectVO> list = projectService.getPatterns();
		//projectInsert.jsp���� ���� �����´�.
		//model.addAttribute("Patterns",list);
		
		return "project/projectInsert";
	}
	
	//�Һз� ����� �ҷ����̴� �޼���
	@GetMapping(value="/getPatterns/{Project_pattern1}", produces = {MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE } )
	public ResponseEntity<List<ProjectVO>> getPatterns(@PathVariable("Project_pattern1") String project_pattern1) {
		
		log.info("���ð� ȣ�� = "+project_pattern1);
		ResponseEntity<List<ProjectVO>> entity = null;
		entity = new ResponseEntity<>(projectService.getPatterns(project_pattern1), HttpStatus.OK);
		return entity;
	}
	
	
	@RequestMapping(value="/insertProject")
	public String projectInsert(@ModelAttribute ProjectVO pvo) {
		log.info("insert �ȿ� ��� �Խ��ϴ�.");
		log.info("���°�"+pvo);
		
		//pkŰ ��������
		int Pknum = projectService.getProjectPKNum();
		
		String id = pvo.getMember_id();
		pvo.setProject_num(Pknum);
		pvo.setReply_table_name(id+"_"+Pknum+"_reply");
		pvo.setOption_table_name(id+"_"+Pknum+"_option");
		pvo.setContent_table_name(id+"_"+Pknum+"_content");
		pvo.setQna_board_table_name(id+"_"+Pknum+"_qna_board");
		
		//���� ���̺� �����ϱ�
		int result = 0;
		result = projectService.createContentTable(pvo);
		result = projectService.createReplyTable(pvo);
		result = projectService.createOptionTable(pvo);
		result = projectService.createQna_boardTable(pvo);
		
		result = projectService.createContentTableSeq(pvo);
		result = projectService.createReplyTableSeq(pvo);
		result = projectService.createQna_boardTableSeq(pvo);
		
		result = projectService.insertProject(pvo);
		result = projectService.insertProjectContentTable(pvo);
		result = projectService.insertProjectOptionTable(pvo);
		
		return "index";
	}
}
