package com.dotori.manager.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dotori.manager.project.dao.ProjectMDao;
import com.dotori.manager.project.vo.ProjectMVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ProjectMServiceImpl implements ProjectMService{
	private ProjectMDao projectDao;
	@Override
	public List<ProjectMVO> getProjectList(ProjectMVO pvo) {
		List<ProjectMVO> list = projectDao.getProjectList(pvo);
		return list;
	}
	@Override
	public int projectListCnt(ProjectMVO pvo) {
		int result = projectDao.projectListCnt(pvo);
		return result;
	}
	@Override
	public int projectStatusYes(Integer project_num) {
		int result = projectDao.projectStatusYes(project_num);
		return result;
	}
	@Override
	public int projectStatusNo(Integer project_num) {
		int result = projectDao.projectStatusNo(project_num);
		return result;
	}

}
