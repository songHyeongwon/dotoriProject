package com.dotori.client.project.service;

import java.util.ArrayList;

import com.dotori.client.project.vo.ProjectVO;

public interface ProjectService {

	public ArrayList<ProjectVO> getPatterns(String project_pattern1);

}
