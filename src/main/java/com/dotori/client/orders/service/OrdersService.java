package com.dotori.client.orders.service;

import com.dotori.client.orders.vo.OrdersVO;

public interface OrdersService {

	public int ordersInsert(OrdersVO ovo);

	public OrdersVO getOrders(OrdersVO ovo);

}
