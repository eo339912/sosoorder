<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<style>
#menuName {
	width: 500px;
}

#menuPrice {
	width: 500px;
}

#uploadFile {
	width: 500px;
}

#btn {
	display: inline-block;
	list-style: none;
	text-align: right;
	height: 100px;
	vertical-align: bottom;
	margin-top: 50px;
	border-bottom: 1px solid;
}

#un {
	text-decoration: underline;
}

#gear {
	position: relative;
	left: -15px;
}
</style>
<!-- Page Heading -->
<div
	class="d-sm-flex align-items-center justify-content-between mb-4 pd15 mt30"
	style="border-bottom: 1px solid #d2d2d2">
	<h1 class="h3 mb-0 text-gray-800">점포관리 - 메뉴 등록</h1>
</div>
<form action="menuInsert" method="post" enctype="multipart/form-data"
	name="menuInsert" id="menuInsert">

	<input type="hidden" name="menuNum" value="${oneMenu.menuNum}" />
	<div class="row">
		<div class="col">
			<div class="input-group mb-3" id="menuName">
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon1">메뉴이름</span>
				</div>
				<input type="text" name="menuName" class="form-control"
					style="text-align: center;" placeholder="메뉴명을 입력바래요"
					aria-label="Username" aria-describedby="basic-addon1"
					value="${oneMenu.menuName}">
			</div>
		</div>
		<div class="col">
			<div class="input-group" style="width: 600px;">
				<div class="input-group-prepend">
					<span class="input-group-text" >메뉴 카테고리</span>
				</div>
				<select class="form-control selectmenu" name="menuCategory" id="menuCategory"
					style="text-align: center;" >
					
				</select>
			</div>
		</div>
	</div>
		<script>
		// (|)짤라주는거
		var jbString = "${storeMenu.storeMenu}";
		var jbSplit = jbString.split("|");
		for ( var i in jbSplit) {
			$(".selectmenu").append(
					"<option>" + jbSplit[i] + "</option>");
		}
		$('#menuCategory').val('${oneMenu.menuCategory}')
	</script>
	<br> <br>
	<div class="row">
		<div class="col">

			<div class="input-group-prepend">
				<span class="input-group-text">가격</span>
			</div>
			<input type="text" class="form-control" style="text-align: center;"
				placeholder="가격을 입력바래요" aria-label="Username" name="menuPrice"
				id="menuPrice" aria-describedby="basic-addon2"
				value="${oneMenu.menuPrice}">
		</div>
		<div class="col">
			<div class="input-group" style="width: 600px;">
				<div class="input-group-prepend">
					<span class="input-group-text">스토어메뉴 카테고리</span>
				</div>
				<input type="text" class="form-control" name="storeMenu"
					id="storeMenu" style="text-align: center;"
					 value="${storeMenu.storeMenu}">
				<div id="btnUpdate">Enroll</div>
			</div>
		</div>
	</div>
	<br> <br>
	<div class="row">
		<div class="col">
			<div class="input-group" id="uploadFile">
				<div class="custom-file">
					<span class="input-group-text">이미지 </span> <input type="file"
						name="uploadFile">
						<span>현재파일:
							<span>${oneMenu.menuImage}</span>
							<input type="hidden" name="updateFile" value="${oneMenu.menuImage}">
						</span>
					<!-- input-group-text <이게 회색 박스 만들어줌  -->
				</div>
			</div>
		</div>
		<div class="col">
			<div class="input-group mb-3" id="menuContents">
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon2">메뉴소개</span>
				</div>
				<textarea style="width: 600px; text-align: center;" class="DOC_TEXT"
					name="menuContents" id="menuContents" placeholder="200자 이내로 적어주세요.">${oneMenu.menuContents}</textarea>
			</div>
			<span style="color: #aaa;" id="counter">(0 / 최대 200자)</span>
		</div>
	</div>
	<script>
		//서류사항 textarea 체크
		$('.DOC_TEXT').keyup(function(e) {
			var content = $(this).val();
			$('#counter').html("(" + content.length + " / 최대 200자)"); //글자수 실시간 카운팅

			if (content.length > 200) {
				alert("최대 200자까지 입력 가능합니다.");
				$(this).val(content.substring(0, 200));
				$('#counter').html("(200 / 최대 200자)");
			}
		});
	</script>
	
	

	<br>
	<div class="row">
		<div class="col">
			<div class="input-group" id="gear">

				<span class="input-group-text">주/부 메뉴 코드</span>
				<div style="width: 100px;">
					<select class="form-control" name="menuCheck"
						id="exampleFormControlSelect1">
						<c:if test="${oneMenu.menuCheck!=1}">
							<option value="0"selected>부메뉴</option>
							<option value="1">주메뉴</option>
						</c:if>
						<c:if test="${oneMenu.menuCheck==1}">
							<option value="0">부메뉴</option>
							<option value="1" selected>주메뉴</option>
						</c:if>
					</select>
				</div>
			</div>

			<div class="col"></div>
		</div>
	</div>
	<div class="col" id="btn">
		<input type="submit" class="btn btn-primary" value="메뉴등록" /> <input
			type="button" class="btn btn-primary"
			onclick="location.href='menuDelete?menuNum=${oneMenu.menuNum}'"
			value="메뉴삭제" />

	</div>
</form>
<script>
$(function(){
	storeMenuUpdate()

function storeMenuUpdate(){
	//수정 버튼 클릭
	$('#btnUpdate').on('click',function(){
		var storeMenu = $('input:text[name="storeMenu"]').val();
		console.log(storeMenu);
		$.ajax({ 
		    url: "storeMenuUpdate",  
		    type: 'POST',  
		    //dataType: 'json', 
		    data: JSON.stringify({storeMenu: storeMenu}),
		    contentType: 'application/json',
		    success: function(data) { 
		    	location.reload();
		    }
		 });
	});//수정 버튼 클릭
}
});
</script>
<script>
	$(function(){
		
		if($(window).width() >768) { 
			$( '.navbar-nav li.li_1 a.nav-link' ).removeClass( 'collapsed' );
			$( '.navbar-nav li.li_1 a.nav-link' ).attr("aria-expanded", "true");
			$( '.navbar-nav li.li_1 #collapseTwo' ).addClass("show");
			$('.navbar-nav li.li_1 #collapseTwo .collapse-item:nth-child(3)').css("backgroundColor", "#eaecf4")
		}
		
	});
</script>