package com.forreport.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.forreport.domain.IdPronumVO;
import com.forreport.domain.MiniComparator;
import com.forreport.domain.OrderVO;
import com.forreport.domain.PageDTO;
import com.forreport.domain.ProductVO;
import com.forreport.domain.ReviewCriteria;
import com.forreport.domain.VbankVO;
import com.forreport.service.CartService;
import com.forreport.service.OrderService;
import com.forreport.service.ProductService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/order/*")
@AllArgsConstructor
public class OrderController {

	private OrderService service;
	private ProductService productService;
	
	// 주문 페이지 출력(사용자가 선택한 상품의 정보를 화면에 표시)
	@PostMapping("order.fr")
	public void orderList(@RequestParam("id") String id, 
			@RequestParam("checkPronum") String[] checkPronum, 
			@RequestParam("price") int price,
			Model model) {
		//log.info(service.getCartProduct(id, checkPronum));
		model.addAttribute("price", price);
		model.addAttribute("orderProductList", service.getCartProduct(id, checkPronum));
	}
	
	// 결제 API 테스트
	@GetMapping(value = "complete", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	@ResponseBody
	public ResponseEntity<String> TestAmount(Long amount){
		log.info("amount :: " + amount);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}
	
	// 주문 테이블에 데이터 저장
	// 결제 완료 = 주문 테이블 저장이므로 장바구니 삭제도 동시에
	@PostMapping("orderProcess.fr")
	public String orderProcess(OrderVO order, Model model) {
		// 뷰 페이지로 전달해야 하는 것 : 주문정보테이블의 정보, 총 결제금액, 주문한 상품리스트, 가상계좌 정보, 주문자 정보
		log.info(order);
		model.addAttribute("priceAll", order.getPayprice());
		
		int result = service.addOrder(order);
		log.info(result);
		
		// 해당 사용자의 주문내역 중, 오늘 날짜인 것을 전달
		List<OrderVO> orderList = service.getOrderList(order.getId());
		SimpleDateFormat dataformat = new SimpleDateFormat("yyyy-MM-dd");
		for(int i = 0; i < orderList.size(); i++) {
			if(dataformat.format(orderList.get(i).getOrderdate()).equals(dataformat.format(new Date()))) {
				log.info(orderList.get(i));
				if(order.getPronum() == orderList.get(i).getPronum()) {
					model.addAttribute("order", orderList.get(i));
					// 가상계좌정보를 전달(아이디와 주문번호를 전달) - 화면에 한번 표시할 용도이므로 한 개만 전달O
					model.addAttribute("vbank", 
							service.getVbank(orderList.get(i).getId(), orderList.get(i).getOrdernum()));
				}
			}
		}
		
		// 상품리스트를 전달
		String[] pronumArr = new String[order.getPronumList().size()];
		for(int i = 0; i < order.getPronumList().size(); i++) {
			pronumArr[i] = order.getPronumList().get(i).toString();
		}	
		model.addAttribute("productList", service.getCartProduct(order.getId(), pronumArr));
		
		
		
		return result > 0 ? "order/orderSuccess" : null;
	}
	
	// 내 정보 - 주문리스트 페이지
	@GetMapping("myOrderList.fr")
	public void myOrderList(Model model, Principal principal) {
		
		// 사용자의 모든 주문 리스트를 전달
		List<OrderVO> orderList = service.getOrderList(principal.getName());
		model.addAttribute("orderList", orderList);
		
		// 사용자가 발급받은 모든 계좌번호 리스트를 전달
		List<VbankVO> vbankList = new ArrayList<>();
		for(OrderVO order : orderList) {
			vbankList.add(service.getVbank(principal.getName(), order.getOrdernum()));
		}
		model.addAttribute("vbankList", vbankList);
	}
	
	// 내 정보 - 판매리스트 페이지
	@GetMapping("mySaleList.fr")
	public void mySaleList(Model model, Principal principal, ReviewCriteria criteria) {
		
		// 한 페이지 당 4개씩 출력
		criteria.setAmount(4);
		
		// 판매자의 등록 상품 + 각 상품의 판매(주문) 수(페이징 처리했으므로, 4개의 ProductVO)
		List<ProductVO> list = productService.getProductById(principal.getName(), criteria);
		model.addAttribute("saleList", list);
		
		// criteria + 판매자가 등록한 상품의 총 개수 사용하여 화면 페이징 처리를 위한 PageDTO 객체 생성
		model.addAttribute("pageMaker", 
				new PageDTO(criteria, productService.getTotalCountById(principal.getName())));
	
		// 총 수익금(판매자의 모든 등록 상품 리스트를 가져온 후, 각각의 가격과 주문 개수(count)를 사용해 총 수익금 전달)
		List<ProductVO> listAll = productService.getProductByIdNotPaging(principal.getName());
		int sum = 0;	// 총 수익금
		for(ProductVO product : listAll) {
			if(product.getCount() > 0) {
				sum += product.getPrice() * product.getCount();
			}
		}
		
		model.addAttribute("priceAll", sum);
		model.addAttribute("saleCount", listAll.size());	// 판매자의 등록 자료 개수
		
		// 판매 수 내림차순으로 정렬한 판매자 등록 상품 리스트 전달
		MiniComparator comp = new MiniComparator();
		Collections.sort(listAll, comp);
		model.addAttribute("saleListDescCount", listAll);
	
		
	}
	
}







