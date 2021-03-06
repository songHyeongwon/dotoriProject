package com.dotori.manager.project.service;

import java.util.List;

import com.dotori.manager.project.vo.ProjectMVO;

public interface ProjectMService {

	public List<ProjectMVO> getProjectList(ProjectMVO pvo);

	public int projectListCnt(ProjectMVO pvo);
	public int projectStatusYes(Integer project_num);

	public int projectStatusNo(Integer project_num);

	public int projectDelect(Integer project_num);

	public int projectStatusAllYes(List<Integer> project_nums);

	public int projectStatusAllNo(List<Integer> project_nums);

}
