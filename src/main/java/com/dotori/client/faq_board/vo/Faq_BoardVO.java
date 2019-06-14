package com.dotori.client.faq_board.vo;



import com.dotori.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

//@EqualsAndHashCode �޼ҵ� �ڵ� ���� �� �θ� Ŭ������ �ʵ���� �������� �� ������ ���ؼ� ������
//callSuper=true�� �����ϸ� �θ� Ŭ���� �ʵ� ���鵵 ���� ���� üũ�ϸ�,
//callSuper=false�� ����(�⺻��)�ϸ� �ڽ� Ŭ������ �ʵ� ���鸸 ����Ѵ�.


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
