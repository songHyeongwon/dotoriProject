package com.dotori.client.project.dao;

import java.util.ArrayList;
import java.util.List;

import com.dotori.client.project.vo.ContentVO;
import com.dotori.client.project.vo.OptionVO;
import com.dotori.client.project.vo.ProjectVO;
import com.dotori.client.project.vo.QnaBoard;
import com.dotori.client.project.vo.ReplyVO;

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

	public int insertProjectContentTable(ContentVO icvo);

	public int getProjectContentTablePk(ProjectVO pvo);

	public int insertProjectOptionTable(OptionVO icvo);

	public List<ProjectVO> projectList(ProjectVO pvo);

	public int projectListCnt(ProjectVO pvo);

	public ProjectVO projectDetail(ProjectVO pvo);

	public List<ContentVO> getContentList(ProjectVO pvo);

	public List<OptionVO> getOprionList(ContentVO contentVO);

	public ArrayList<ProjectVO> mainList(ProjectVO pvo);

	public ArrayList<OptionVO> getOptionValue(ContentVO cvo);

	public int updateStatus1();
	public int updateStatus2();

	public List<ReplyVO> replyList(ReplyVO rvo);

	public int replyInsert(ReplyVO rvo);

	public int replyDelete(ReplyVO rvo);

	public int replyUpdate(ReplyVO rvo);

	public int boardInsert(QnaBoard qvo);

	public List<QnaBoard> boardList(QnaBoard qvo);

	public int boardDelete(QnaBoard qvo);

}
