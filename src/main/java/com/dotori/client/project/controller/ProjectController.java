package com.dotori.client.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dotori.client.project.service.ProjectService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/project/*")
@Log4j
@Controller
@AllArgsConstructor
public class ProjectController {
	//������Ʈ ����
	private ProjectService ProjectService;
	
	//������Ʈ�� insertForm���� ����
	@RequestMapping(value="/insertForm")
	public String projectInsertFrom() {
		return "project/projectInsert";
	}
}
