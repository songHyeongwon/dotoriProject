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

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/orders/*")
@Controller
@Log4j
@AllArgsConstructor
public class OrdersController {

	private OrdersService ordersService;
	
	//ù��° ����â: �ٸ� �ּ� �Է�-��ۻ��� �ȳ� ������
	@RequestMapping(value="/ordersForm")
	public String ordersForm(@ModelAttribute OrdersVO ovo, Model model) {
		
		model.addAttribute("orders",ovo);
		log.info(ovo);
		log.info("������Ʈ ��ȣ:"+ovo.getProject_num());
		
		return "orders/ordersForm";
	}
	//�ι�° ����â:�Ŀ����� �ȳ� ���ǿ��� ���� ������
	@RequestMapping(value="/ordersFinal")
	public String ordersFinal(@ModelAttribute OrdersVO ovo, Model model) {
		model.addAttribute("orders",ovo);
		log.info(ovo);
		log.info("������Ʈ ��ȣ:"+ovo.getProject_num());
		return "orders/ordersFinal";
		
	}
	
	//���� ����â: orders���̺� �ֹ����� insert
	@RequestMapping(value="/ordersInsert",method= {RequestMethod.POST,RequestMethod.GET})
	public String ordersInsert(HttpSession session,@ModelAttribute OrdersVO ovo, Model model) {
		model.addAttribute("orders",ovo);
		log.info(ovo);
		log.info("������Ʈ ��ȣ:"+ovo.getProject_num());
		log.info("ordersInsert ȣ��");
		
		/*MemberVO mvo=(MemberVO)session.getAttribute("member_id");
		String member_id=mvo.getMember_id();
		
		ovo.setMember_id(member_id);*/
		int result=0;
		String url="";
		
		result=ordersService.ordersInsert(ovo);
		if(result==1) {
			url="/orders/ordersInsert";
		}
		
		return "redirect:"+url;
	}
	//����������-�Ŀ����� ����
	@RequestMapping(value="/ordersDetail")
	public String ordersDetail() {
		
		return "orders/ordersDetail";
	}
}
