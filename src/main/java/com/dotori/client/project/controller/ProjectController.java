package com.dotori.client.project.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dotori.client.project.service.ProjectService;
import com.dotori.client.project.vo.ProjectVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/project/*")
@Log4j
@Controller
@AllArgsConstructor
public class ProjectController {
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
	
	
}
