<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="resources/admin/scss/addcss/hw.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

  
<script>
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
	
	document.form.roadFullAddr.value = roadFullAddr;
	document.frm_pay.addr.value = roadFullAddr;
}
function Show() {
	if (delivery.style.display == "") {
		delivery.style.display = "none"
	} else {
		delivery.style.display = ""
	}
	};
	
//결제정보처리
$(function(){	
	function printPay() {
		var totalPrice = parseInt($("#totalPrice").text());
		$("#totalPay").text(totalPrice);		
	}
	printPay();
	
  //적립금
   var totalPrice = parseInt($("#totalPrice").text());
   var totalPoint = parseInt($("#totalPoint").text());
   var pointDiscount  = parseInt($("#pointDiscount").val());
   var couponUse;
   var totalPay = parseInt($("#totalPay").text());
   var var1;
   
   // 적립금 적용
   $("#pointDiscount").keyup(function(){ 
	   $("#pointUse").text($("#pointDiscount").val());
	   $(".pointUse").val($("#pointDiscount").val());
	   finalPay(); 	      
   });
	
   //쿠폰적용
	$(".saveCoupon").on("click",function(){
		var discount = $(this).parent().prev().find("#discount").text();
		$("#couponUse").text(discount);
		$(".couponUse").val(discount);
		var serial = $(this).parent().find("#serial").val();
		$("#couponDiscount").text(serial);
		$(".serialNum").val(serial);
		finalPay();
	});
	//총결제금액계산
	function finalPay() {
	    pointDiscount = parseInt(nvl($("#pointUse").text(),0));
	    couponUse = parseInt(nvl($("#couponUse").text(),0));
	    	if(totalPrice >= couponUse+pointDiscount){
	    		 if(totalPoint >= pointDiscount){
	    			 var1 = totalPrice- pointDiscount - couponUse	
	    			 $("#totalPay").text(var1);	
	    			 $(".total").val($("#totalPay").text());
	    		 }else if(totalPoint < pointDiscount){
		            //총적립금보다 많은 금액입력시 경고말 아웃풋
		            alert("사용금액초과")
		            $("#pointUse").text("0")
		             $("#pointDiscount").val("")
		            var1 = totalPrice- couponUse	
	    			 $("#totalPay").text(var1);		  
	    		}
	    	}else if(totalPrice < couponUse+pointDiscount){
	    		alert("할인금액이 최종결제금액보다 많습니다.")
	          location.reload();
	    	}
	}
	 
}); 
  
 
 
  	// 계산 nvl 처리
	function nvl(A, B) {
		if (A == null || A == 'undefined' || A == "") {
			return B;
		} else {
			return A;
		}
	};  
/*
	
  
  /* 숫자만 입력 가능하게 */
  function onlyNumber(event){
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        return false;
}
 
function removeChar(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        event.target.value = event.target.value.replace(/[^0-9]/g, "");
}
	/* 모달 */
	jQuery.fn.center = function() {
		this.css('top', Math.max(0, (($(window).height() - $(this)
				.outerHeight()) / 2)
				+ $(window).scrollTop())
				+ 'px');
		this.css('left', Math.max(0,
				(($(window).width() - $(this).outerWidth()) / 2)
						+ $(window).scrollLeft())
				+ 'px');
		return this;
	}
	function wrapWindowByMask() {
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
		$('#mask').css({
			'width' : maskWidth,
			'height' : maskHeight
		});
		$('#mask').fadeTo(10, 0.8);
		$('.ModalPopup').show();
		$('.ModalPopup').center();
	}
	$(function() {
		$('.openMask').click(function(e) {
			e.preventDefault();
			wrapWindowByMask();
		});
	});	
</script>

<!-- 컨텐츠영역 -->
<div class="row">
   <div class="col-xl-12 div-tt">
      <h2>주문/결제 </h2>  
      <!-- 가게 계좌번호 받아오기 -->
      <c:forEach items="${admin}" var="admin">
      	<input id="account" name="account" type="hidden"  value="${admin.accountNum}"> 
      </c:forEach>
   </div>
 </div>
 
<!-- 좌석 셀렉트 박스 -->
 <div class="row">
    <div class="col-xl-4 basic">
    	<span>좌석번호
   				 <select name="selectSeat" id="selectSeat" style="width: 100px; height: 30px;">
    				<c:if test="${param.seat != 0 }">
    					<option selected>${param.seat}</option>
    				</c:if>
    				<c:if test="${param.seat == 0}">
    					<option id="empty" key="default-empty"></option> 
    				</c:if>
    				<c:forEach var="seat" items="${seat}">
    				<c:if test="${param.seat != seat.seat}">
    					<option value="${seat.seat}">${seat.seat}</option>
    				</c:if>
   					 </c:forEach>
   				 </select>
    	</span>
    </div>
 </div>
    
 <!-- 주문메뉴목록 -->
 <div class="row basic">  
		<table  class="col-xl-12 basic_tb">		
			<tr>
			     <th class="basic_tb_th_up">주문메뉴</th>
			     <th class="basic_tb_th_up">수량</th>
			     <th class="basic_tb_th_up">가격</th>
			</tr>	
		 <c:forEach items="${oderList}" var="order">		
			<tr>
			  <td class="col-xl-3 basic_tb_tdd">${order.menuName}</td>
			  <td class="col-xl-3 basic_tb_tdd"> ${order.orderCount}</td> 
			  <td class="col-xl-3 basic_tb_tdd">${order.price}</td> 			      
			</tr>
			<c:set var= "totalPrice" value="${totalPrice +order.price}"/>
		 </c:forEach>	
			<tr>
				<td class="col-xl-3 basic_tb_td_down" colspan="3">총 주문금액:<span id="totalPrice">${totalPrice}</span>원
				</td>
			</tr>		
		</table>
