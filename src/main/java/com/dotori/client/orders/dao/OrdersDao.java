package com.dotori.client.orders.dao;

import java.util.List;

import com.dotori.client.orders.vo.OrdersVO;

public interface OrdersDao {

	public int ordersInsert(OrdersVO ovo);

	public int getOrders();

}
