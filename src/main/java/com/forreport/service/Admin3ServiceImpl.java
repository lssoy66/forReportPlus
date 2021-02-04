package com.forreport.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.forreport.domain.NoticeVO;
import com.forreport.domain.QuestionVO;
import com.forreport.domain.ReviewCriteria;
import com.forreport.mapper.QuestionMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class Admin3ServiceImpl implements Admin3Service {
	//spring 4.3 이상에서 자동 처리
	private QuestionMapper mapper2;

	@Override
	public void register2(QuestionVO question) {
		log.info("register....."+question);
		mapper2.insertSelectKey2(question);
	}

	@Override
	public QuestionVO get2(int questionnum) {
		log.info("get....."+questionnum);
		return mapper2.read2(questionnum);
	}

	@Override
	public boolean modify2(QuestionVO question) {
		log.info("modify....."+question);
		return mapper2.update2(question) == 1;
	}

	@Override
	public boolean remove2(int questionnum) {
		log.info("remove....."+questionnum);
		return mapper2.delete2(questionnum) == 1;
	}

	@Override
	public List<QuestionVO> getList2() {
		log.info("getList.....");
		return mapper2.getList2();
	}
	
	// 페이징 처리 한 총 주문리스트 가져오기
		@Override
		public List<QuestionVO> getNoticeListAllWithPaging(ReviewCriteria criteria) {
			log.info("service ~ criteria :: " + criteria);
			return mapper2.getQuestionListAllWithPaging2(criteria);
		}

		// 총 주문 개수 구하기
		@Override
		public int getTotalCount(ReviewCriteria criteria) {
			return mapper2.getTotalCount2(criteria);
		}
		
		
	}


