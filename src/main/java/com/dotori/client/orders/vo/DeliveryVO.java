package com.dotori.client.orders.vo;

import lombok.Data;

@Data
public class DeliveryVO {

	private int delivery_num;				//seq��ȣ
	private int order_num;					//�ֹ���ȣ
	private String delivery_recname;		//������ �̸�
	private String delivery_recaddress;		//������ �ּ�
	private String delivery_recphone;		//������ ����ȣ
	private String delivery_send;			//�߽��� �̸�
}
