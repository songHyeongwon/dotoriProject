package com.dotori.client.project.vo;

import java.util.ArrayList;

public class Test {
	public static void main(String[] args) {
		String value = "/»¡°­/³ë¶û/ÃÊ·Ï ";
		value = value.substring(value.indexOf("/"),value.length());
		String[] values = value.split("/");
		for(int i = 0; i<values.length;i++) {
			System.out.println(values[i]);
		}
	}
}
