package com.dotori.manager.orders.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dotori.manager.orders.service.OrdersManagerService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/ordersManager/*")
@Log4j
@Controller
@AllArgsConstructor
public class OrdersManagerController {
	private OrdersManagerService ordersManagerService;
	@RequestMapping(value="/ordersManagerView")
	public String ordersManagerPage() {
		return "ordersManager/ordersManagerView";
	}
	
}
