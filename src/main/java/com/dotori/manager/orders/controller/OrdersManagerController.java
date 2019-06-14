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

import com.dotori.manager.project.vo.ProjectMVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/ordersManager/*")
@Log4j
@Controller
@AllArgsConstructor
public class OrdersManagerController {
	
	private OrdersManagerService ordersManagerService;
	
	@RequestMapping(value="/ordersManagerView", method=RequestMethod.GET)
	public String ordersManagerPage(@ModelAttribute OrdersMVO omvo,Model model) {
		log.info("ordersManagerView 호출");
		log.info("ovo:"+omvo);
		
		List<OrdersMVO>ordersList=ordersManagerService.ordersManagerView(omvo);
		model.addAttribute("ordersList",ordersList);
		
		int total=ordersManagerService.ordersListCnt(omvo);
		log.info("총 구매내역 수:"+total);
		model.addAttribute("pageMaker", new PageDTO(omvo, total, 10));
		
		return "ordersManager/ordersManagerView";
	}
	
	@RequestMapping(value="/ordersExcel",method=RequestMethod.GET)
	public ModelAndView ordersExcel(@ModelAttribute OrdersMVO omvo) {
		log.info("ordersExcel 호출");
		
		List<OrdersMVO>ordersList=ordersManagerService.ordersManagerView(omvo);
		
		ModelAndView mv=new ModelAndView(new ListExcelView());
		mv.addObject("ordersList",ordersList);
		mv.addObject("template","orders.xlsx");
		mv.addObject("file_name","orders");
		
		return mv;
	}
	//SELECT DB데이터를 도표형으로 반환해주기 위한 컨트롤러
	@RequestMapping(value="/ordersRatio.do",method=RequestMethod.POST)
	public String ordersRatio(Model model) throws Exception{
		List<ProjectMVO>ordersRatio=ordersManagerService.ordersRatio();
		model.addAttribute("amount",ordersRatio);
		return "ordersManager/ordersManagerView";
		
	}
	
}