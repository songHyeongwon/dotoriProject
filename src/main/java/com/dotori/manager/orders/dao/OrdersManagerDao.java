package com.dotori.manager.orders.dao;

import java.util.List;
import com.dotori.manager.orders.vo.OrdersMVO;
//import com.dotori.manager.project.vo.ProjectMVO;
import com.dotori.manager.project.vo.ProjectMVO;

public interface OrdersManagerDao {
	public List<OrdersMVO> ordersManagerView(OrdersMVO omvo);//전체 후원항목 출력
	public int ordersListCnt(OrdersMVO omvo);//전체 후원항목 집계
	public List<ProjectMVO> ordersRatio();//집계된 후원항목의 도표화
}
