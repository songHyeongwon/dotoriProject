package com.dotori.client.orders.service;

import org.springframework.stereotype.Service;

import com.dotori.client.orders.dao.OrdersDao;
import com.dotori.client.orders.vo.OrdersVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class OrdersServiceImpl implements OrdersService{
	private OrdersDao ordersDao;
	@Override
	public int ordersInsert(OrdersVO ovo) {
		int result = ordersDao.ordersInsert(ovo);
		return result;
	}
	@Override
	public OrdersVO getOrders(OrdersVO ovo) {
		OrdersVO result = ordersDao.getOrders(ovo);
		return result;
	}

}
