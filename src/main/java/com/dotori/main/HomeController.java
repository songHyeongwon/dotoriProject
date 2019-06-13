package com.dotori.main;



import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.dotori.client.project.service.ProjectService;
import com.dotori.client.project.vo.ProjectVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
@AllArgsConstructor
public class HomeController {
	private ProjectService projectService;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	/*@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}*/
	@RequestMapping(value ="/", method = RequestMethod.GET)
	public String main(Model model) {
		
		ProjectVO pvo = new ProjectVO();
		//���� �ֱٰ� 3���� �ݿ� ���� ����Ʈ
		pvo.setSearch("main");
		List<ProjectVO> mainList = projectService.mainList(pvo);
		model.addAttribute("mainList",mainList);
		
		//���� ĳ������ ��ȯ�� ���� ������ �α��ִ� �޴�(�������̸�, �Ŀ��ڼ��� ���� ����
		pvo.setSearch("carousel");
		List<ProjectVO> carouselList = projectService.mainList(pvo);
		model.addAttribute("viewList",carouselList);
		
		//�ְ�� �Ŀ� ��ȯ
		pvo.setSearch("summoney");
		List<ProjectVO> summoneylList = projectService.mainList(pvo);
		model.addAttribute("summoneyList",summoneylList);
		
		
		return "index";
	}
}