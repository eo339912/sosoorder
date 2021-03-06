package com.soso.app.seat.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soso.app.seat.mapper.SeatMapper;
import com.soso.app.seat.service.SeatService;
import com.soso.app.seat.service.SeatVO;

@Service
public class SeatServiceImpl implements SeatService{
	
	@Autowired SeatMapper seatMapper;

	@Override
	public String getSeat(SeatVO seatVO) {
		// TODO Auto-generated method stub
		return seatMapper.getSeat(seatVO);
	}

	@Override
	public List<SeatVO> getSeatList(SeatVO seatVO) {
		
		return seatMapper.getSeatList(seatVO);
	}

	@Override
	public void seatInsert(SeatVO seatVO) {
		// TODO Auto-generated method stub
		seatMapper.seatInsert(seatVO);
		
	}

	@Override
	public void seatUpdate(SeatVO seatVO) {
		// TODO Auto-generated method stub
		seatMapper.seatUpdate(seatVO);
	}

	@Override
	public void seatDelete(SeatVO seatVO) {
		// TODO Auto-generated method stub
		seatMapper.seatDelete(seatVO);
	}
	public List<SeatVO> getRestSeatList(SeatVO seatVO){
		return seatMapper.getSeatList(seatVO);
	}

}
