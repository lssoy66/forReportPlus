package com.forreport.service;

import java.util.List;

import com.forreport.domain.OrderVO;
import com.forreport.domain.ProductVO;
import com.forreport.domain.ReviewCriteria;
import com.forreport.domain.VbankVO;

public interface OrderService {

	// 사용자가 선택한 특정 상품들 가져오기
	public List<ProductVO> getCartProduct(String id, String[] checkPronum);
	
	// 주문 테이블에 추가
	public int addOrder(OrderVO order);
	
	// 사용자의 주문 정보 가져오기
	public List<OrderVO> getOrderList(String id);
	
	// 가상계좌정보 가져오기
	public VbankVO getVbank(String id, long ordernum);
	
	// 페이징 처리 된 주문리스트 가져오기
	public List<OrderVO> getOrderListAllWithPaging(ReviewCriteria criteria);
	
	// 전체 주문 수 가져오기
	public int getTotalCount(ReviewCriteria criteria);
	
}
