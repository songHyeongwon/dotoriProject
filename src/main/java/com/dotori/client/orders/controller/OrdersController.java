package com.dotori.client.orders.controller;



import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dotori.client.member.vo.MemberVO;
import com.dotori.client.orders.service.OrdersService;
import com.dotori.client.orders.vo.OrdersVO;
import com.dotori.client.project.vo.ProjectVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/orders/*")
@Controller
@Log4j
@AllArgsConstructor
public class OrdersController {

	private OrdersService ordersService;
	
	//첫번째 결제창: 다른 주소 입력-배송사항 안내 페이지
	@RequestMapping(value="/ordersForm")
	public String ordersForm(@ModelAttribute OrdersVO ovo, Model model) {
		
		model.addAttribute("orders",ovo);
		log.info(ovo);
		log.info("ordersForm 프로젝트 번호:"+ovo.getProject_num());
		
		return "orders/ordersForm";
	}

	//두번째 결제창:후원사항 안내 동의여부 수집 페이지+결제

	@RequestMapping(value="/ordersFinal")
	public String ordersFinal(@ModelAttribute OrdersVO ovo, ProjectVO pvo,Model model) {
		model.addAttribute("orders",ovo);
		model.addAttribute("project",pvo);
		log.info(ovo);
		log.info("ordersFinal 프로젝트 번호:"+ovo.getProject_num());
		log.info("ordersInsert 수행");

		log.info("프로젝트 번호:"+ovo.getProject_num());
		log.info("ordersInsert 수행");
		
		return "orders/ordersFinal"; 
	}
	
	//최종 결제창: orders테이블에 주문내역 insert
	@RequestMapping(value="/ordersInsert",method= {RequestMethod.POST,RequestMethod.GET})
	public String ordersInsert(HttpSession session,@ModelAttribute OrdersVO ovo,MemberVO mvo, Model model) {
		model.addAttribute("orders",ovo);
		model.addAttribute("data",mvo);
		log.info(ovo);
		log.info("ordersInsert 프로젝트 번호:"+ovo.getProject_num());

		log.info("프로젝트 번호:"+ovo.getProject_num());
		
		int result;
		String url="";
		
		result=ordersService.ordersInsert(ovo);
		if(result==1) {
			url="/orders/ordersFinal";
		}
		return "orders/ordersInsert";
	}
	//마이페이지-후원내역 보기
	@RequestMapping(value="/ordersDetail")
	public String ordersDetail() {
		
		return "orders/ordersDetail";
	}
}
