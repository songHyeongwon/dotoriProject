package com.dotori.manager.member.vo;

import java.util.Date;

import com.dotori.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberMVO extends CommonVO{
	private int member_num=0;				// ȸ�� ��ȣ
	private String member_id="";			// ȸ�� ���̵�
	private String member_pwd="";			// ȸ�� ��й�ȣ
	private String member_name="";			// ȸ�� �̸�
	private String member_address="";		// ȸ�� �ּ�
	private String member_phone="";		// ȸ�� ��ȣ
	private String member_eMail="";		// ȸ�� �̸���
	private int member_kind=0;			// ����,���� ����
	private String member_sigNum="";		// ȸ�� �ֹι�ȣ or ����� ��ȣ
	private int member_point=0;		// ȸ�� ���丮 ����
	private String member_addDate;		// ȸ�� �����
	private String member_mPwdDate;		// ȸ�� ��й�ȣ ������
	private String member_nickName="";		// ȸ�� �г���
	private int member_infoAgree=0;		// ȸ�� ����ó�� ���ǿ���
	private int member_evenAgree=0;		// ȸ�� �޽���,�̸��Ͽ� ������ �ֱ� ���� ���ǿ���
	private String member_detailAddress="";	// ȸ�� �� �ּ�
	private int member_chPwd=0;			// ȸ�� ��й�ȣ ���� Ȯ�� 
	private int member_pointCharge=0;	// ȸ���� ������ ���丮 ����
	
	private Date member_addDate2;		// ȸ�� �����
	private Date member_mPwdDate2;		// ȸ�� ��й�ȣ ������
}
