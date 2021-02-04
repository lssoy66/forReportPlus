package com.forreport.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.forreport.domain.OrderVO;
import com.forreport.domain.ReviewCriteria;
import com.forreport.domain.VbankVO;

public interface OrderMapper {
	
	// 주문 테이블에 데이터 추가
	public int addOrder(OrderVO order);
	
	// 사용자의 주문 테이블 리스트 가져오기
	public List<OrderVO> getOrderList(String id);
	
	// 가상계좌 테이블에 데이터 추가
	public int addVbank(VbankVO vbank);
	
	// 가상계좌 정보 가져오기
	public VbankVO getVbank(@Param("id") String id, @Param("ordernum") long ordernum);
	
	// 모든 주문 리스트 가져오기
	public List<OrderVO> getOrderListAllWithPaging(ReviewCriteria criteria);
	
	// 총 주문 수 가져오기
	public int getTotalCount(ReviewCriteria criteria);

	// 특정 상품의 총 주문 수 가져오기
	public int getTotalCountByPronum(long pronum);	
	
	// 은지
	/* 리뷰작성자가 해당 제품 구매했는지 여부 확인 */
	public int getOrderData(@Param("id") String id, @Param("pronum") int pronum);
	
	// 상품번호와 일치하는 주문테이블의 주문번호를 가져옴
	public long getOrder(@Param("id") String id, @Param("pronum") long pronum);

	
}
