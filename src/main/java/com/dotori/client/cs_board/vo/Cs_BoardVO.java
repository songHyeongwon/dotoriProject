package com.dotori.client.cs_board.vo;



import com.dotori.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

//@EqualsAndHashCode �޼ҵ� �ڵ� ���� �� �θ� Ŭ������ �ʵ���� �������� �� ������ ���ؼ� ������
//callSuper=true�� �����ϸ� �θ� Ŭ���� �ʵ� ���鵵 ���� ���� üũ�ϸ�,
//callSuper=false�� ����(�⺻��)�ϸ� �ڽ� Ŭ������ �ʵ� ���鸸 ����Ѵ�.


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
