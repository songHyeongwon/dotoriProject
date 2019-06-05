package com.dotori.client.cs_reply.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dotori.client.cs_reply.service.Cs_ReplyService;
import com.dotori.client.cs_reply.vo.Cs_ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//클래스 Controller 와 ResponseBody의 결합
@RestController
@RequestMapping(value = "/replies/*")
@Log4j
public class Cs_ReplyController {
	// 설정자
	@Setter(onMethod_ = @Autowired)
	private Cs_ReplyService replyService;

	// 덧글 조회
	@GetMapping(value = "/all/{cs_num}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<Cs_ReplyVO>> replyList(@PathVariable("cs_num") Integer cs_num) {
		log.info("list 호출 성공");
		ResponseEntity<List<Cs_ReplyVO>> entity = null;
		entity = new ResponseEntity<>(replyService.cs_replyList(cs_num), HttpStatus.OK);
		return entity;
	}

	// 덧글 입력
	@RequestMapping(value = "/replyInsert", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> replyInsert(@RequestBody Cs_ReplyVO rvo) {
		log.info("replyInsert 호출 성공");
		log.info("ReplyVO : " + rvo);
		int result = 0;

		result = replyService.cs_replyInsert(rvo);
		return result == 1 ? 
				new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//댓글 삭제
	@DeleteMapping(value = "/{cs_r_num}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> replyDelete(@PathVariable("cs_r_num") Integer cs_r_num) {
		log.info("replyDelete 호출 성공");

		int result = replyService.cs_replyDelete(cs_r_num);
		return result == 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//수정 전 댓글 정보 조회하기
	@GetMapping(value = "/{cs_r_num}", produces = { MediaType.APPLICATION_XHTML_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<Cs_ReplyVO> replySelect(@PathVariable("cs_r_num") Integer cs_r_num) {
		log.info("replySelect 호출 성공");
		ResponseEntity<Cs_ReplyVO> entity = null;
		entity = new ResponseEntity<Cs_ReplyVO>(replyService.cs_replySelect(cs_r_num), HttpStatus.OK);
		return entity;
	}

	// 댓글 업데이트 구현하기
	@PutMapping(value = "/{cs_r_num}", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> replyUpdate(@RequestBody Cs_ReplyVO rvo, @PathVariable("cs_r_num") Integer cs_r_num) {
		log.info("replyUpdate 호출 성공");
		log.info("파라메터 값 = " + rvo + " "+cs_r_num);

		int result = replyService.cs_replyUpdate(rvo);
		return result == 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
