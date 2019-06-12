package com.dotori.client.project.vo;

import lombok.Data;

@Data
public class QnaBoard {
	private int qna_num;
	private String qna_title;
	private String qna_content;
	private String member_id;
	private String qna_regdate;
	private String qna_mdate;
	private int qna_reproot;
	private int qna_repindent;
	private int qna_hidden;
	private String qna_board_table_name;
}
