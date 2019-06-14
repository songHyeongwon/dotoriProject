package com.dotori.manager.orders.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dotori.manager.orders.dao.OrdersManagerDao;
import com.dotori.manager.orders.vo.OrdersMVO;
import com.dotori.manager.project.vo.ProjectMVO;

import lombok.Setter;
@Service
public class OrdersManagerServiceImpl implements OrdersManagerService {
	@Setter(onMethod_=@Autowired)
	private OrdersManagerDao ordersManagerDao;
	
	@Override
	public List<OrdersMVO> ordersManagerView(OrdersMVO omvo) {
		List<OrdersMVO>list=ordersManagerDao.ordersManagerView(omvo);
		return list;
	}
	@Override
	public int ordersListCnt(OrdersMVO omvo) {
		int result=ordersManagerDao.ordersListCnt(omvo);
		return result;
	}
	@Override
	public List<ProjectMVO> ordersRatio() {
		List<ProjectMVO> resultList=ordersManagerDao.ordersRatio();
		return resultList;
	}
		
}
