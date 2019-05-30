package com.dotori.client.project.service;

import java.util.ArrayList;

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

	public int insertProjectOptionTable(ProjectVO pvo);

	


}
