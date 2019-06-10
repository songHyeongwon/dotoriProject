package com.dotori.client.orders.vo;

import lombok.Data;

@Data
public class DeliveryVO {

	private int delivery_num;				//seq번호
	private int order_num;					//주문번호
	private String delivery_recname;		//수신자 이름
	private String delivery_recaddress;		//수신자 주소
	private String delivery_recphone;		//수신자 폰번호
	private String delivery_send;			//발신자 이름
}
