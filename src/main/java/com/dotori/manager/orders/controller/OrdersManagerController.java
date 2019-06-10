package com.dotori.manager.orders.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.dotori.common.excel.ListExcelView;
import com.dotori.common.vo.PageDTO;
import com.dotori.manager.orders.service.OrdersManagerService;
import com.dotori.manager.orders.vo.OrdersMVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/ordersManager/*")
@Log4j
@Controller
@AllArgsConstructor
public class OrdersManagerController {
	
	private OrdersManagerService ordersManagerService;
	
	@RequestMapping(value="/ordersManagerView", method=RequestMethod.GET)
	public String ordersManagerPage(@ModelAttribute OrdersMVO ovo,Model model) {
		log.info("ordersManagerView 호출");
		log.info("ovo:"+ovo);
		
		List<OrdersMVO>ordersList=ordersManagerService.ordersManagerView(ovo);
		model.addAttribute("ordersList",ordersList);
		
		int total=ordersManagerService.ordersListCnt(ovo);
		model.addAttribute("pageMarker", new PageDTO(ovo, total, 10));
		
		return "ordersManager/ordersManagerView";
	}
	
	@RequestMapping(value="/ordersExcel",method=RequestMethod.GET)
	public ModelAndView ordersExcel(@ModelAttribute OrdersMVO ovo) {
		log.info("ordersExcel 호출");
		
		List<OrdersMVO>ordersList=ordersManagerService.ordersManagerView(ovo);
		
		ModelAndView mv=new ModelAndView(new ListExcelView());
		mv.addObject("ordersList",ordersList);
		mv.addObject("template","orders.xlsx");
		mv.addObject("file_name","orders");
		
		return mv;
	}
	
}
