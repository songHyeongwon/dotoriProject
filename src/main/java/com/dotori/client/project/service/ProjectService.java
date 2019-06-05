package com.dotori.client.project.service;

import java.util.ArrayList;
import java.util.List;

import com.dotori.client.project.vo.ContentVO;
import com.dotori.client.project.vo.OptionVO;
import com.dotori.client.project.vo.ProjectVO;

public interface ProjectService {

	public ArrayList<ProjectVO> getPatterns(String project_pattern1);

	public int getProjectPKNum();

	public int createContentTable(ProjectVO pvo);
	public int createReplyTable(ProjectVO pvo);
	public int createOptionTable(ProjectVO pvo);
	public int createQna_boardTable(ProjectVO pvo);
	public int createContentTableSeq(ProjectVO pvo);
	public int createReplyTableSeq(ProjectVO pvo);
	public int createQna_boardTableSeq(ProjectVO pvo);

	public int insertProject(ProjectVO pvo);
	public int insertProjectContentTable(ProjectVO pvo);

	public List<ProjectVO> projectList(ProjectVO pvo);

	public int projectListCnt(ProjectVO pvo);

	public ProjectVO projectDetail(ProjectVO pvo);

	public List<ProjectVO> mainList();

	public List<OptionVO> getOptionValue(ContentVO cvo);
	public int updateStatus();
}
