package com.dotori.manager.orders.service;

import java.util.List;

import com.dotori.manager.orders.vo.OrdersMVO;

public interface OrdersManagerService {
	public List<OrdersMVO> ordersManagerView(OrdersMVO omvo);
	public int ordersListCnt(OrdersMVO omvo);
}
