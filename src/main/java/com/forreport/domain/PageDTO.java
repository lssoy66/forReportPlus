package com.forreport.domain;

import lombok.Data;

@Data
public class PageDTO {

	private int startPage; /* 페이지 하단에 표시될 첫번째 페이지 번호 */
	private int endPage; /* 페이지 하단에 표시될 마지막 페이지 번호 */
	private boolean prev, next; /* 이전 페이지 세트, 다음 페이지 세트로 넘어갈 때 사용하는 변수 */

	private int total; /* 전체 게시글 개수 */
	private SearchingVO searchingVO; /* 현재 페이지 번호, 한번에 출력할 양, 검색어, 카테고리 정보 담은 객체 */
	private ReviewCriteria criteria;
	private AdminCriteriaVO adminCriteria;

	/* 그 외 정보: 페이지 하단에 표시될 페이지 번호의 개수: 10 */
	/* 상품 목록 + 관리자 상품 목록 모두 사용*/
	public PageDTO(SearchingVO searchingVO, int total) {

		/*
		 * 파라미터로 받아온 값으로 설정 - totla(전체 게시글 개수), searchingVO(현재 페이지에 대한 정보를 담은 변수)
		 * 
		 * 그 외 생성자에서 설정하는 변수 - endPage - 현재 페이지에서 10(한 페이지에 보여줄 페이지 번호의 개수)으로 나눈 후 * 10
		 * - 예시: 현재 페이지 12인 경우 > 12/10=2(올림처리) -> 2*10=20 -> 마지막 페이지 번호: 20 - startPage
		 * - 현재 페이지에서 가장 처음에 보여줄 페이지 번호 - endPage - 9
		 * 
		 * 기타 사용하는 변수 - realEnd - 혹시 전체 페이지 개수가 35개여야 하는데 현재 페이지가 32인 경우 endPage가 40으로
		 * 되는데, 이 경우를 35로 바꿔주는 변수 - 전체 게시글이 343개이고, amount가 10인 경우 --> realEnd 34P를
		 * endPage로 지정
		 * 
		 */

		this.total = total;
		this.searchingVO = searchingVO;

		this.endPage = ((int) Math.ceil(searchingVO.getPageNum() / 10.0)) * 10;
		this.startPage = endPage - 9;

		int realEnd = (int) Math.ceil((total * 1.0) / searchingVO.getAmount());
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}

		this.prev = this.startPage > 1; // 현 페이지의 시작 페이지 번호가 1보다 큰 경우 prev 버튼 추가 예정
		this.next = this.endPage < realEnd; // 현 페이지의 마지막 번호가 realEnd보다 작은 경우 next 버튼 추가 예정
		
		System.out.println(endPage);
		System.out.println(realEnd);

	}

	// ReviewCriteria를 이용한 페이징 처리(주문리스트에 사용했습니다)
	public PageDTO(ReviewCriteria criteria, int total) {

		this.total = total;
		this.criteria = criteria;

		this.endPage = ((int) Math.ceil(criteria.getPageNum() / 10.0)) * 10;
		this.startPage = endPage - 9;

		int realEnd = (int) Math.ceil((total * 1.0) / criteria.getAmount());
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}

		this.prev = this.startPage > 1; // 현 페이지의 시작 페이지 번호가 1보다 큰 경우 prev 버튼 추가 예정
		this.next = this.endPage < realEnd; // 현 페이지의 마지막 번호가 realEnd보다 작은 경우 next 버튼 추가 예정

	}
	
	// adminCriteria를 이용한 페이징 처리(주문리스트에 사용했습니다)
		public PageDTO(AdminCriteriaVO adminCriteria, int total) {

			this.total = total;
			this.adminCriteria = adminCriteria;

			this.endPage = ((int) Math.ceil(adminCriteria.getPageNum() / 10.0)) * 10;
			this.startPage = endPage - 9;

			int realEnd = (int) Math.ceil((total * 1.0) / adminCriteria.getAmount());
			if (realEnd < this.endPage) {
				this.endPage = realEnd;
			}

			this.prev = this.startPage > 1; // 현 페이지의 시작 페이지 번호가 1보다 큰 경우 prev 버튼 추가 예정
			this.next = this.endPage < realEnd; // 현 페이지의 마지막 번호가 realEnd보다 작은 경우 next 버튼 추가 예정

		}
	
	

}
