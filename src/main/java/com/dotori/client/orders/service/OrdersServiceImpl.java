package com.dotori.client.orders.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dotori.client.orders.dao.OrdersDao;
import com.dotori.client.orders.vo.OrdersVO;

import lombok.Setter;

@Service
public class OrdersServiceImpl implements OrdersService{
	@Setter(onMethod_ = @Autowired)
	private OrdersDao ordersDao;
	@Override
	public int ordersInsert(OrdersVO ovo) {
		int result=0;
		result=ordersDao.ordersInsert(ovo);
		return result;
	}

}
