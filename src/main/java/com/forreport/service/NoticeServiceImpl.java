package com.forreport.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.forreport.domain.AdminCriteriaVO;
import com.forreport.domain.NoticeVO;
import com.forreport.domain.OrderVO;
import com.forreport.domain.ReviewCriteria;
import com.forreport.mapper.NoticeMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService {
	// spring 4.3 이상에서 자동 처리
	private NoticeMapper mapper1;

	@Override
	public void register1(NoticeVO notice) {
		log.info("register....." + notice);
		mapper1.insertSelectKey1(notice);
	}

	@Override
	public NoticeVO get1(int noticenum) {
		log.info("get....." + noticenum);
		return mapper1.read1(noticenum);
	}

	@Override
	public boolean modify1(NoticeVO notice) {
		log.info("modify....." + notice);
		return mapper1.update1(notice) == 1;
	}

	@Override
	public boolean remove1(int noticenum) {
		log.info("remove....." + noticenum);
		return mapper1.delete1(noticenum) == 1;
	}

	@Override
	public List<NoticeVO> getList1() {
		log.info("getList.....");
		return mapper1.getList1();
	}

	// 공지사항
	// 페이징 처리 한 총 주문리스트 가져오기
	@Override
	public List<NoticeVO> getNoticeListAllWithPaging(ReviewCriteria criteria) {
		log.info("service ~ criteria :: " + criteria);
		return mapper1.getNoticeListAllWithPaging(criteria);
	}

	// 총 주문 개수 구하기
	@Override
	public int getTotalCount(ReviewCriteria criteria) {
		return mapper1.getTotalCount(criteria);
	}

	// 관리자용
	// 페이징 처리 한 총 주문리스트 가져오기
	@Override
	public List<NoticeVO> getNoticeListAllWithPagingAdmin(AdminCriteriaVO criteria) {
		log.info("service ~ criteria :: " + criteria);
		return mapper1.getNoticeListAllWithPagingAdmin(criteria);
	}

	// 총 주문 개수 구하기
	@Override
	public int getTotalCountAdmin(AdminCriteriaVO criteria) {
		return mapper1.getTotalCountAdmin(criteria);
	}

}
