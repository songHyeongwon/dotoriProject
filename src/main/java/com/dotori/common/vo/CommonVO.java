package com.dotori.common.vo;

import lombok.Data;

@Data
public class CommonVO {
	// ���ǰ˻��� ����� �ʵ�(�˻����, �˻��ܾ�)
	private String search = "";// �˻����
	private String keyword = "";// �˻���
	private String path = "";// ����

	private int pageNum; // ������ ��ȣ
	private int amount; // �������� ������ ������ ��

	public CommonVO() {
		this(1, 10,"cs_numDesc");
	}

	public CommonVO(int pageNum, int amount,String path) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.path = path;
	}
}
