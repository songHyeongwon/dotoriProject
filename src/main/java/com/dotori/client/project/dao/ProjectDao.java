package com.dotori.client.project.dao;

import java.util.ArrayList;

import com.dotori.client.project.vo.InsertContentVO;
import com.dotori.client.project.vo.ProjectVO;

public interface ProjectDao {

	public ArrayList<ProjectVO> getPatterns(String project_pattern1);

	public int getProjectPKNum();
	//프로젝트 생성시 테이블 생성
	public int createContentTable(ProjectVO pvo);
	public int createReplyTable(ProjectVO pvo);
	public int createOptionTable(ProjectVO pvo);
	public int createQna_boardTable(ProjectVO pvo);

	public int createQna_boardTableSeq(ProjectVO pvo);
	public int createReplyTableSeq(ProjectVO pvo);
	public int createContentTableSeq(ProjectVO pvo);

	public int insertProject(ProjectVO pvo);

	public int insertProjectContentTable(InsertContentVO icvo);

}
