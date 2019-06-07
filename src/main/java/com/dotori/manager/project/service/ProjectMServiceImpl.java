package com.dotori.manager.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dotori.manager.project.dao.ProjectMDao;
import com.dotori.manager.project.vo.ProjectMVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
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
	@Override
	public int projectDelect(Integer project_num) {
		ProjectMVO delpvo = projectDao.getAllData(project_num);
		log.info(delpvo);
		
		//�󼼳����� �̾Ƴ����� 4���� ���̺�� 3���� �������� ������ش�.
		int result =0;
		result = projectDao.projectDelContent(delpvo);
		result = projectDao.projectDelOption(delpvo);
		result = projectDao.projectDelQna_board(delpvo);
		result = projectDao.projectDelReply(delpvo);
		result = projectDao.projectDelContentSeq(delpvo);
		result = projectDao.projectDelQna_boardSeq(delpvo);
		result = projectDao.projectDelReplySeq(delpvo);
		//����� ���� ���� �־� �ش�.
		result = projectDao.projectDel(delpvo);
		return result;
	}
}
