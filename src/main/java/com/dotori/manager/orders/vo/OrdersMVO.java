package com.dotori.manager.orders.vo;

import com.dotori.common.vo.CommonVO;

import lombok.Data;

@Data
public class OrdersMVO extends CommonVO {
	private int orders_num;
	private String member_id;
	private int project_num;
	private String orders_content;
	private int orders_price;
	private String orders_date;
	private int orders_guideAgree;
	private int orders_infoAgree;
	private int content_kind;
}
