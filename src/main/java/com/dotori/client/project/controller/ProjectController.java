package com.dotori.client.project.controller;

import java.util.List;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.dotori.client.project.service.ProjectService;
import com.dotori.client.project.vo.ContentVO;
import com.dotori.client.project.vo.OptionVO;
import com.dotori.client.project.vo.ProjectVO;
import com.dotori.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/project/*")
@Log4j
@Controller
@AllArgsConstructor
public class ProjectController {
	
	@InitBinder
	public void initBiner(WebDataBinder binder) {
		binder.registerCustomEditor(MultipartFile.class, "file", new StringTrimmerEditor(true));
	}
	//������Ʈ ���� ����
	private ProjectService projectService;
	
	/********************************************************************************************
	 * ������Ʈ insert �� ��ȯ �޼���																	*
	 ********************************************************************************************/
	@RequestMapping(value="/insertForm")
	public String projectInsertFrom() {
		return "project/projectInsert";
	}
	
	/********************************************************************************************
	 * �Һз� ����� �ҷ����̴� �޼���																		*
	 ********************************************************************************************/
	@GetMapping(value="/getPatterns/{Project_pattern1}", produces = {MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE } )
	public ResponseEntity<List<ProjectVO>> getPatterns(@PathVariable("Project_pattern1") String project_pattern1) {
		
		log.info("���ð� ȣ�� = "+project_pattern1);
		ResponseEntity<List<ProjectVO>> entity = null;
		entity = new ResponseEntity<>(projectService.getPatterns(project_pattern1), HttpStatus.OK);
		return entity;
	}
	
	/********************************************************************************************
	 * ������Ʈ insert ������ ������ϸ� ���� �޾� ó���ϴ� �޼���													*
	 ********************************************************************************************/
	@RequestMapping(value="/insertProject")
	public String projectInsert(@ModelAttribute ProjectVO pvo) {
		log.info("insert �ȿ� ��� �Խ��ϴ�.");
		log.info("���°�"+pvo);
		
		//pkŰ ��������
		int Pknum = projectService.getProjectPKNum();
		
		String id = pvo.getMember_id();
		pvo.setProject_num(Pknum);
		pvo.setReply_table_name(id+"_"+Pknum+"_reply");
		pvo.setOption_table_name(id+"_"+Pknum+"_option");
		pvo.setContent_table_name(id+"_"+Pknum+"_content");
		pvo.setQna_board_table_name(id+"_"+Pknum+"_qna_board");
		
		//���� ���̺� �����ϱ�
		int result = 0;
		result = projectService.createContentTable(pvo);
		result = projectService.createReplyTable(pvo);
		result = projectService.createOptionTable(pvo);
		result = projectService.createQna_boardTable(pvo);
		
		result = projectService.createContentTableSeq(pvo);
		result = projectService.createReplyTableSeq(pvo);
		result = projectService.createQna_boardTableSeq(pvo);
		
		//������Ʈ �μ�Ʈ
		result = projectService.insertProject(pvo);
		result = projectService.insertProjectContentTable(pvo);
		if(result==0) {
			log.info("======================================�Ƹ�����?=================================");
		}
		return "index";
	}
	/********************************************************************************************
	 * ������Ʈ�� ��� ������ ��ȯ�� �����ִ� �޼���																*
	 ********************************************************************************************/
	@RequestMapping(value="/listForm",method=RequestMethod.GET)
	public String projectList(@ModelAttribute ProjectVO pvo, Model model) {
		log.info("ProjectList ȣ�� ����");
		projectService.updateStatus();
		List<ProjectVO> list = projectService.projectList(pvo);
		model.addAttribute("listProject",list);
		
		//��ü ���ڵ� �� ����
		int total = projectService.projectListCnt(pvo);
		log.info("============================================="+pvo);
		log.info("�� Į�� ������ = "+total);
		model.addAttribute("pageMaker",new PageDTO(pvo,total,9));
		
		//log.info("������ ���� = "+new PageDTO(pvo,total,10));
		return "project/projectList";
	}
	/********************************************************************************************
	 * ������Ʈ ���� �������� �� ������ �����ִ� �޼���															*
	 ********************************************************************************************/
	@RequestMapping(value="/detail",method=RequestMethod.POST)
	public String projectDetail(@ModelAttribute ProjectVO pvo, Model model){
		log.info("�� �� = "+pvo);
		log.info("detail������ ȣ��");
		ProjectVO result = projectService.projectDetail(pvo);
		model.addAttribute("project", result);
		
		log.info(result);
		
		return "project/projectDetail";
	}
	/********************************************************************************************
	 * nav�� ���� �������� �ش��ϴ� ���� ã�ƿ��� �޼���															*
	 ********************************************************************************************/
	@GetMapping(value="/getPatterns2"/*, produces = MediaType.APPLICATION_JSON_UTF8_VALUE*/)
	public String navprojectList(@ModelAttribute ProjectVO pvo, Model model) {
		
		log.info("navprojectList ȣ��");
		//�˻� �� �Է�
		pvo.setSearch("Patterns2");
		List<ProjectVO> list = projectService.projectList(pvo);
		model.addAttribute("listProject",list);
		//��ü ���ڵ� �� ����
		int total = projectService.projectListCnt(pvo);
		
		model.addAttribute("pageMaker",new PageDTO(pvo,total,9));
		
		return "project/projectList";
	}
	
	
	//�ɼ� ��� ��ȯ
	@RequestMapping(value="/getOptionValue", produces = {MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<OptionVO>> getOptionValue(ContentVO cvo) {
		
		log.info("���ð� ȣ�� = "+cvo);
		ResponseEntity<List<OptionVO>> entity = null;
		entity = new ResponseEntity<>(projectService.getOptionValue(cvo), HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="/details/{project_num}")
	public String projectDetails(@PathVariable("project_num") Integer project_num, Model model){
		//log.info("�� �� = "+pvo);
		//log.info("detail������ ȣ��");
		ProjectVO pvo = new ProjectVO();
		pvo.setProject_num(project_num);
		ProjectVO result = projectService.projectDetail(pvo);
		model.addAttribute("project", result);
		
		log.info(result);
		
		return "project/projectDetail";
	}
}
