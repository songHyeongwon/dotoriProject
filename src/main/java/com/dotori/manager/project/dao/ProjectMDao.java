package com.dotori.manager.project.dao;

import java.util.List;

import com.dotori.manager.project.vo.ProjectMVO;

public interface ProjectMDao {

	public List<ProjectMVO> getProjectList(ProjectMVO pvo);

	public int projectListCnt(ProjectMVO pvo);

	public int projectStatusYes(Integer project_num);

	public int projectStatusNo(Integer project_num);

	public int projectDelect(Integer project_num);

	public ProjectMVO getAllData(Integer project_num);

	public int projectDelContent(ProjectMVO delpvo);
	public int projectDelOption(ProjectMVO delpvo);
	public int projectDelQna_board(ProjectMVO delpvo);
	public int projectDelReply(ProjectMVO delpvo);
	public int projectDelContentSeq(ProjectMVO delpvo);
	public int projectDelQna_boardSeq(ProjectMVO delpvo);
	public int projectDelReplySeq(ProjectMVO delpvo);

	public int projectDel(ProjectMVO delpvo);

}
