package com.dotori.client.orders.controller;



import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dotori.client.member.vo.MemberVO;
import com.dotori.client.orders.service.OrdersService;
import com.dotori.client.orders.vo.DeliveryVO;
import com.dotori.client.orders.vo.OrdersVO;

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
		log.info("주문 폼 실행 프로젝트 번호:"+ovo.getProject_num());
		log.info(ovo);
		model.addAttribute("orders",ovo);

		
		return "orders/ordersForm";
	}

	//두번째 결제창:후원사항 안내 동의여부 수집 페이지+결제

	@RequestMapping(value="/ordersFinal")
	public String ordersFinal(@ModelAttribute OrdersVO ovo, Model model, DeliveryVO dvo) {

		log.info("ordersInsert 수행");
		log.info("프로젝트 번호:"+ovo.getProject_num());
		log.info(ovo);
		log.info(dvo);
		if(ovo.getContent_kind()==1) {
			//배송물품이다.
			//ovo에 dvo의 값들을 넣어준다. dvo -> ovo 상속관계
			ovo.setDelivery_recaddress(dvo.getDelivery_recaddress());
			ovo.setDelivery_recname(dvo.getDelivery_recname());
			ovo.setDelivery_recphone(dvo.getDelivery_recphone());
			ovo.setDelivery_send(dvo.getDelivery_send());
		}
		
		model.addAttribute("orders",ovo);
		
		return "orders/ordersFinal"; 
	}
	
	//최종 결제창: orders테이블에 주문내역 insert
	@RequestMapping(value="/ordersInsert")
	public String ordersInsert(@ModelAttribute OrdersVO ovo, Model model,HttpSession session) {

		log.info("넘겨받은값 = "+ovo);
		log.info("final페이지에 넘겨받은 값 = "+ovo.getDelivery_recaddress()+" "+ovo.getDelivery_recname()+" "+ovo.getDelivery_recphone()+" "+ovo.getDelivery_send());
		
		String url="";
		int result=0;
		try{
			result = ordersService.ordersInsert(ovo);
			url="orders/ordersInsert";
		}catch(Exception e) {
			e.printStackTrace();
			//여기에 에러페이지를 넣어준다.
			url="index";
		}
		
		int resultNum = ordersService.getOrders();
		MemberVO mvo = (MemberVO) session.getAttribute("data");
		mvo.setMember_point(mvo.getMember_point()-ovo.getOrder_price());
		session.setAttribute("data", mvo);
		ovo.setOrder_num(resultNum);
		model.addAttribute("orders", ovo);
		return url;
	}
	//마이페이지-후원내역 보기
	@RequestMapping(value="/ordersDetail")
	public String ordersDetail() {
		return "orders/ordersDetail";
	}
}
