package com.dotori.client.faq_board.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dotori.client.faq_board.dao.Faq_BoardDao;
import com.dotori.client.faq_board.vo.Faq_BoardVO;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class Faq_BoardServiceImpl implements Faq_BoardService{
	
	@Setter(onMethod_=@Autowired)
	private Faq_BoardDao faq_boardDao;
	
	//���� �Խ��� ����Ʈ
	@Override
	public List<Faq_BoardVO> faq_boardList(Faq_BoardVO bvo) {
		List<Faq_BoardVO> List = null;
		List = new ArrayList<Faq_BoardVO>();
		List = faq_boardDao.faq_boardList(bvo);
		return List;
	}
	
	//���� �Խ��� �Է�
	@Override
	public int faq_boardInsert(Faq_BoardVO bvo) {
		int result = 0;
		result = faq_boardDao.faq_boardInsert(bvo);
		return result;
	}

	@Override
	public Faq_BoardVO faq_boardDetail(int faq_num) {
		Faq_BoardVO faq_detail = new Faq_BoardVO();
		faq_detail = faq_boardDao.faq_boardDetail(faq_num);
		if(faq_detail!=null) {
			//faq_detail.setB_content(detail.getB_content().toString().replaceAll("\n", "<br>"));
		}
		return faq_detail;
	}

	//��й�ȣ Ȯ�� ����
	@Override
	public int faq_pwdConfirm(Faq_BoardVO bvo) {
		int result = 0;
		result = faq_boardDao.faq_pwdConfirm(bvo);
		return result;
	}
	
	//â�̵��� �� ���ÿ�
	@Override
	public Faq_BoardVO faq_updateForm(int faq_num) {
		Faq_BoardVO detail = null;
		detail = faq_boardDao.faq_boardDetail(faq_num); 
		return detail;
	}
	
	//�� ���� DAO ����
	@Override
	public int faq_boardUpdate(Faq_BoardVO bvo) {
		int result = 0;
		result = faq_boardDao.faq_boardUpdate(bvo);
		return result;
	}

	@Override
	public int faq_boardDelete(int faq_num) {
		int result = 0;
		result = faq_boardDao.faq_boardDelete(faq_num);
		return result;
	}

	@Override
	public int faq_boardListCnt(Faq_BoardVO bvo) {
		int result = 0;
		result = faq_boardDao.faq_boardListCnt(bvo);
		return result;
	}
	@Override
	public int faq_boardDetail_currnum() {
		int result = 0;
		result = faq_boardDao.faq_boardDetail_currnum();
		return result;
	}
}
