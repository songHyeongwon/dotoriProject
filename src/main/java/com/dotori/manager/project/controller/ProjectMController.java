package com.dotori.manager.project.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dotori.client.project.service.ProjectService;
import com.dotori.client.project.vo.ProjectVO;
import com.dotori.common.vo.PageDTO;
import com.dotori.manager.project.service.ProjectMService;
import com.dotori.manager.project.vo.ProjectMVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/projectManager/*")
@Log4j
@Controller
@AllArgsConstructor
public class ProjectMController {
	
	private ProjectMService projectMService;
	private ProjectService projectService;
	@RequestMapping(value="/projectManagerForm")
	public String projectInsertFrom(@ModelAttribute ProjectMVO pvo,Model model) {
		log.info("������������ ����Ʈ�� ���Խ��ϴ�.");
		List<ProjectMVO> list = projectMService.getProjectList(pvo);
		model.addAttribute("list", list);
		
		int total = projectMService.projectListCnt(pvo);
		
		log.info("�� Į�� ������ = "+total);
		model.addAttribute("pageMaker",new PageDTO(pvo,total,10));
		
		
		return "projectManager/projectManager";
	}
	
	@RequestMapping(value="/detail",method=RequestMethod.POST)
	public String projectDetail(@ModelAttribute ProjectVO pvo, Model model){
		log.info("�� �� = "+pvo);
		log.info("detail������ ȣ��");
		ProjectVO result = projectService.projectDetail(pvo);
		model.addAttribute("project", result);
		
		log.info(result);
		
		return "projectManager/projectDetail";
	}
	
	@PostMapping(value = "/yes/{project_num}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> projectStatusYes(@PathVariable("project_num") Integer project_num) {
		log.info("������Ʈ ���� ������"+project_num);
		int result = projectMService.projectStatusYes(project_num);
		
		return result == 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/no/{project_num}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> projectStatusNo(@PathVariable("project_num") Integer project_num) {
		log.info("������Ʈ ���� ������"+project_num);
		int result = projectMService.projectStatusNo(project_num);
		
		return result == 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/del/{project_num}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> projectDelect(@PathVariable("project_num") Integer project_num) {
		log.info("������Ʈ ���� ������"+project_num);
		int result = projectMService.projectDelect(project_num);
		
		return result == 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(value = "/allYes")
	public String projectStatusAllYes(@RequestBody List<Integer> project_num) {
		log.info("��ü ó���� ���Խ��ϴ�.");
		log.info(project_num);
		return "projectManager/projectManager";
	}
}
