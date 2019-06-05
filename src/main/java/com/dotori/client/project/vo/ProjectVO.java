package com.dotori.client.project.vo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.dotori.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ProjectVO extends CommonVO{
	private int project_num; //프로젝트 번호
	private String project_name; //프로젝트 이름
	private String project_thumb; //프로젝트 썸네일
	private String project_summary; //프로젝트 간단 소개
	private String project_pattern1; //프로젝트 대분류
	private String project_pattern2; //프로젝트 소분류
	private String project_URL; //관련사이트 URL
	private int project_targetMoney; 
	private int project_sumMoney;
	private String project_endDate;
	private String project_content;
	private int project_count;
	private String project_bank;
	private String project_bankNum;
	private int project_status;
	private String project_addDate;
	private String content_table_name;
	private String qna_board_table_name;
	private String option_table_name;
	private String reply_table_name;
	private String member_id;
	private MultipartFile file=null;
	private List<ContentVO> list;
	
	public ProjectVO() {
		list = new ArrayList<ContentVO>();
	}
	
}
