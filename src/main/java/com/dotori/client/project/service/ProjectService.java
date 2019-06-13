package com.dotori.client.project.service;

import java.util.ArrayList;
import java.util.List;

import com.dotori.client.cs_reply.vo.Cs_ReplyVO;
import com.dotori.client.project.vo.ContentVO;
import com.dotori.client.project.vo.OptionVO;
import com.dotori.client.project.vo.ProjectVO;
import com.dotori.client.project.vo.QnaBoard;
import com.dotori.client.project.vo.ReplyVO;

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

	public List<ProjectVO> mainList(ProjectVO pvo);

	public List<OptionVO> getOptionValue(ContentVO cvo);
	public int updateStatus();

	public List<ReplyVO> replyList(ReplyVO rvo);

	public int replyInsert(ReplyVO rvo);

	public int replyDelete(ReplyVO rvo);

	public int replyUpdate(ReplyVO rvo);

	public int boardInsert(QnaBoard qvo);

	public List<QnaBoard> boardList(QnaBoard qvo);

	public int boardDelete(QnaBoard qvo);

	public int boardUpdate(QnaBoard qvo);

	public int qnaInsert(QnaBoard qvo);

	
}
