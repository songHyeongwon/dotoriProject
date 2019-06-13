package com.dotori.client.project.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dotori.client.project.service.ProjectService;
import com.dotori.client.project.vo.QnaBoard;
import com.dotori.client.project.vo.ReplyVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/projectBoard/*")
@RestController
@Log4j
@AllArgsConstructor
public class ProjectBoardController {
	private ProjectService projectService;
	
	@RequestMapping(value = "/boardInsert", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> boardInsert(@RequestBody QnaBoard qvo) {
		log.info("프로젝트 replyInsert 호출 성공");
		log.info("QnaBoard : " + qvo);
		int result = 0;
		
		
		result = projectService.boardInsert(qvo);
		return result == 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/allboard/{qna_board_table_name}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<QnaBoard>> boardList(@PathVariable("qna_board_table_name") String tableName) {
		log.info("list 호출 성공");
		QnaBoard qvo = new QnaBoard();
		qvo.setQna_board_table_name(tableName);
		ResponseEntity<List<QnaBoard>> entity = null;
		entity = new ResponseEntity<>(projectService.boardList(qvo), HttpStatus.OK);
		return entity;
	}
	
	//댓글 삭제
	@DeleteMapping(value = "/board/{qna_num}/{qna_board_table_name}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> boardDelete(@PathVariable("qna_num") Integer qna_num, @PathVariable("qna_board_table_name") String qna_board_table_name) {
		log.info("boardDelete 호출 성공");
		QnaBoard qvo = new QnaBoard();
		qvo.setQna_num(qna_num);
		qvo.setQna_board_table_name(qna_board_table_name);
		int result = projectService.boardDelete(qvo);
		return result >= 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
					: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 업데이트 구현하기
	@PutMapping(value = "/update/{qna_num}/{qna_board_table_name}", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> replyUpdate(@RequestBody QnaBoard qvo, @PathVariable("qna_num") Integer qna_num, @PathVariable("qna_board_table_name") String qna_board_table_name) {
		log.info("replyUpdate 호출 성공");
		qvo.setQna_num(qna_num);
		qvo.setQna_board_table_name(qna_board_table_name);
		int result = projectService.boardUpdate(qvo);
		return result == 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(value = "/QnaInsert", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> qnaInsert(@RequestBody QnaBoard qvo) {
		log.info("프로젝트 replyInsert 호출 성공");
		log.info("QnaBoard : " + qvo);
		int result = 0;
		
		
		result = projectService.qnaInsert(qvo);
		return result == 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
