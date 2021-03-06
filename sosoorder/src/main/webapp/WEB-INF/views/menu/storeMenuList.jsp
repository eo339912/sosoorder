<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
#un {
	text-decoration: underline; # grid { display : grid;
	grid-template-columns: 150px 1fr;
}

</style>

<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.css">

<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.js"></script>

<!-- Page Heading -->
<div
	class="d-sm-flex align-items-center justify-content-between mb-4 pd15 mt30"
	style="border-bottom: 1px solid #d2d2d2">
	<h1 class="h3 mb-0 text-gray-800">점포관리 - 메뉴 관리</h1>
</div>

<!-- 메뉴 구분-->
<div class="slick_box menu_category2">
	<div class="menu_bar">
		<div><a class='MCategory all'>전체</a></div>
	</div>
	<script>
		var jbString = "${menuCategory.storeMenu}";
		var jbSplit = jbString.split("|");
		for ( var i in jbSplit) {
			$(".menu_bar").append(
					"<div><a class='MCategory m_"+ jbSplit[i] +"'>" + jbSplit[i] + "</a></div>");
		}
	</script>
	<span class="prev" id="aro_prev1"><i class="fas fa-caret-left"
		aria-hidden="true"></i> </span> <span class="next" id="aro_next1"><i
		class="fa fa-caret-right" aria-hidden="true"></i></span>
</div>

<div class="row">
	<div class="col">
		<div id="empList">
			<table id="table_id" class="display tb_style">
				<thead>
					<tr>
						<th>메뉴 카테고리</th>
						<th>메뉴 이름</th>
						<th>가격</th>
						<th>메뉴사진</th>
						<!-- <th>주/부 메뉴 코드</th> -->
						<th>메뉴 소개</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${storeMenuList}" var="menu">
						<tr class="categoryIf ${menu.menuCategory}" name="${menu.menuNum}">
							<td>${menu.menuCategory}</td>
							<td>${menu.menuName}</td>
							<td>${menu.menuPrice}원</td>
							<td><img src="resources/download/${menu.menuImage}"
								style="width: 80px;"></td>
							<%-- <td>${menu.menuCheck}</td> --%>
							<td>${menu.menuContents}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
	$(function() {
		//목록
		var otable = $('#table_id').DataTable({});
		$('#table_id tbody').on('click', 'tr', function() {
			var col1 = $(this).attr("name");
			//var data = otable.row(this).data();
			//var col1 = data[1];
			location.href = "storeMenuInsert?menuNum=" + col1
		});

	});
</script>
<br>
<br>
<br>
<div align="right">
	<input type="button" class="btn btn-danger"
		onClick="location.href='storeMenuInsert'" value="등록" />
</div>

<script>
	$('.menu_bar').slick({
		autoplay : false,
		dots : false,
		speed : 300 /* 이미지가 슬라이딩시 걸리는 시간 */,
		infinite : false,
		autoplaySpeed : 3000 /* 이미지가 다른 이미지로 넘어 갈때의 텀 */,
		prevArrow : $('#aro_prev1'),
		nextArrow : $('#aro_next1'),
		arrows : true,
		slidesToShow : 5,
		slidesToScroll : 5,
		fade : false,
		responsive: [ // 반응형 웹 구현 옵션
			{  
				breakpoint: 800, 
				settings: {
					slidesToShow:3 
				} 
			}
		]
	});
</script>
<script>
	$(function() {
		$('.MCategory').on('click', function() {
			category = $(this).html();
			if(category != '전체'){
				location.href = "storeMenuList?menuCategory=" + category;
			}else{
				location.href = "storeMenuList";
			}
		});
		
		categoryCss();
		function categoryCss(){
			if('${param.menuCategory}' == ''){
				$('.all').addClass('active');	
			}
			$('.m_${param.menuCategory}').addClass('active');
		}
		
	})
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