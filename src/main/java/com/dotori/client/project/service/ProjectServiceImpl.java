package com.dotori.client.project.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.dotori.client.project.dao.ProjectDao;
import com.dotori.client.project.vo.InsertContentVO;
import com.dotori.client.project.vo.ProjectVO;
import com.dotori.common.file.FileUploadUtil;

import lombok.AllArgsConstructor;

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
				String thumbName = FileUploadUtil.makeThumbnail(fileName);
				pvo.setProject_thumb(thumbName);
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
		InsertContentVO icvo = new InsertContentVO();
		//테이블명, 프로젝트 넘버, 
		icvo.setTableName(pvo.getContent_table_name());
		icvo.setProject_num(pvo.getProject_num());
		icvo.setOption_table_name(pvo.getOption_table_name());
		
		for(int i =0; i<pvo.getList().size();i++) {
			icvo.setContent_kind(pvo.getList().get(i).getContent_Kind());
			icvo.setContent_minprice(pvo.getList().get(i).getContent_MinPrice());
			icvo.setContent_name(pvo.getList().get(i).getContent_name());
			result = projectDao.insertProjectContentTable(icvo);
			if(result==0) {
				return result;
			}
		}
		return result;
	}

	//프로젝트 옵션 입력 쿼리
	@Override
	public int insertProjectOptionTable(ProjectVO pvo) {
		int result = 0;
				
		
		return 0;
	}

}
