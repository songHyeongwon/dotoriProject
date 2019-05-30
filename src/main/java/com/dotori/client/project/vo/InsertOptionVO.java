package com.dotori.client.project.vo;

import lombok.Data;

@Data
public class InsertOptionVO {
	private String tableName;
	private int Project_num;
    private int Content_num;
    private String option_name;
    private int option_kind;
    private String option_value;
}
