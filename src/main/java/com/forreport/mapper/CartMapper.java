package com.forreport.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.forreport.domain.CartVO;
import com.forreport.domain.IdPronumVO;
import com.forreport.domain.ProductVO;

public interface CartMapper {
	
	// 장바구니 사용자, 상품 번호를 받아 장바구니에 추가
	public int addCart(IdPronumVO cart);

	// 주문자의 장바구니 리스트 가져오기
	public List<CartVO> getCartList(String id);
	
	// 상품 가져오기
	public ProductVO getProduct(long pronum);
	
	// 장바구니 사용자가 담은 상품 중 특정 상품 삭제
	public int deleteCartProduct(IdPronumVO cart);
	
	// 장바구니 사용자가 담은 모든 상품 삭제
	public int deleteCartAll(String id);
	
	// 해당 사용자의 장바구니 목록 중 특정 상품 가져오기
	//public ProductVO getCartProduct(IdPronumVO cart);
}
