package com.dotori.manager.project.dao;

import java.util.List;

import com.dotori.manager.project.vo.ProjectMVO;

public interface ProjectMDao {

	public List<ProjectMVO> getProjectList(ProjectMVO pvo);

	public int projectListCnt(ProjectMVO pvo);

	public int projectStatusYes(Integer project_num);

	public int projectStatusNo(Integer project_num);

	public int projectDelect(Integer project_num);

	public ProjectMVO getAllData(ProjectMVO project_num);

}
