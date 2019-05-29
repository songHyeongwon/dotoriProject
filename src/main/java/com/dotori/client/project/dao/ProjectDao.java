package com.dotori.client.project.dao;

import java.util.ArrayList;

import com.dotori.client.project.vo.ProjectVO;

public interface ProjectDao {

	public ArrayList<ProjectVO> getPatterns(String project_pattern1);

}
