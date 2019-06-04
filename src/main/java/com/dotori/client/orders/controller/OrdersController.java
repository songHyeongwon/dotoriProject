package com.dotori.client.orders.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dotori.client.orders.service.OrdersService;
import com.dotori.client.orders.vo.OrdersVO;

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
	@RequestMapping(value="/ordersFinal")
	public String ordersFinal() {
		return "orders/ordersFinal";
	}
	@RequestMapping(value="/ordersConfirm")
	public String ordersConfirm() {
		return "orders/ordersConfirm";
	}
	@RequestMapping(value="/ordersInsert",method= {RequestMethod.GET,RequestMethod.POST})
	public String ordersInsert(@ModelAttribute OrdersVO ovo, Model model) {
		log.info("ordersInsert »£√‚");
		
		int result=0;
		String url="";
		
		result=ordersService.ordersInsert(ovo);
		if(result==1) {
			url="orders/ordersConfirm";
		}
		
		return "redirect:"+url;
	}
	@RequestMapping(value="/ordersDetail")
	public String ordersDetail() {
		
		return "orders/ordersDetail";
	}
}
