package com.dotori.client.cs_board.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dotori.client.cs_board.dao.Cs_BoardDao;
import com.dotori.client.cs_board.vo.Cs_BoardVO;
import com.dotori.client.cs_reply.dao.Cs_ReplyDao;
import com.dotori.client.cs_reply.vo.Cs_ReplyVO;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
public class Cs_BoardServiceImpl implements Cs_BoardService{
	
	@Setter(onMethod_=@Autowired)
	private Cs_BoardDao cs_boardDao;
	private Cs_ReplyDao cs_replyDao;
	
	//문의 게시판 리스트
	@Override
	public List<Cs_BoardVO> cs_boardList(Cs_BoardVO bvo) {
		List<Cs_BoardVO> List = null;
		List = new ArrayList<Cs_BoardVO>();
		List = cs_boardDao.cs_boardList(bvo);
		return List;
	}
	
	//문의 게시판 입력
	@Override
	public int cs_boardInsert(Cs_BoardVO bvo) {
		int result = 0;
		result = cs_boardDao.cs_boardInsert(bvo);
		return result;
	}
	//문의 상세정보
	@Override
	public Cs_BoardVO cs_boardDetail(int cs_num) {
		Cs_BoardVO cs_detail = new Cs_BoardVO();
		cs_detail = cs_boardDao.cs_boardDetail(cs_num);
		return cs_detail;
	}
	
	//창이동시 값 세팅용
	@Override
	public Cs_BoardVO cs_updateForm(int cs_num) {
		Cs_BoardVO detail = null;
		detail = cs_boardDao.cs_boardDetail(cs_num); 
		return detail;
	}
	
	//글 수정 DAO 접속
	@Override
	public int cs_boardUpdate(Cs_BoardVO bvo) {
		int result = 0;
		result = cs_boardDao.cs_boardUpdate(bvo);
		return result;
	}
	
	//문의 게시글 삭제
	@Override
	public int cs_boardDelete(int cs_num) {
		int result = 0;
		cs_replyDao.cs_replyAllDelete(cs_num);
		result = cs_boardDao.cs_boardDelete(cs_num);
		return result;
	}

	//문의 게시글 개수
	@Override
	public int cs_boardListCnt(Cs_BoardVO bvo) {
		int result = 0;
		result = cs_boardDao.cs_boardListCnt(bvo);
		return result;
	}
	
	//문의 게시글 마지막 생성 게시글 번호
	@Override
	public int cs_boardDetail_currnum() {
		int result = 0;
		result = cs_boardDao.cs_boardDetail_currnum();
		return result;
	}
	
	//조회수 업데이트
	@Override
	public int cs_hitsUpdate(Cs_BoardVO bvo) {
		int result = 0;
		result = cs_boardDao.cs_hitsUpdate(bvo);
		return result;
	}
	//조회수 값
	@Override
	public int cs_hits(int cs_num) {
		int result = 0;
		result = cs_boardDao.cs_hits(cs_num);
		return result;
	}
	
//관리자
	
	//관리자 공지글 생성
	@Override
	public int master_cs_boardInsert(Cs_BoardVO bvo) {
		int result = 0;
		result = cs_boardDao.master_cs_boardInsert(bvo);
		return result;
	}
	//관리자 공지 리스트
	@Override
	public List<Cs_BoardVO> master_cs_boardList(Cs_BoardVO bvo) {
		List<Cs_BoardVO> List = null;
		List = new ArrayList<Cs_BoardVO>();
		List = cs_boardDao.master_cs_boardList(bvo);
		return List;
	}
	
	//관리자 공지 업데이트
	@Override
	public int master_cs_boardUpdate(Cs_BoardVO bvo) {
		int result = 0;
		result = cs_boardDao.master_cs_boardUpdate(bvo);
		return result;
	}
	
	//관리자 공지 삭제
	@Override
	public int master_cs_boardDelete(int cs_num) {
		int result = 0;
		result = cs_boardDao.master_cs_boardDelete(cs_num);
		return result;
	}
	
	//관리자 공지 조회수 업데이트
	@Override
	public int master_cs_hitsUpdate(Cs_BoardVO bvo) {
		int result = 0;
		result = cs_boardDao.master_cs_hitsUpdate(bvo);
		return result;
	}

	//창이동시 값 세팅용
	@Override
	public Cs_BoardVO master_cs_updateForm(int cs_num) {
		Cs_BoardVO detail = null;
		detail = cs_boardDao.master_cs_boardDetail(cs_num); 
		return detail;
	}
	
	//관리자 공지 조회수 값
	@Override
	public int master_cs_hits(int cs_num) {
		int result = 0;
		result = cs_boardDao.master_cs_hits(cs_num);
		return result;
	}
	//관리자 상세정보
	@Override
	public Cs_BoardVO master_cs_boardDetail(int cs_num) {
		Cs_BoardVO cs_detail = new Cs_BoardVO();
		cs_detail = cs_boardDao.master_cs_boardDetail(cs_num);
		return cs_detail;
	}
	
	//문의 게시글 마지막 생성 게시글 번호
	@Override
	public int master_cs_boardDetail_currnum() {
		int result = 0;
		result = cs_boardDao.master_cs_boardDetail_currnum();
		return result;
	}
	
	//문의 게시글 개수
	@Override
	public int master_cs_boardListCnt(Cs_BoardVO bvo) {
		int result = 0;
		result = cs_boardDao.master_cs_boardListCnt(bvo);
		return result;
	}
	
	//관리자 공지 리스트 All
	public List<Cs_BoardVO> master_cs_boardAllList(Cs_BoardVO bvo) {
		List<Cs_BoardVO> List = null;
		List = new ArrayList<Cs_BoardVO>();
		List = cs_boardDao.master_cs_boardAllList(bvo);
		return List;
	}


}
