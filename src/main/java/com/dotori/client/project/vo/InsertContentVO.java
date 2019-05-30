package com.dotori.client.project.vo;

import lombok.Data;

@Data
public class InsertContentVO {
	private String tableName;
	private int content_num;
    private int project_num;
    private String content_name;
    private int content_kind;
    private int content_minprice;
    private String content_recdate;
    private String option_table_name;
}
