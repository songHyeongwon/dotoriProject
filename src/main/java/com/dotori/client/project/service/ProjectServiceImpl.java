package com.dotori.client.project.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.dotori.client.project.dao.ProjectDao;
import com.dotori.client.project.vo.ContentVO;
import com.dotori.client.project.vo.OptionVO;
import com.dotori.client.project.vo.ProjectVO;
import com.dotori.client.project.vo.QnaBoard;
import com.dotori.client.project.vo.ReplyVO;
import com.dotori.common.file.FileUploadUtil;
import com.dotori.common.vo.HomeControllerVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@AllArgsConstructor
public class ProjectServiceImpl implements ProjectService {

	private ProjectDao projectDao;

	@Override
	public ArrayList<ProjectVO> getPatterns(String project_pattern1) {
		ArrayList<ProjectVO> list = projectDao.getPatterns(project_pattern1);
		return list;
	}

	@Override
	public int getProjectPKNum() {
		int resilt = projectDao.getProjectPKNum();
		return resilt;
	}

	@Override
	public int createContentTable(ProjectVO pvo) {
		int result = projectDao.createContentTable(pvo);
		return result;
	}

	@Override
	public int createReplyTable(ProjectVO pvo) {
		int result = projectDao.createReplyTable(pvo);
		return result;
	}

	@Override
	public int createOptionTable(ProjectVO pvo) {
		int result = projectDao.createOptionTable(pvo);
		return result;
	}

	@Override
	public int createQna_boardTable(ProjectVO pvo) {
		int result = projectDao.createQna_boardTable(pvo);
		return result;
	}

	@Override
	public int createContentTableSeq(ProjectVO pvo) {
		int result = projectDao.createContentTableSeq(pvo);
		return result;
	}

	@Override
	public int createReplyTableSeq(ProjectVO pvo) {
		int result = projectDao.createReplyTableSeq(pvo);
		return result;
	}

	@Override
	public int createQna_boardTableSeq(ProjectVO pvo) {
		int result = projectDao.createQna_boardTableSeq(pvo);
		return result;
	}

	// 여기서부터 존나 중요해짐
	@Override
	public int insertProject(ProjectVO pvo) {
		int result = 0;
		try {
			if (pvo.getFile() != null) {
				String fileName = FileUploadUtil.fileUpload(pvo.getFile(), "gallery");
				
				pvo.setProject_thumb(fileName);
				//String fileName = FileUploadUtil.fileUpload(pvo.getFile(), "gallery");
				//String thumbName = FileUploadUtil.makeThumbnail(fileName);
				//pvo.setProject_thumb(thumbName);
			}
			result = projectDao.insertProject(pvo);
		} catch (Exception e) {
			e.printStackTrace();
			result = 0;
		}
		return result;
	}

	//프로젝트 물건 입력 쿼리
	@Override
	public int insertProjectContentTable(ProjectVO pvo) {
		int result = 0;
		ContentVO icvo = new ContentVO();
		OptionVO iovo = new OptionVO();
		//테이블명, 프로젝트 넘버, 
		icvo.setTableName(pvo.getContent_table_name());
		icvo.setProject_num(pvo.getProject_num());
		icvo.setOption_table_name(pvo.getOption_table_name());
		//옵션의 프로젝트 번호, 테이블명
		iovo.setProject_num(pvo.getProject_num());
		iovo.setTableName(pvo.getOption_table_name());
		
		for(int i =0; i<pvo.getList().size();i++) {
			//pk키를 가져온다.
			int cvoPk = projectDao.getProjectContentTablePk(pvo);
			icvo.setContent_num(cvoPk);
			icvo.setContent_Kind(pvo.getList().get(i).getContent_Kind());
			icvo.setContent_MinPrice(pvo.getList().get(i).getContent_MinPrice());
			icvo.setContent_name(pvo.getList().get(i).getContent_name());
			result = projectDao.insertProjectContentTable(icvo);
			//옵션에 컨텐트 넘버
			iovo.setContent_num(cvoPk);
			for(int k =0; k<pvo.getList().get(i).getListOption().size();k++) {
				iovo.setOption_name(pvo.getList().get(i).getListOption().get(k).getOption_name());
				iovo.setOption_kind(pvo.getList().get(i).getListOption().get(k).getOption_kind());
				String value = pvo.getList().get(i).getListOption().get(k).getOption_value_text();
				value = value.substring(value.indexOf("/")+1,value.length());
				String[] values = value.split("/");
				for(int u = 0; u<values.length;u++) {
					iovo.setOption_value(values[u]);
					log.info(iovo);
					result = projectDao.insertProjectOptionTable(iovo);
				}
			}
			if(result==0) {
				return result;
			}
		}
		return result;
	}

