package com.dotori.manager.orders.dao;

import java.util.List;
import com.dotori.manager.orders.vo.OrdersMVO;

public interface OrdersManagerDao {
	public List<OrdersMVO> ordersManagerView(OrdersMVO omvo);
	public int ordersListCnt(OrdersMVO omvo);
}
