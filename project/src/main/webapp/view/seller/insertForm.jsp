<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/common/sessionChk.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매처 등록</title>

<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<link href="/project/css/common/outline.css" rel="stylesheet" type="text/css">
<link href="/project/css/seller/insertForm.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	window.history.forward();
	
	window.onload = function() {
		var label = document.getElementsByClassName('label');
		label[1].setAttribute('style', 'background: #186343');
		
		frm.seller_reg_num.onchange = function() {
			var msg = document.getElementsByClassName('msg')[0];
			
			var xhr = new XMLHttpRequest();
			xhr.open('POST', '/project/seller/regNumCheck.do');
			xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
			xhr.send('seller_reg_num=' + frm.seller_reg_num.value); 
			
			xhr.onreadystatechange = function() {
				if (xhr.readyState === XMLHttpRequest.DONE && xhr.status == 200) {
					var result = xhr.responseText;
					if (result == 1) {			//해당 사업자등록번호 db에 없음, 등록가능
						msg.innerHTML = '등록되지 않은 업체입니다.';
						msg.style.color = 'blue';
					} else if (result == 0) {
						msg.innerHTML = '이미 등록된 업체입니다.';
						msg.style.color = 'red';					
					}
				}
			};
		};
		
		frm.onsubmit = function() {
			var msg = document.getElementsByClassName('msg')[0];
			if (msg.innerHTML == '이미 등록된 업체입니다.') {
				alert('업체 등록 여부를 확인해주세요.');
				frm.customer_reg_num.focus();
				return false
			}
		}
	}
</script>
</head>
<body>
	<div id="header">
		<jsp:include page="/common/header.jsp" />
	</div>
	<div id="body_container">
		<div class="side_bar">
			<div>구 매</div>
			<div class="label">구매처 목록</div>
			<div class="label">구매처 등록</div>
			<div class="label">상품 목록</div>
			<div class="label">상품 등록</div>			
			<div class="label">구매 내역</div>
			<div class="label">구매 등록</div>
		</div>
		<div class="body">
			<div class="toolbar">
				<div class="tool">구매</div>
				<div class="tool">판매</div>
				<div class="tool">재고</div>
				<div class="tool">회계</div>
				<div class="tool">인사</div>
				<div></div>
			</div>
			<div class="content">
				<div class="content_head">
					<div class="label_name">구매처 등록</div>
				</div>
				<div class="content_body">
					<form action="/project/seller/insert.do" method="post" name="frm" >
					<table>
						<tr>
							<th>업체번호</th>
							<td>${seller_no}<input type="hidden" name="seller_no" required="required" value="${seller_no}" /></td>
						</tr>
						<tr>
							<th>업체명</th>
							<td><input type="text" name="seller_name" required="required" placeholder="업체명" /></td>
						</tr>
						<tr>
							<th>사업자 번호</th>
							<td>
								<input type="text" name="seller_reg_num" required="required" placeholder="사업자 번호" />
								<div class="msg"></div>
							</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="tel" name="seller_tel" required="required" placeholder="전화번호" /></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="email" name="seller_email" required="required" placeholder="이메일" /></td>
						</tr>
						<tr class="addrRow">
							<th>주소</th>
							<td>
								<div>
									<input type="text" name="seller_addr_no" id="postcode" required="required" placeholder="우편번호" />
									<input type="button" value="우편번호 입력" onclick="DaumPostcode()">
								</div>
								<div><input type="text" name="seller_addr" id="address" required="required" placeholder="주소"/></div>
								<div><input type="text" name="seller_addr_detail" id="detailAddress" required="required" placeholder="상세주소"/></div>
							</td>
						</tr>
						<tr>
							<th>담당자</th>
							<td>
								${sessionScope.Hr.emp_no} / ${sessionScope.Hr.dept_name}팀 ${sessionScope.Hr.emp_name}
								<input type="hidden" name="emp_no" required="required" value="${sessionScope.Hr.emp_no}" /> 
							</td>
						</tr>
						<tr class="last">
							<th>참고사항</th>
							<td>
								<textarea name="seller_memo" rows="2" cols="40"></textarea>
							</td>
						</tr>
						<tr>
							<td>
								<input type="submit" value="등록">
							</td>
						</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/project/script/header.js"></script>
	<script type="text/javascript" src="/project/script/label.js"></script>
	<script type="text/javascript" src="/project/script/toolbar.js"></script>
	<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="/project/script/postAddress.js"></script>
</body>
</html>