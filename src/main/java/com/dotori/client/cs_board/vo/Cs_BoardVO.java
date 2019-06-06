package com.dotori.client.cs_board.vo;



import com.dotori.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

//@EqualsAndHashCode 메소드 자동 생성 시 부모 클래스의 필드까지 감안할지 안 할지에 대해서 결정시
//callSuper=true로 실행하면 부모 클래스 필드 값들도 동일 한지 체크하며,
//callSuper=false로 설정(기본값)하면 자신 클래스의 필드 값들만 고려한다.


@Data
@EqualsAndHashCode (callSuper=false)
public class Cs_BoardVO extends CommonVO{
	private int cs_num    = 0;
	private String cs_title    = "";
	private String cs_name    = "";
	private String editor    = "";
	private String t_editor    = "";
	private String cs_conf    = "";
	private String member_id    = "";
	private String cs_regDate    = "";
	private String cs_mDate    = "";
	private int cs_hits    = 0;
	private int cs_r_cnt    = 0;
	private String member_name;
}
