<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my" %>
<%@ page import="com.cbox.common.Paging" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserReservList.jsp</title>
<style>
th, td {
	text-align: center !important;
	vertical-align: middle !important;
}

.table>thead {
	background-color: #EDEBE1;
}

.table>thead>tr>td {
	text-align: center;
	font-color: #666666;
	font-size: large;
	font-weight: bold;
	border-bottom: 1px solid #ddd;
}

.table>tbody>tr>td {
	border-bottom: 1px solid #ddd;
	font-family: monospace;
	text-align: center;
}

.table>tbody>tr>#td1 {
	text-align: left;
}

.table>tbody>tr>td>a:hover {
	text-decoration: underline;
}
#selBtn {
	background-color: #689E8E;
	padding: 5px;
	border-radius: 5px;
	color: white;
}
#revBtn {
	background-color: #D85E48;
	padding: 5px;
	border-radius: 5px;
	color: white;
}
.tit-evt {
	position: relative;
}

.tit-heading-wrap {
	position: relative;
	height: 51px;
	margin-top: 30px;
	border-bottom: 3px solid #241d1e;
	float: left;
	width: 80%;
	top:30px;
	margin:auto;
	padding-left: 20px;
	margin-bottom: 10px;
}
}

.tb-style {
	width: 1000;
	border-style: solid;
	border-color: black;
}

.dvtable-style {
	width: 700;
	border: 3;
	bordercolor: lightgray;
	align: center;
}
#menubar {
	float: left;
	width: 20% !important;
	position:relative;
	top:120px;
	list-style-type: none;
	margin: 0;
	padding: 0;
}

#menubar li a {
  display:block;
  color: #000;
  padding: 16px 16px;
  text-decoration: none;
  border-bottom: 1px solid;
}

#menubar li a.active {
  background-color: red;
  color: white;
  font-weight: bold;
}

#menubar li a:hover:not(.active) {
  background-color: #555;
  color: white;
}
#ReservList {
	float: left;
	width: 80%;
	position:relative;
	top:30px;
	margin:auto;
	padding-left: 20px;
	margin-bottom: 10px;
}
input[type='text'] {
    height: calc(1.5em + .75rem + 2px) !important;
    width: 100% !important;
}
</style>
<script type="text/javascript">
$(function() {
	$('tbody').on('click','#selBtn',function() {
		var tcNum = $(this).closest('tr').find("td").eq(0).text();
		location.href ='UserReservInfo.do?tc_no='+tcNum;
	});
	
	$('tbody').on('click','#revBtn',function() {
		var mvTitle = $(this).closest('tr').find("td").eq(1).text();
		var mvNum =  $(this).closest('tr').find("input").val();
		$("#revTitle").val(mvTitle);
		$("#mvNum").val(mvNum);
	});
});
function revFormCheck() {
	var revfrm = document.revfrm;
	if(revfrm.revCont.value == "") {
		alert ("내용 입력하세요");
		revfrm.revCont.focus();
		return false;
	}
	if(isNaN(revfrm.revRank.value)) {
		alert ("평점은 숫자만 입력가능합니다");
		revfrm.revRank.focus();
		return false;
	}
	if(revfrm.revRank.value == "") {
		alert ("평점을 입력하세요");
		revfrm.revRank.focus();
		return false;
	} else if(revfrm.revRank.value < 1 || revfrm.revRank.value > 5) {
		alert ("1과 5사이의 숫자를 입력하세요");
		revfrm.revRank.focus();
		return false;
	}
	return true;
}
</script>
</head>
<body>
<div id="menubar">
<ul>
  <li><a class="active">MY PAGE</a></li>
  <li><a href="${pageContext.request.contextPath}/memberInfo.do">회원정보</a></li>
  <li><a href="${pageContext.request.contextPath}/UserReservList.do">예매정보</a></li>
  <li><a href="${pageContext.request.contextPath}/couponForm.do">쿠폰</a></li>
  <li><a href="${pageContext.request.contextPath}/QnAListForm.do">Q&A</a></li>
</ul>
</div>
	<div class="tit-heading-wrap tit-evt">
		<h3>${mbr_id}의 예매 내역</h3>
	</div>
	<div id="ReservList" align="center">
		<table border="1" class="table table-hover"
			style="margin-bottom: 20px;">
			<thead>
				<tr>
					<th>예매번호</th>
					<th>영화이름</th>
					<th>상영일</th>
					<th>상영시작시간</th>
					<th>좌석번호</th>
					<th>상영관명</th>
					<th>상세보기</th>
					<th>리뷰작성</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="uReList" items="${ userReservList }">
				<tr>
					<td>${ uReList.tc_num }</td>
					<td>${ uReList.mv_title }</td>
					<input type="hidden" value="${ uReList.mv_num }">
					<td>${ uReList.tt_scr_date }</td>
					<td>${ uReList.tt_start }</td>
					<td>${ uReList.tc_st_num }</td>
					<td>${ uReList.th_name }</td>
					<td>
						<button id="selBtn">조회</button>
					</td>
					<td>
						<button id="revBtn" data-toggle="modal" data-target="#revPop">작성</button>
					</td>
				</tr>			
			</c:forEach>
			</tbody>
		</table>
	<my:paging paging="${paging}" jsfunc="goPage" ></my:paging>
</div>
	<script type="text/javascript">
		function goPage(p) {
			location.href="UserReservList.do?p=" + p;
			// searchForm.p.value = p;
			// searchForm.submit();
		}
	</script>
<!-- 팝업창 -->
	<div class="modal" id="revPop">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h1 class="modal-title">리뷰 작성</h1>
					<button type="button" class="close" data-dismiss="modal">×</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body" align="center">
					<form id="revfrm" name="revfrm" action="reviewInsert.do" method="post" onsubmit="return revFormCheck()">
						<table class="table">
						<tr style="line-height: 32px;">
								<td class="txt">제목</td>
								<td><input type="text" class="form-control" id="revTitle" name="revTitle" readonly>
									<input type="hidden" id="mvNum" name="mvNum">
								</td>
							</tr>
							<tr>
								<td class="txt">내용</td>
								<td><input type="text" class="form-control" id="revCont" name="revCont" placeholder="내용을 작성하세요"></td>
							</tr>
							<tr>
								<td class="txt">평점</td>
								<td><input type="text" class="form-control" id="revRank" name="revRank" placeholder="숫자"><input type="hidden" name="hdnNo" value="${mbr_no}"></td>
							</tr>
						</table>
						<div style="text-align: center; margin: 10px;">
							<button type="submit" name="fid" id="fid" class="btn btn-danger" >작성</button>
							<button type="button" class="btn btn-dark" data-dismiss="modal" style="margin-left: 10px;">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>