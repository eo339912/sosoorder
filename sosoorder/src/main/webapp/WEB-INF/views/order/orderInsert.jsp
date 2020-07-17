<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="resources/admin/scss/hw.css" rel="stylesheet" type="text/css">

<script language="javascript">
// opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("팝업API 호출 소스"도 동일하게 적용시켜야 합니다.)
//document.domain = "abc.go.kr";

function goPopup(){
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	var pop = window.open("jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	
	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, reizable=yes"); 
}


function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	
	document.form.roadAddrPart1.value = roadAddrPart1;
	document.form.addrDetail.value = addrDetail;
	document.form.zipNo.value = zipNo;
	
}

function Show() {
	if (delivery.style.display == "") {
		delivery.style.display = "none"
	} else {
		delivery.style.display = ""
	}
	}

</script>
   <!-- 컨텐츠영역 -->

   <div class="div-tt">
       <h2>주문/결제</h2>
   </div>
    
  <div class="basic">  
		<table  class="basic_tb">		
			<tr>
			     <th class="basic_tb_th_up">주문메뉴</th>
			     <th class="basic_tb_th_up">수량</th>
			     <th class="basic_tb_th_up">가격</th>
			</tr>			
			<tr>
			      <td class="basic_tb_td_up">떡볶이</td>
			      <td class="basic_tb_td_up">1개</td>
			      <td class="basic_tb_td_up">10,000</td>
			      
			</tr>			
				<tr>
					<td class="basic_tb_td_down" colspan="3">총 추문금액: "#총주문값"</td>
				</tr>						
		</table>
</div>


<!-- 배달 체크시 펼치기-->
<div class="basic">
	<h5  style="margin-bottom:20px";>배달할거에요? <input type="checkbox" onclick="Show()"> 배달 주문시, 자동 회원가입 됩니다. </h5>
</div>
<div class="basic"  id="delivery" style="display:none" >
	<h3 class="basic_h3">배달정보</h3>
<form name="form" id="form" method="post">
<div id="callBackDiv">
 <table class="basic_tb">
 <tr>
	<th class="basic_tb_th">주소
    </th>
         <td class="basic_tb_td">
             <input class="basic_input" id="zipNo"  name="zipNo"  size="6" maxlength="6" type="text" readonly="1">  <a onclick="goPopup()" class="btn_post">주소찾기</a><br>
              <input class="basic_input" id="roadAddrPart1"  name="roadAddrPart1" fw-label="주문자 주소1"  size="60" readonly="1"  type="text"> <span>기본주소</span><br>
              <input class="basic_input" id="addrDetail"  name="addrDetail"  size="60"  type="text"> <span class="txtInfo">나머지주소</span><span>(선택입력가능)</span>
         </td>
</tr>   
</form>
                
<tr >
	<th class="basic_tb_th">휴대전화 <span class=""><img src="//img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수"></span>
	</th>
    <td class="basic_tb_td">
     <select class="basic_input" fw-label="주문자 핸드폰번호" > 
		<option value="010">010</option>
		<option value="011">011</option>
		<option value="016">016</option>
		<option value="017">017</option>
		<option value="018">018</option>
		<option value="019">019</option>
	</select>-<input class="basic_input"  maxlength="4" fw-label="주문자 핸드폰번호" size="4" value="" type="text">-<input class="basic_input" maxlength="4" fw-label="주문자 핸드폰번호"  size="4" value="" type="text"></td>
 </tr>
</table>
</div>  
</div>

<!-- 할인 및 포인트 -->
<div class="basic">
	<h3 class="basic_h3">할인 및 포인트</h3>
 <table class="basic_tb">

	 <tr>
		<th class="basic_tb_th" >쿠폰할인</th>
	         <td class="basic_tb_td">
	             <div class="input_empty"><span>"$할인금액"</span></div><span>원</span><button class="btn_post">쿠폰사용</button>
	         </td>
	</tr>                         
	<tr>
		<th class="basic_tb_th">적립금 </th>
		    <td class="basic_tb_td" >
		    	<p><input class="basic_input">원<button class="btn_post">전액사용</button>
		    	(총 적립금:<strong style="color: #E91E63;">0</strong>원)</p>
		    	<ul class="ul_info">
					<li>- 적립금은 사용제한 없이 언제든 결제가 가능합니다.</li>                     
                </ul>
			</td>	    	

	</tr>
 </table>
</div>
<!-- 결제정보-->
<div class="basic">
	<h3 class="basic_h3">결제정보</h3>
	<table class="basic_tb">
		<tr>
			<th class="basic_tb_th2" >총 주문금액</th>
			<td class="basic_tb_td" ></td>
		<tr>
		<tr>
			<th class="basic_tb_th2" >쿠폰 할인금액</th>
			<td class="basic_tb_td" ></td>
		<tr>
		<tr>
			<th class="basic_tb_th2" >적립금 사용금액</th>
			<td class="basic_tb_td" ></td>
		<tr>
		<tr>
			<th class="basic_tb_th2" >총 결제금액</th>
			<td class="basic_tb_td" ></td>
		<tr>
		<tr>
			<th class="basic_tb_th2" >결제방법</th>
			<td class="basic_tb_td" >	
				<div class="type-selector-list-wrapper">
					<ul id="payTypeList" class="type-selector-list">

						<li id="rocketPayBox" class="type-selector-li">
							<input class="type-selector-radio" type="radio" name="payType" id="payType8" value="ROCKET_BANK">
							<label class="type-selector-label type-selector-label--bank" for="payType8" style="font-weight: normal;">
								<span class="type-selector-label__text">계좌이체</span>
							</label>
						</li>
							
						<li id="rocketPayCardBox" class="type-selector-li selected-pay-type">
							<input class="type-selector-radio" type="radio" name="payType" id="payType10" value="ROCKET_CARD">
							<label class="type-selector-label type-selector-label--card" for="payType10" style="font-weight: bold;">
								<span class="type-selector-label__text">신용/체크카드</span>							
							</label>
						</li>
			
						<li id="virtualAccountPayBox" class="type-selector-li">
									<input class="type-selector-radio" type="radio" name="payType" id="payType7" value="VIRTUALACCOUNT">
									<label class="type-selector-label" for="payType7" style="font-weight: normal;">
										<span class="type-selector-label__text">현금</span>
									</label>
						</li>
					</ul>
					<p class="validate-message" style="display: none;"></p>
				</div>		
			</td>
		<tr>
	</table>
</div>

<!-- 결제하기 -->
<div style="margin: 20px; text-align: center; margin-bottom: 20px;">
        위 주문 내용을 확인 하였으며, 회원 본인은 결제에 동의합니다.
    </div>
<div class="div_pay">
<button class="btn_pay"><span class="txt_payment">결제하기</span></button>
</div>


            
   
    
    