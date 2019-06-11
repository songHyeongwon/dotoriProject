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
	
	//ù��° ����â: �ٸ� �ּ� �Է�-��ۻ��� �ȳ� ������
	@RequestMapping(value="/ordersForm")
	public String ordersForm(@ModelAttribute OrdersVO ovo, Model model) {
		
		model.addAttribute("orders",ovo);
		log.info(ovo);
		log.info("ordersForm ������Ʈ ��ȣ:"+ovo.getProject_num());
		
		return "orders/ordersForm";
	}

	//�ι�° ����â:�Ŀ����� �ȳ� ���ǿ��� ���� ������+����

	@RequestMapping(value="/ordersFinal")
	public String ordersFinal(@ModelAttribute OrdersVO ovo, ProjectVO pvo,Model model) {
		model.addAttribute("orders",ovo);
		model.addAttribute("project",pvo);
		log.info(ovo);
		log.info("ordersFinal ������Ʈ ��ȣ:"+ovo.getProject_num());
		log.info("ordersInsert ����");

		log.info("������Ʈ ��ȣ:"+ovo.getProject_num());
		log.info("ordersInsert ����");
		
		return "orders/ordersFinal"; 
	}
	
	//���� ����â: orders���̺� �ֹ����� insert
	@RequestMapping(value="/ordersInsert",method= {RequestMethod.POST,RequestMethod.GET})
	public String ordersInsert(HttpSession session,@ModelAttribute OrdersVO ovo,MemberVO mvo, Model model) {
		model.addAttribute("orders",ovo);
		model.addAttribute("data",mvo);
		log.info(ovo);
		log.info("ordersInsert ������Ʈ ��ȣ:"+ovo.getProject_num());

		log.info("������Ʈ ��ȣ:"+ovo.getProject_num());
		
		int result;
		String url="";
		
		result=ordersService.ordersInsert(ovo);
		if(result==1) {
			url="/orders/ordersFinal";
		}
		return "orders/ordersInsert";
	}
	//����������-�Ŀ����� ����
	@RequestMapping(value="/ordersDetail")
	public String ordersDetail() {
		
		return "orders/ordersDetail";
	}
}
