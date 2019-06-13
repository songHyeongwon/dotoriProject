package com.dotori.client.project.vo;

import lombok.Data;

@Data
public class ReplyVO {
	private int reply_num;
	private int project_num;
	private String member_id;
	private String reply_content;
	private String reply_recdate;
	private String reply_table_name;
}