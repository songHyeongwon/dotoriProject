package com.dotori.manager.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/projectManager/*")
@Log4j
@Controller
@AllArgsConstructor
public class ProjectMController {
	@RequestMapping(value="/insertForm")
	public String projectInsertFrom() {
		return "projectManager/projectManager";
	}
}
