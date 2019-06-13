package com.dotori.common.vo;

import lombok.Data;

@Data
public class CommonVO {
	// 조건검색시 사용할 필드(검색대상, 검색단어)
	private String search = "";// 검색대상
	private String keyword = "";// 검색어

	private int pageNum; // 페이지 번호
	private int amount; // 페이지에 보여줄 데이터 수

	public CommonVO() {
		this(1, 10);
	}

	public CommonVO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
}
