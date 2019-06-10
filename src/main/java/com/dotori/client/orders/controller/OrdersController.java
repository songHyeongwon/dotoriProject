package com.dotori.client.orders.controller;



import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	
	//ù��° ����â: �ٸ� �ּ� �Է�-��ۻ��� �ȳ� ������
	@RequestMapping(value="/ordersForm")
	public String ordersForm(@ModelAttribute OrdersVO ovo, Model model) {
		log.info("�ֹ� �� ���� ������Ʈ ��ȣ:"+ovo.getProject_num());
		log.info(ovo);
		model.addAttribute("orders",ovo);
		
		return "orders/ordersForm";
	}
	//�ι�° ����â:�Ŀ����� �ȳ� ���ǿ��� ���� ������+����
	@RequestMapping(value="/ordersFinal")
	public String ordersFinal(@ModelAttribute OrdersVO ovo, Model model, DeliveryVO dvo) {
		log.info("ordersInsert ����");
		log.info("������Ʈ ��ȣ:"+ovo.getProject_num());
		log.info(ovo);
		log.info(dvo);
		
		if(ovo.getContent_kind()==1) {
			//��۹�ǰ�̴�.
			//ovo�� dvo�� ������ �־��ش�. dvo -> ovo ��Ӱ���
			ovo.setDelivery_recaddress(dvo.getDelivery_recaddress());
			ovo.setDelivery_recname(dvo.getDelivery_recname());
			ovo.setDelivery_recphone(dvo.getDelivery_recphone());
			ovo.setDelivery_send(dvo.getDelivery_send());
		}
		
		model.addAttribute("orders",ovo);
		
		return "orders/ordersFinal";
		
	}
	
	//���� ����â: orders���̺� �ֹ����� insert
	@RequestMapping(value="/ordersInsert",method= {RequestMethod.POST,RequestMethod.GET})
	public String ordersInsert(@ModelAttribute OrdersVO ovo, Model model) {
		log.info("������Ʈ ��ȣ:"+ovo.getProject_num());
		log.info(ovo);
		log.info("final�������� �Ѱܹ��� �� = "+ovo.getDelivery_recaddress()+" "+ovo.getDelivery_recname()+" "+ovo.getDelivery_recphone()+" "+ovo.getDelivery_send());
		
		String url="";
		
		try{
			ordersService.ordersInsert(ovo);
			url="orders/ordersInsert";
		}catch(Exception e) {
			e.printStackTrace();
			//���⿡ ������������ �־��ش�.
			url="index";
		}
		model.addAttribute("orders", ovo);
		return url;
	}
	//����������-�Ŀ����� ����
	@RequestMapping(value="/ordersDetail")
	public String ordersDetail() {
		return "orders/ordersDetail";
	}
	
	@RequestMapping(value="/ordersEnd")
	public String ordersEnd() { 
		return "index";
	}
}
