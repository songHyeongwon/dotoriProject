package com.dotori.client.faq_board.service;

import java.util.List;

import com.dotori.client.faq_board.vo.Faq_BoardVO;


public interface Faq_BoardService {
	public List<Faq_BoardVO> faq_boardList(Faq_BoardVO bvo);
	public int faq_boardInsert(Faq_BoardVO bvo);
	public Faq_BoardVO faq_boardDetail(int faq_num);
	public int faq_pwdConfirm(Faq_BoardVO bvo);
	public Faq_BoardVO faq_updateForm(int faq_num);
	public int faq_boardUpdate(Faq_BoardVO bvo);
	public int faq_boardDelete(int faq_num);
	public int faq_boardListCnt(Faq_BoardVO bvo);
	public int faq_boardDetail_currnum();
}
