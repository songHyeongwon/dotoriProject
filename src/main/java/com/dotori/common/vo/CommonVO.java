package com.dotori.common.vo;

import lombok.Data;

@Data
public class CommonVO {
	// ���ǰ˻��� ����� �ʵ�(�˻����, �˻��ܾ�)
	private String search = "";// �˻����
	private String keyword = "";// �˻���

	private int pageNum; // ������ ��ȣ
	private int amount; // �������� ������ ������ ��

	public CommonVO() {
		this(1, 10);
	}

	public CommonVO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
}
