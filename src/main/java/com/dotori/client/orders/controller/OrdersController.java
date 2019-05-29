package com.dotori.client.orders.controller;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

import com.dotori.client.orders.service.OrdersService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/orders/*")
@Controller
@Log4j
@AllArgsConstructor
public class OrdersController {

	private OrdersService ordersService;
	
	@RequestMapping(value="/ordersForm")
	public String ordersForm() {
		return "orders/ordersForm";
	}
	
}
