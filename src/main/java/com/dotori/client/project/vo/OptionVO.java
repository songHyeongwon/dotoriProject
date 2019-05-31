package com.dotori.client.project.vo;

import lombok.Data;

@Data
public class OptionVO {
	private String option_name;
	private int option_kind; 
	private String option_value_text;
	
	private String tableName;
	private int project_num;
    private int content_num;
    private String option_value;
}
