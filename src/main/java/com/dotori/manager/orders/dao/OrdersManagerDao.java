package com.dotori.manager.orders.dao;

import java.util.List;
import com.dotori.manager.orders.vo.OrdersMVO;
//import com.dotori.manager.project.vo.ProjectMVO;
import com.dotori.manager.project.vo.ProjectMVO;

public interface OrdersManagerDao {
	public List<OrdersMVO> ordersManagerView(OrdersMVO omvo);//��ü �Ŀ��׸� ���
	public int ordersListCnt(OrdersMVO omvo);//��ü �Ŀ��׸� ����
	public List<ProjectMVO> ordersRatio();//����� �Ŀ��׸��� ��ǥȭ
}
