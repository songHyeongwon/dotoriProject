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

//Ŭ���� Controller �� ResponseBody�� ����
@RestController
@RequestMapping(value = "/replies/*")
@Log4j
public class Cs_ReplyController {
	// ������
	@Setter(onMethod_ = @Autowired)
	private Cs_ReplyService replyService;

	// ���� ��ȸ
	@GetMapping(value = "/all/{cs_num}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<Cs_ReplyVO>> replyList(@PathVariable("cs_num") Integer cs_num) {
		log.info("list ȣ�� ����");
		ResponseEntity<List<Cs_ReplyVO>> entity = null;
		entity = new ResponseEntity<>(replyService.cs_replyList(cs_num), HttpStatus.OK);
		return entity;
	}

	// ���� �Է�
	@RequestMapping(value = "/replyInsert", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> replyInsert(@RequestBody Cs_ReplyVO rvo) {
		log.info("replyInsert ȣ�� ����");
		log.info("ReplyVO : " + rvo);
		int result = 0;

		result = replyService.cs_replyInsert(rvo);
		return result == 1 ? 
				new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//��� ����
	@DeleteMapping(value = "/{cs_r_num}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> replyDelete(@PathVariable("cs_r_num") Integer cs_r_num) {
		log.info("replyDelete ȣ�� ����");

		int result = replyService.cs_replyDelete(cs_r_num);
		return result == 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//���� �� ��� ���� ��ȸ�ϱ�
	@GetMapping(value = "/{cs_r_num}", produces = { MediaType.APPLICATION_XHTML_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<Cs_ReplyVO> replySelect(@PathVariable("cs_r_num") Integer cs_r_num) {
		log.info("replySelect ȣ�� ����");
		ResponseEntity<Cs_ReplyVO> entity = null;
		entity = new ResponseEntity<Cs_ReplyVO>(replyService.cs_replySelect(cs_r_num), HttpStatus.OK);
		return entity;
	}

	// ��� ������Ʈ �����ϱ�
	@PutMapping(value = "/{cs_r_num}", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> replyUpdate(@RequestBody Cs_ReplyVO rvo, @PathVariable("cs_r_num") Integer cs_r_num) {
		log.info("replyUpdate ȣ�� ����");
		log.info("�Ķ���� �� = " + rvo + " "+cs_r_num);

		int result = replyService.cs_replyUpdate(rvo);
		return result == 1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
