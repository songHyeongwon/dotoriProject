package com.dotori.client.faq_board.vo;



import com.dotori.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

//@EqualsAndHashCode 메소드 자동 생성 시 부모 클래스의 필드까지 감안할지 안 할지에 대해서 결정시
//callSuper=true로 실행하면 부모 클래스 필드 값들도 동일 한지 체크하며,
//callSuper=false로 설정(기본값)하면 자신 클래스의 필드 값들만 고려한다.


@Data
@EqualsAndHashCode (callSuper=false)
public class Faq_BoardVO extends CommonVO{
	private int faq_num = 0;
	private String faq_title = "";
	private String editor    = "";
	private String t_editor    = "";
	private String member_id    = "";
	private String faq_regDate    = "";
	private String faq_mDate    = "";
	//private String member_name    = "";
}
