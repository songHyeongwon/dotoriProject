package com.dotori.client.orders.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrdersVO {
	private int order_num;
	private String member_id;
	private int project_num;
	private String order_content;
	private int order_price;
	private String order_date;
	private int order_guideAgree;
	private int order_infoAgree;
	private int content_kind;
}
