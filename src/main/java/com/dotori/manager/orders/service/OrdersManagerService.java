package com.dotori.manager.orders.service;

import java.util.List;

import com.dotori.manager.orders.vo.OrdersMVO;
import com.dotori.manager.project.vo.ProjectMVO;

public interface OrdersManagerService {
	public List<OrdersMVO> ordersManagerView(OrdersMVO omvo);
	public int ordersListCnt(OrdersMVO omvo);
	public List<ProjectMVO> ordersRatio();
}
