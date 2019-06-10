package com.dotori.client.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private int member_num;				// ȸ�� ��ȣ
	private String member_id;			// ȸ�� ���̵�
	private String member_pwd;			// ȸ�� ��й�ȣ
	private String member_name;			// ȸ�� �̸�
	private String member_address;		// ȸ�� �ּ�
	private String member_phone;		// ȸ�� ��ȣ
	private String member_eMail;		// ȸ�� �̸���
	private int member_kind;			// ����,���� ����
	private String member_sigNum;		// ȸ�� �ֹι�ȣ or ����� ��ȣ
	private String member_point;		// ȸ�� ���丮 ����
	private Date member_addDate;		// ȸ�� �����
	private Date member_mPwdDate;		// ȸ�� ��й�ȣ ������
	private String member_nickName;		// ȸ�� �г���
	private int member_infoAgree;		// ȸ�� ����ó�� ���ǿ���
	private int member_evenAgree;		// ȸ�� �޽���,�̸��Ͽ� ������ �ֱ� ���� ���ǿ���
	private String member_detailaddress;// ȸ�� ���ּ�
}