</div>

<!-- 배달 체크시 펼치기-->
<div class="basic">
	<h5 style="margin-bottom:20px;"><strong style="color: red;">배달할거에요?</strong>
	<input type="checkbox" onclick="Show()" class="selectdel"></h5>
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
	         <c:forEach var="list" items="${addr}">
		         <c:if test="${sessionScope.phone != null}">	         
		         	 <input readonly class="basic_input" id="roadFullAddr"  name="roadFullAddr"  size="65" type="text" value="${list.deladdr}"><a onclick="goPopup()" class="btn_post">주소찾기</a><br>
		         </c:if>
	         </c:forEach>
	         <c:if test="${sessionScope.phone == null}">	         
	         	 <input readonly class="basic_input" id="roadFullAddr"  name="roadFullAddr"  size="65" type="text" value=""><a onclick="goPopup()" class="btn_post">주소찾기</a><br>
	         </c:if>
	         </td>
</tr>                  
<tr>
	<th class="basic_tb_th">휴대전화 <span class=""><img src="//img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수"></span>
	</th>
    <td class="basic_tb_td">
		<input class="basic_input" id="cellphone" name="cellphone"  size="20"  type="text" value="${phone}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'> 
	</td>
 </tr>
</table>
</div>  
</form>
</div>

<!-- 할인 및 포인트 -->

<div class="basic" id="getdiscount"> 
<c:if test="${phone != null}">
	<h3 class="basic_h3">할인 및 포인트</h3>
 <table class="basic_tb">

	 <tr>
		<th class="basic_tb_th" >쿠폰할인</th>
	         <td class="basic_tb_td">
	             <div class="input_empty">
	             	<span id="couponDiscount" name="couponDiscount" style="color:blue"></span>
	             	</div>
	             	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#my80sizeCenterModal">쿠폰조회</button>
	         </td>
	</tr>        
	<tr>
		<th class="basic_tb_th">적립금 </th>
		    <td class="basic_tb_td" >
		    	<p><input id="pointDiscount" name="pointDiscount" class="basic_input2"  type="text" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'>		    	
		    	(총 적립금:<strong style="color: #E91E63;" id="totalPoint">${point[0].point}</strong>원)</p>
		    	<div class="l">
		    	<span id="pointContents"></span>
		    	</div>		    	
		    	<ul class="ul_info">
					<li>- 적립금은 사용제한 없이 언제든 결제가 가능합니다.</li>                     
                </ul>
			</td>	    	

	</tr>
 </table>
</c:if>
	<!-- 모달 -->
<div class="modal modal-center fade" id="my80sizeCenterModal" tabindex="-1" role="dialog" aria-labelledby="my80sizeCenterModalLabel">
  <div class="modal-dialog modal-80size modal-center" role="document">
    <div class="modal-content modal-80size" id="a">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">쿠폰함</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body" style="overflow: scroll;">

	      <c:forEach items="${coupon}" var="coupon">
	     	<table border="1" style="width:100%;">
	     	<tr>
	     		<th style="background-color: #cc87d8; width: 30%; text-align: center; font-size: 15px">
	 	    	    <p id="discount" style="color: white">${coupon.discount}</p>
					<p style="color: white">할인쿠폰</p>						     		
	     		</th>
	     		<td style="padding: 10px 10px 10px 10px;">
	     			<p style="font-size: 17px; margin: 1p; font-weight: bold; padding: 5px 0px 0px 5px;">${coupon.storeName}</p>
	     			<p style="font-size: 13px; padding: 5px;">${coupon.expEnd}까지</p>
	     			<input id="serial" name="serial" type="hidden" value="${coupon.serialNum}">
	     			<button class="saveCoupon" data-dismiss="modal">사용</button>
	     		</td>
	     	</tr>    
	     	<tr style="height: 20px;">
	     	</tr>  
	     	</table>	     		        		
      	 </c:forEach>  
      </div>
    </div>
  </div>
</div>              	  
</div>  

