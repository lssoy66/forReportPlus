package com.forreport.domain;

import java.util.Comparator;

public class MiniComparator implements Comparator<ProductVO> {

	@Override
	public int compare(ProductVO o1, ProductVO o2) {
		
		int firstValue = o1.getCount();
		int secondValue = o2.getCount();
		
		// 내림차순
		if(firstValue > secondValue) {
			return -1;	
		} else if(firstValue < secondValue) {
			return 1;
		} else {
			return 0;
		}
		
	}
	
}
