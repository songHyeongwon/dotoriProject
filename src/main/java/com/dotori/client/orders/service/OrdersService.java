package com.dotori.client.orders.service;

import java.util.List;

import com.dotori.client.orders.vo.OrdersVO;

public interface OrdersService {

	public int ordersInsert(OrdersVO ovo);

	public int getOrders();

}
