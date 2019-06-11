package com.dotori.client.project.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dotori.client.cs_reply.vo.Cs_ReplyVO;
import com.dotori.client.project.service.ProjectService;
import com.dotori.client.project.vo.ReplyVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/projectReply/*")
@RestController
@Log4j
@AllArgsConstructor
public class ProjectReplyController {
	
	private ProjectService projectService;
	
	@RequestMapping(value = "/replyInsert", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> replyInsert(@RequestBody ReplyVO rvo) {
		log.info("프로젝트 replyInsert 호출 성공");
		log.info("ReplyVO : " + rvo);
		int result = 0;

		result = projectService.replyInsert(rvo);
		return result == 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/all/{reply_table_name}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<ReplyVO>> replyList(@PathVariable("reply_table_name") String tableName) {
		log.info("list 호출 성공");
		ReplyVO rvo = new ReplyVO();
		rvo.setReply_table_name(tableName);
		ResponseEntity<List<ReplyVO>> entity = null;
		entity = new ResponseEntity<>(projectService.replyList(rvo), HttpStatus.OK);
		return entity;
	}
	
	//댓글 삭제
	@DeleteMapping(value = "/{cs_r_num}/{reply_table_name}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> replyDelete(@PathVariable("cs_r_num") Integer cs_r_num, @PathVariable("reply_table_name") String reply_table_name) {
		log.info("replyDelete 호출 성공");
		ReplyVO rvo = new ReplyVO();
		rvo.setReply_num(cs_r_num);
		rvo.setReply_table_name(reply_table_name);
		int result = projectService.replyDelete(rvo);
		return result == 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
