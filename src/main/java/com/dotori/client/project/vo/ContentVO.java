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
}
