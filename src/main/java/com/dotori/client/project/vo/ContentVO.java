package com.dotori.client.project.vo;



import java.util.ArrayList;
import java.util.List;

import lombok.Data;
@Data
public class ContentVO {
	private String content_name="";
	private int content_MinPrice=0;
	private int content_Kind=0;
	List<OptionVO> listOption;
	public ContentVO() {
		listOption = new ArrayList<OptionVO>();
	}
	
	private String tableName;
	private int content_num;
    private int project_num;
    private String content_recdate;
    private String option_table_name;
}
