package com.dotori.common.vo;

import lombok.Data;

@Data
public class HomeControllerVO {
	private int project_count;		//승인 대기중인 프로젝트 수
	private int cs_board_count;		//답변 대기중인 게시글 수
	private int member_count;		//금일 신규가입한 회원수
	private int orders_sum_price;	//오늘 유동금액 총합
	
}
