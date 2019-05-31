package com.dotori.client.cs_board.dao;

import java.util.List;

import com.dotori.client.cs_board.vo.Cs_BoardVO;

public interface Cs_BoardDao {
	public List<Cs_BoardVO> cs_boardList(Cs_BoardVO bvo);
	public List<Cs_BoardVO> cs_boardList_pt(Cs_BoardVO bvo);
	public int cs_boardInsert(Cs_BoardVO bvo);
	public Cs_BoardVO cs_boardDetail(int cs_num);
	public int cs_pwdConfirm(Cs_BoardVO bvo);
	public int cs_boardUpdate(Cs_BoardVO bvo);
	public int cs_boardDelete(int cs_num);
	public int cs_boardListCnt(Cs_BoardVO bvo);
	public int cs_boardDetail_currnum();
}
