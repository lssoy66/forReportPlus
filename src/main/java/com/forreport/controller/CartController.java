package com.forreport.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.forreport.domain.IdPronumVO;
import com.forreport.domain.OrderVO;
import com.forreport.domain.ProductVO;
import com.forreport.service.CartService;
import com.forreport.service.OrderService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/cart/*")
@AllArgsConstructor
public class CartController {

	private CartService service;
	private OrderService orderService;

	// 장바구니 리스트
	@GetMapping("cartList.fr")
	public void cartList(Model model, Principal principal) {
		log.info("CartController userName2 :: " + principal.getName());
		String userID = principal.getName();
		model.addAttribute("cartProductList", service.getCartList(userID));
	}

	// 장바구니 추가 :: JSON 형식({"id":"aa","pronum":10})으로
	@PostMapping(value = "writeProcess.fr", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	@ResponseBody
	public ResponseEntity<String> writeCart(@RequestBody IdPronumVO cart) {
		log.info("writeCartController");
		
		List<ProductVO> list = service.getCartList(cart.getId());
		for(ProductVO product : list) {
			if (cart.getPronum() == product.getPronum()) {
				return new ResponseEntity<>("notAddCart", HttpStatus.OK);
			}
		}
		
		List<OrderVO> listOrder = orderService.getOrderList(cart.getId());
		for(OrderVO order : listOrder) {
			if (cart.getPronum() == order.getPronum()) {
				return new ResponseEntity<>("notAddOrder", HttpStatus.OK);
			}
		}
		
		int result = service.addCart(cart);

		if (result == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 장바구니 항목 삭제 :: JSON 형식으로
	@PostMapping(value = "deleteProcess.fr", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	@ResponseBody
	public ResponseEntity<String> deleteCart(@RequestBody IdPronumVO cart) {
		log.info("deleteCartController");
		int result = service.deleteCartProduct(cart);

		if (result == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 장바구니 항목 전체 삭제
	@DeleteMapping(value = "deleteAllProcess.fr/{id}", produces = { MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> deleteCartAll(@PathVariable("id") String id) {
		log.info("deleteCartAllController");
		int result = service.deleteCartAll(id);
		log.info(result);

		if (result > 0) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