<!-- 결제정보-->
<div class="row basic">
	<h3 class="basic_h3">결제정보</h3>
	<table class="col-xl-12 basic_tb">
		<tr>
			<th class="col-xl-4 basic_tb_th2" >총 주문금액</th>
			<td class="col-xl-4 basic_tb_td" >${totalPrice}</td>			
		<tr>
		<tr>
			<th class="basic_tb_th2" >쿠폰 할인금액</th>
			<td class="basic_tb_td" ><span id="couponUse"></span>
			
			</td>
		<tr>
		
		<tr>
			<th class="basic_tb_th2" >적립금 사용금액</th>
			<td class="basic_tb_td" ><span id="pointUse"></span>
			<input id="pointUse" name="pointUse" type="hidden" value="${pointUse}"></td>
		<tr>
		<tr>
			<th class="basic_tb_th2" >총 결제금액</th>
			<td class="basic_tb_td" ><span id="totalPay"></span>
			<input name="totalPay" type="hidden" value="${totalPay}"></td>
		<tr>
		<tr>
			<th class="basic_tb_th2" >결제방법</th>
			<td class="basic_tb_td" >	
				<div class="type-selector-list-wrapper">
					<ul id="payTypeList" class="type-selector-list">

						<li id="" class="">
							<input class="payCheck" type="radio" name="payCheck" value="0" id="transfer" checked>
							<label >
								<span>계좌이체</span>
							</label>
						</li>
							
						<li id="" class="">
							<input class="payCheck" type="radio" name="payCheck" value="1" id="card">
							<label>
								<span>신용/체크카드</span>							
							</label>
						</li>
			
						<li id="" class="">
									<input class="payCheck" type="radio" name="payCheck" value="2" id="cash">
									<label>
										<span>현금</span>
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
<form action="payInsert?payNum=${payNum}" method="post" name="frm_pay">
<input class="couponUse" name="couponUse" type="hidden" value="">
<input class="payCheckval" name="payCheck" type="hidden" value="0">
<input class="seat" name="seat" type="hidden" value="${param.seat}">
<input class="pointUse" name="pointUse" type="hidden" value="">
<input class="total" name="totalPay" type="hidden" value="${totalPrice}">
<input class="serialNum" name="serialNum" type="hidden" value="">
<input class="addr" name="addr" type="hidden" value="">
<input class="cellphone" name="cellPhone" type="hidden" value=""> 
<div class="div_pay">
<button class="btn_pay" type="button"><span class="txt_payment">결제하기</span></button>
</div>
</form>


<script>
var IMP = window.IMP; 
IMP.init("iamport");
var totalPrice = $(".total").val();
var storeName = $("#storeName").val();
// 결제
$(function(){
	$(".btn_pay").on("click",function(){
		if( $("#transfer").is(":checked") ){
			var account = $("#account").val();
			alert("계좌번호:" + account+  "\n이체를 완료하시면 주문이 완료됩니다.")
			frm_pay.submit();
		}else if( $("#cash").is(":checked") ){
			alert("현금결제시 결제는 데스크에서 완료해주세요.")
			frm_pay.submit();
		}else if( $("#card").is(":checked") ){
			IMP.request_pay({
			    pg : 'inicis', // version 1.1.0부터 지원.
			    pay_method : 'card',
			    merchant_uid : 'merchant_' + new Date().getTime(),
			    name : 'Atistry',
			    amount : totalPrice,
			    buyer_email : 'iamport@siot.do',
			    buyer_name : '구매자이름',
			    buyer_tel : '010-1234-5678',
			    buyer_addr : '서울특별시 강남구 삼성동',
			    buyer_postcode : '123-456',
			    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
			}, function(rsp) {
			    if ( rsp.success ) {
			        var msg = '결제가 완료되었습니다.';
			        msg += '고유ID : ' + rsp.imp_uid;
			        msg += '상점 거래ID : ' + rsp.merchant_uid;
			        msg += '결제 금액 : ' + rsp.paid_amount;
			        msg += '카드 승인번호 : ' + rsp.apply_num;		        
			        frm_pay.submit();
			    } else {
			        var msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;
			    }
			    alert(msg);
			});			
		}
	});
});
/* 결제방법받기 */
$(function(){
	$(".payCheck").on("change",function(){
		$(".payCheckval").val($(this).val());
	});
});
/* 좌석값받기 */
$(function(){
	$("#selectSeat").on("change",function(){
		$(".seat").val($(this).val());
	});
});
	
/* 홀이냐 배달이냐 하나만*/	
$(function(){
		$(".selectdel").on("change",function(){
	        if($(".selectdel").is(":checked")){
	        	$('#selectSeat').val($(".empty").val());
	        	$(".seat").val($(".empty").val()); 
				$('#selectSeat').attr('disabled', 'true');
				 alert("배달 주문을 하시겠습니까?");
   				var addr = $('#roadFullAddr').val();
				$('.addr').val(addr); 			
				var cellphone = $('#cellphone').val();
				$('.cellphone').val(cellphone); 					
				 //변경된 휴대폰 번호 넘기기
				$('#cellphone').on("change",function(){
					$('.cellphone').val($(this).val());
				});
				
	        }else{
	        	$('#selectSeat').val($(".empty").val());
	        	$(".seat").val($(".empty").val());
				$('#selectSeat').removeAttr('disabled'); 
				alert("홀주문을 하시겠습니까?");
	        }
	    });
});		
		
</script>