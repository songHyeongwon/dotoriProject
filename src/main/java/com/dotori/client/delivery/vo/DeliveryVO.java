package com.dotori.client.delivery.vo;

import lombok.Data;

@Data
public class DeliveryVO {
	private int delivery_num;
	private int order_num;
	private String delivery_recName;
	private String delivery_recAddress;
	private String delivery_send;
}
