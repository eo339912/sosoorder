package com.soso.app.store.web;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.soso.app.common.FileRenamePolicy;
import com.soso.app.seat.service.SeatService;
import com.soso.app.seat.service.SeatVO;

import com.soso.app.store.service.StorePopupService;
import com.soso.app.store.service.StorePopupVO;


@Controller
public class StorePopupController {
	@Autowired
	StorePopupService storePopupService;
	
	@Autowired
	SeatService seatService;
	
	//좌석 및 팝업관리 등록폼으로 이동(해당 메뉴탭을 누르면 해당메뉴 값을 가지고 수정)
	@RequestMapping("storePopupListForm")
	public String storePopupListForm(Model model, SeatVO seatVO, HttpSession session) {
		String storeId = (String) session.getAttribute("storeId");
		seatVO.setStoreId(storeId);
		model.addAttribute("SeatList", seatService.getSeatList(seatVO));
		model.addAttribute("RestSeatList", seatService.getRestSeatList(seatVO));
		return "store/storePopupList";
	}
	
	// 좌석등록
		@RequestMapping("seatInsert")
		public String seatInsert(SeatVO seatVO, Model model, HttpSession session) {
			String storeId = (String) session.getAttribute("storeId");
			seatVO.setStoreId(storeId);
			System.out.println(seatVO);
//			if (seatVO.getSeatNum() != null && !seatVO.getSeatNum().isEmpty()) {
//				seatService.seatUpdate(seatVO);
//			} else {
				seatService.seatInsert(seatVO);
			//}
			
			return "redirect:storePopupListForm";
			
		}
		
		//좌석삭제
		@RequestMapping("seatDelete")
		public String seatDelete(SeatVO seatVO) {
			seatService.seatDelete(seatVO);
			return "redirect:storePopupListForm";
		}
		
		//좌석삭제
		@RequestMapping("seatUpdate")
		public String seatUpdate(SeatVO seatVO) {
			seatService.seatUpdate(seatVO);
			return "redirect:storePopupListForm";
		}
		
	@RequestMapping("storePopupList")
	@ResponseBody
	public List<StorePopupVO> storePopupList(Model model, StorePopupVO storePopupVO, HttpSession session) {
		String storeId = (String)session.getAttribute("storeId");
		storePopupVO.setStoreId(storeId);
		return storePopupService.storePopupList(storePopupVO);
	}
	
	@RequestMapping("storePopupInsertForm")
	public String storePopInsertForm(Model model) {
		return "store/storePopupInsert";
	}
	
	@RequestMapping("storePopupInsert")
	public String storePopInsert(Model model, HttpServletRequest request, StorePopupVO storePopupVO, HttpSession session) {
		// 업로드경로
		String path = request.getSession().getServletContext().getRealPath("resources/download");
		// 첨부파일 처리
		MultipartFile file = storePopupVO.getUploadFile();
		String filename = "";
		if (file != null && file.getSize() > 0) {
			filename = file.getOriginalFilename();
			File upFile = FileRenamePolicy.rename(new File(path, filename)); // 파일 이름이 rename되어 // 올라가도록
			filename = upFile.getName();
			try {
				file.transferTo(upFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		String storeId = (String)session.getAttribute("storeId");
		String popContents =  request.getParameter("popContents");
		popContents = popContents.replace("\r\n","<br>");
		
		storePopupVO.setStoreId(storeId);
		storePopupVO.setPopImage(filename);
		storePopupVO.setPopContents(popContents);
		
		if(storePopupVO.getPopCheck() == null || storePopupVO.getPopCheck() == "") {
			storePopupVO.setPopCheck("0");
		}
		
		if (storePopupVO.getPopNum() != null && !storePopupVO.getPopNum().isEmpty()) {
			if(storePopupVO.getPopImage() == null || storePopupVO.getPopImage() == "") {
				String updateFileName= request.getParameter("updateFile");
				storePopupVO.setPopImage(updateFileName);
				storePopupService.storePopupUpdate(storePopupVO);
			}else {
				storePopupService.storePopupUpdate(storePopupVO);
			}
		} else {
			storePopupService.storePopupInsert(storePopupVO);
		 } 
		
			return "redirect:storePopupListForm";
	}
	
	@RequestMapping("storePopupOne")
	public String storePopupOne(Model model, StorePopupVO storePopupVO) {
		model.addAttribute("popupOne", storePopupService.storePopupOne(storePopupVO));
		return "store/storePopupInsert";
	}

	
	@RequestMapping(value="/storePopupDelete/{popNum}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map storePopupDelete(@PathVariable String popNum, StorePopupVO storePopupVO) {
		storePopupService.storePopupDelete(storePopupVO);
		Map result = new HashMap<String, Object>();
		result.put("result", Boolean.TRUE);
		return result;
	}
	
	@RequestMapping("storePopup")
	public String storePopup() {
		return "empty/store/storePopup";
	}
	
	@RequestMapping(value="/storePopupListPro", method=RequestMethod.GET)
	@ResponseBody
	public List<StorePopupVO> storePopupListPro(Model model, StorePopupVO storePopupVO, HttpSession session) {
		String storeId = (String)session.getAttribute("storeInfo");
		storePopupVO.setStoreId(storeId);
		storePopupService.storePopupListPro(storePopupVO);
		return storePopupVO.getPopList();
	}


}


