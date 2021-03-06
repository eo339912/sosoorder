package com.soso.app.work.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soso.app.work.mapper.WorkMapper;
import com.soso.app.work.service.SelDateVO;
import com.soso.app.work.service.WorkService;
import com.soso.app.work.service.WorkVO;

@Service
public class WorkServiceImpl implements WorkService {

	@Autowired WorkMapper workMapper;
	
	@Override
	public List<Map> empNum(SelDateVO vo){
		return workMapper.empNum(vo);
	}

	@Override
	public void workStart(String empNum) {
		workMapper.workStart(empNum);
	}

	@Override
	public void workEnd(String empNum) {
		workMapper.workEnd(empNum);
	}

	@Override
	public List<Map<String, Object>> getWorkTimeData(String storeId) {
		return workMapper.getWorkTimeData(storeId);
	}
	@Override
	public List<Map<String, Object>> getEmpListTime(String storeId) {
		return workMapper.getEmpListTime(storeId);
	}

	
	@Override
	public List<Map> getEmpSalAjax(SelDateVO vo) {
		return workMapper.getEmpSalAjax(vo);
	}

	@Override
	public List<Map> totalSalAjax(SelDateVO vo) {
		return workMapper.totalSalAjax(vo);
	}

	@Override
	public List<Map> allEmpSal(SelDateVO vo) {
		return workMapper.allEmpSal(vo);
	}

	
	
}
