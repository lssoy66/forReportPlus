package com.forreport.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.forreport.domain.AdminCriteriaVO;
import com.forreport.domain.NoticeVO;
import com.forreport.domain.OrderVO;
import com.forreport.domain.ReviewCriteria;

public interface NoticeMapper {

	// @Select("select * from tbl_notice where noticenum > 0")
	public List<NoticeVO> getList1();

	public void insert1(NoticeVO notice);

	public void insertSelectKey1(NoticeVO notice);

	public NoticeVO read1(int noticenum);

	public int delete1(int noticenum);

	public int update1(NoticeVO notice);

	// 총 주문 수 가져오기
	public int getTotalCount(ReviewCriteria criteria);
	
	// 모든 주문 리스트 가져오기
	public List<NoticeVO> getNoticeListAllWithPaging(ReviewCriteria criteria);
	
	
	// 총 주문 수 가져오기
	public int getTotalCountAdmin(AdminCriteriaVO criteria);

	// 모든 주문 리스트 가져오기
	public List<NoticeVO> getNoticeListAllWithPagingAdmin(AdminCriteriaVO criteria);

}
