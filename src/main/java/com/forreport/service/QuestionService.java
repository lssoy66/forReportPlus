package com.forreport.service;

import java.util.List;

import com.forreport.domain.AdminCriteriaVO;
import com.forreport.domain.NoticeVO;
import com.forreport.domain.QuestionVO;
import com.forreport.domain.ReviewCriteria;

public interface QuestionService {

	public void register2(QuestionVO question);

	public QuestionVO get2(int questionnum);

	public boolean modify2(QuestionVO question);

	public boolean remove2(int questionnum);

	public List<QuestionVO> getList2();

	// 페이징 처리 된 주문리스트 가져오기
	public List<QuestionVO> getQuestionListAllWithPaging2(ReviewCriteria criteria);

	// 전체 주문 수 가져오기
	public int getTotalCount2(ReviewCriteria criteria);

	// 페이징 처리 된 주문리스트 가져오기
	public List<QuestionVO> getQuestionListAllWithPagingAdmin2(AdminCriteriaVO criteria);

	// 전체 주문 수 가져오기
	public int getTotalCountAdmin2(AdminCriteriaVO criteria);

	

}
