package com.dotori.manager.project.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@RequestMapping(value="/projectManagerForm")
	public String projectInsertFrom(Model model) {
		log.info("관리자페이지 리스트에 들어왔습니다.");
		List<ProjectMVO> list = projectMService.getProjectList();
		model.addAttribute("list", list);
		return "projectManager/projectManager";
	}
}
