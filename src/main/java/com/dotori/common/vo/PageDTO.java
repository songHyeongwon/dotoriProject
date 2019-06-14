package com.dotori.common.vo;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage; // 화면에서 보여지는 페이지의 시작번호
	private int endPage; // 화면에서 보여지는 페이지의 끝번호
	private boolean prev, next;// 이전과 다음로 이동한 링크의 표시 여부
	private int total;
	private CommonVO cvo;
	//cnt 값만큼 페이지안에서 갯수를 보여줍니다.
	public PageDTO(CommonVO cvo, int total, int cnt) {
		this.cvo = cvo;
		//cvo.setAmount(cnt);
		this.cvo.setAmount(cnt);
		this.total = total;
		// 페이지의 끝번호 구하기
		// this.endPage = (int) (Math.ceil(페이지번호/10.0))*10;
		this.endPage = (int) (Math.ceil(cvo.getPageNum() /  (cnt*1.0))) * cnt;
		// 페이지 시작번호 구하기
		this.startPage = endPage - (cnt-1);
		// 끝 페이지 구하기
		int realEnd = (int) (Math.ceil((total * 1.0) / cvo.getAmount()));

		if (realEnd <= this.endPage) {
			this.endPage = realEnd;
		}

		// 이전(prev) 구하기
		this.prev = this.startPage > 1;

		// 다음(next) 구하기
		this.next = this.endPage < realEnd;

	}
}