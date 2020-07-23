package com.soso.app.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.soso.app.menu.service.MenuSearchVO;

public interface OrderService {

	//주문메뉴리스트
	public List<Map<String, Object>> getOrder(OrderCptVO orderCptVO);
	
	//by혜원, 총적립금 확인
	public List<OrderCptVO> getTotalPoint(OrderCptVO orderCptVO);	
	
	//by혜원, 쿠폰조회
	public List<OrderCptVO> findCoupon(OrderCptVO orderCptVO);

}
