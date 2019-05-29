package com.dotori.client.project.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.dotori.client.project.dao.ProjectDao;
import com.dotori.client.project.vo.ProjectVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ProjectServiceImpl implements ProjectService{

	private ProjectDao projectDao;
	
	@Override
	public ArrayList<ProjectVO> getPatterns(String project_pattern1) {
		ArrayList<ProjectVO> list = projectDao.getPatterns(project_pattern1);
		return list;
	}



}
