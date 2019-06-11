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
	//프로젝트 서비스 선언
	private ProjectService projectService;
	
	/********************************************************************************************
	 * 프로젝트 insert 폼 반환 메서드																	*
	 ********************************************************************************************/
	@RequestMapping(value="/insertForm")
	public String projectInsertFrom() {
		return "project/projectInsert";
	}
	
	/********************************************************************************************
	 * 소분류 목록을 불러들이는 메서드																		*
	 ********************************************************************************************/
	@GetMapping(value="/getPatterns/{Project_pattern1}", produces = {MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE } )
	public ResponseEntity<List<ProjectVO>> getPatterns(@PathVariable("Project_pattern1") String project_pattern1) {
		
		log.info("선택값 호출 = "+project_pattern1);
		ResponseEntity<List<ProjectVO>> entity = null;
		entity = new ResponseEntity<>(projectService.getPatterns(project_pattern1), HttpStatus.OK);
		return entity;
	}
	
	/********************************************************************************************
	 * 프로젝트 insert 폼에서 서브밋하면 값을 받아 처리하는 메서드													*
	 ********************************************************************************************/
	@RequestMapping(value="/insertProject")
	public String projectInsert(@ModelAttribute ProjectVO pvo) {
		log.info("insert 안에 들어 왔습니다.");
		log.info("들어온값"+pvo);
		
		//pk키 가져오기
		int Pknum = projectService.getProjectPKNum();
		
		String id = pvo.getMember_id();
		pvo.setProject_num(Pknum);
		pvo.setReply_table_name(id+"_"+Pknum+"_reply");
		pvo.setOption_table_name(id+"_"+Pknum+"_option");
		pvo.setContent_table_name(id+"_"+Pknum+"_content");
		pvo.setQna_board_table_name(id+"_"+Pknum+"_qna_board");
		
		//각각 테이블 생성하기
		int result = 0;
		result = projectService.createContentTable(pvo);
		result = projectService.createReplyTable(pvo);
		result = projectService.createOptionTable(pvo);
		result = projectService.createQna_boardTable(pvo);
		
		result = projectService.createContentTableSeq(pvo);
		result = projectService.createReplyTableSeq(pvo);
		result = projectService.createQna_boardTableSeq(pvo);
		
		//프로젝트 인설트
		result = projectService.insertProject(pvo);
		result = projectService.insertProjectContentTable(pvo);
		if(result==0) {
			log.info("======================================아마오류?=================================");
		}
		return "index";
	}
	/********************************************************************************************
	 * 프로젝트의 모든 내용을 반환해 보여주는 메서드																*
	 ********************************************************************************************/
	@RequestMapping(value="/listForm",method=RequestMethod.GET)
	public String projectList(@ModelAttribute ProjectVO pvo, Model model) {
		log.info("ProjectList 호출 성공");
		projectService.updateStatus();
		List<ProjectVO> list = projectService.projectList(pvo);
		model.addAttribute("listProject",list);
		
		//전체 레코드 수 구현
		int total = projectService.projectListCnt(pvo);
		log.info("============================================="+pvo);
		log.info("총 칼럼 갯수는 = "+total);
		model.addAttribute("pageMaker",new PageDTO(pvo,total,9));
		
		//log.info("들어오는 값은 = "+new PageDTO(pvo,total,10));
		return "project/projectList";
	}
	/********************************************************************************************
	 * 프로젝트 종류 눌렀을시 그 내용을 보여주는 메서드															*
	 ********************************************************************************************/
	@RequestMapping(value="/detail",method=RequestMethod.POST)
	public String projectDetail(@ModelAttribute ProjectVO pvo, Model model){
		log.info("들어간 값 = "+pvo);
		log.info("detail페이지 호출");
		ProjectVO result = projectService.projectDetail(pvo);
		model.addAttribute("project", result);
		
		log.info(result);
		
		return "project/projectDetail";
	}
	/********************************************************************************************
	 * nav의 값을 눌렀을때 해당하는 값만 찾아오는 메서드															*
	 ********************************************************************************************/
	@GetMapping(value="/getPatterns2"/*, produces = MediaType.APPLICATION_JSON_UTF8_VALUE*/)
	public String navprojectList(@ModelAttribute ProjectVO pvo, Model model) {
		
		log.info("navprojectList 호출");
		//검색 값 입력
		pvo.setSearch("Patterns2");
		List<ProjectVO> list = projectService.projectList(pvo);
		model.addAttribute("listProject",list);
		//전체 레코드 수 구현
		int total = projectService.projectListCnt(pvo);
		
		model.addAttribute("pageMaker",new PageDTO(pvo,total,9));
		
		return "project/projectList";
	}
	
	
	//옵션 밸류 반환
	@RequestMapping(value="/getOptionValue", produces = {MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<OptionVO>> getOptionValue(ContentVO cvo) {
		
		log.info("선택값 호출 = "+cvo);
		ResponseEntity<List<OptionVO>> entity = null;
		entity = new ResponseEntity<>(projectService.getOptionValue(cvo), HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="/details/{project_num}")
	public String projectDetails(@PathVariable("project_num") Integer project_num, Model model){
		//log.info("들어간 값 = "+pvo);
		//log.info("detail페이지 호출");
		ProjectVO pvo = new ProjectVO();
		pvo.setProject_num(project_num);
		ProjectVO result = projectService.projectDetail(pvo);
		model.addAttribute("project", result);
		
		log.info(result);
		
		return "project/projectDetail";
	}
}