	@Override
	public List<ProjectVO> projectList(ProjectVO pvo) {
		List<ProjectVO> list = projectDao.projectList(pvo);
		return list;
	}

	@Override
	public int projectListCnt(ProjectVO pvo) {
		int result = projectDao.projectListCnt(pvo);
		return result;
	}

	@Override
	public ProjectVO projectDetail(ProjectVO pvo) {
		ProjectVO result = projectDao.projectDetail(pvo);
		//먼저 뽑아봅니다.
		log.info("=====================================================result의 값을 뽑아냅니다."+result);
		//컨텐츠를 가져옵니다.
		result.setList(projectDao.getContentList(result));
		
		//컨텐츠별의 옵션을 가져옵니다.
		for(int i = 0; i<result.getList().size(); i++) {
			result.getList().get(i).setListOption(projectDao.getOprionList(result.getList().get(i)));
		}
		return result;
	}

	@Override
	public List<ProjectVO> mainList(ProjectVO pvo) {
		ArrayList<ProjectVO> list = projectDao.mainList(pvo);
		return list;
	}

	@Override
	public List<OptionVO> getOptionValue(ContentVO cvo) {
		List<OptionVO> list = projectDao.getOprionList(cvo);
		return list;
	}

	@Override
	public int updateStatus() {
		int result1 = projectDao.updateStatus1();
		int result2 = projectDao.updateStatus2();
		return result1+result2;
	}

	
/********************************************************************************************
 * 프로젝트의 댓글과 관련된 기능																		*
 ********************************************************************************************/
	@Override
	public List<ReplyVO> replyList(ReplyVO rvo) {
		List<ReplyVO> list = projectDao.replyList(rvo);
		return list;
	}

	@Override
	public int replyInsert(ReplyVO rvo) {
		int result = projectDao.replyInsert(rvo);
		return result;
	}

	@Override
	public int replyDelete(ReplyVO rvo) {
		int result = projectDao.replyDelete(rvo);
		return result;
	}

	@Override
	public int replyUpdate(ReplyVO rvo) {
		int result = projectDao.replyUpdate(rvo);
		return result;
	}

	
	/********************************************************************************************
	 * 프로젝트의 문의글과 관련된 기능																		*
	 ********************************************************************************************/
	@Override
	public int boardInsert(QnaBoard qvo) {
		int result = projectDao.boardInsert(qvo);
		return result;
	}

	@Override
	public List<QnaBoard> boardList(QnaBoard qvo) {
		List<QnaBoard> list = projectDao.boardList(qvo);
		return list;
	}

	@Override
	public int boardDelete(QnaBoard qvo) {
		int result = projectDao.boardDelete(qvo);
		return result;
	}

	@Override
	public int boardUpdate(QnaBoard qvo) {
		int result = projectDao.boardUpdate(qvo);
		return result;
	}

	@Override
	public int qnaInsert(QnaBoard qvo) {
		int result = projectDao.qnaInsert(qvo);
		return result;
	}

	@Override
	public HomeControllerVO managerList() {
		HomeControllerVO result = new HomeControllerVO();
		result.setCs_board_count(projectDao.cs_board_count());
		result.setMember_count(projectDao.member_count());
		result.setOrders_sum_price(projectDao.orders_sum_price());
		result.setProject_count(projectDao.project_count());
		return result;
	}
}
