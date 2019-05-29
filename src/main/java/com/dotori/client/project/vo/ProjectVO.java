package com.dotori.client.project.vo;

import org.springframework.web.multipart.MultipartFile;

import com.dotori.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ProjectVO extends CommonVO{
	private String project_num;
	private String project_name;
	private String project_thumb;
	private String project_summary;
	private String project_pattern1;
	private String project_pattern2;
	private String project_URL;
	private String project_targetMoney;
	private String project_sumMoney;
	private String project_endDate;
	private String project_content;
	private String project_img1;
	private String project_bank;
	private String project_bankNum;
	private String project_status;
	private String project_addDate;
	private String content_table_name;
	private String qna_board_table_name;
	private String option_table_name;
	private String reply_table_name;
	private String member_id;
	private MultipartFile file=null;
}
