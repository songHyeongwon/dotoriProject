package com.dotori.client.orders.vo;

import com.dotori.client.orders.vo.DeliveryVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class OrdersVO extends DeliveryVO{
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
