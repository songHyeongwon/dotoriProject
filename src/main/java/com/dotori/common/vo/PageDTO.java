package com.dotori.common.vo;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage; // ȭ�鿡�� �������� �������� ���۹�ȣ
	private int endPage; // ȭ�鿡�� �������� �������� ����ȣ
	private boolean prev, next;// ������ ������ �̵��� ��ũ�� ǥ�� ����
	private int total;
	private CommonVO cvo;

	public PageDTO(CommonVO cvo, int total, int cnt) {
		this.cvo = cvo;
		this.total = total;
		this.cvo.setAmount(cnt);
		// �������� ����ȣ ���ϱ�
		// this.endPage = (int) (Math.ceil(��������ȣ/10.0))*10;
		this.endPage = (int) (Math.ceil(cvo.getPageNum() /  10.0)) * 10;
		// ������ ���۹�ȣ ���ϱ�
		this.startPage = endPage - 9;

		// �� ������ ���ϱ�
		int realEnd = (int) (Math.ceil((total * 1.0) / cvo.getAmount()));

		if (realEnd <= this.endPage) {
			this.endPage = realEnd;
		}

		// ����(prev) ���ϱ�
		this.prev = this.startPage > 1;

		// ����(next) ���ϱ�
		this.next = this.endPage < realEnd;

	}

	
}
