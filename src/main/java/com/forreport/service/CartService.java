package com.forreport.service;

import java.util.List;

import com.forreport.domain.CartVO;
import com.forreport.domain.IdPronumVO;
import com.forreport.domain.ProductVO;

public interface CartService {

	// 장바구니에 상품 추가
	public int addCart(IdPronumVO cart);

	// 장바구니에 담긴 상품정보(리스트) 가져오기
	public List<ProductVO> getCartList(String userId);

	// 장바구니 사용자가 담은 상품 중 특정 상품 삭제
	public int deleteCartProduct(IdPronumVO cart);

	// 장바구니 사용자가 담은 모든 상품 삭제
	public int deleteCartAll(String id);
}
