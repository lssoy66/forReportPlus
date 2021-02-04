package com.forreport.service;

import java.util.List;

import com.forreport.domain.AdminCriteriaVO;
import com.forreport.domain.NoticeVO;
import com.forreport.domain.OrderVO;
import com.forreport.domain.ReviewCriteria;

public interface Admin2Service {

	public void register1(NoticeVO notice);

	public NoticeVO get1(int noticenum);

	public boolean modify1(NoticeVO notice);

	public boolean remove1(int noticenum);

	public List<NoticeVO> getList1(AdminCriteriaVO criteria);

	// 페이징 처리 된 주문리스트 가져오기
	public List<NoticeVO> getNoticeListAllWithPaging(ReviewCriteria criteria);

	// 전체 주문 수 가져오기
	public int getTotalCount(ReviewCriteria criteria);
	
	// 페이징 처리 된 주문리스트 가져오기
	public List<NoticeVO> getNoticeListAllWithPagingAdmin(AdminCriteriaVO criteria);
	
	// 전체 주문 수 가져오기
	public int getTotalCountAdmin(AdminCriteriaVO criteria);

}
