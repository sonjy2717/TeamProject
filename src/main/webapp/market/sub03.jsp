<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<!-- 블루클리닝 견적 의뢰 -->


<head>
<!-- 부트스트랩3 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<!-- 폼 내용 검증 -->
<script type="text/javascript">
function validateForm(form) {
	if (form.name.value == "") {
		alert("이름을 입력하세요.");
		form.name.focus();
		return false;
	}
	if (form.address1.value == "") {
		alert("주소를 입력하세요.");
		form.postBtn.focus();
		return false;
	}
	if (form.address3.value == "") {
		alert("상세주소를 입력하세요.");
		form.address3.focus();
		return false;
	}
	if (isNaN(form.address1.value)) {
		alert("우편번호를 확인해주세요.");
		form.postBtn.focus();
		return false;
	}
	if (form.phone_num1.value == "") {
		alert("연락처를 입력하세요.");
		form.phone_num1.focus();
		return false;
	}
	if (form.phone_num2.value == "") {
		alert("연락처를 입력하세요.");
		form.phone_num2.focus();
		return false;
	}
	if (form.phone_num3.value == "") {
		alert("연락처를 입력하세요.");
		form.phone_num3.focus();
		return false;
	}
	if (form.email1.value == "") {
		alert("이메일을 입력하세요.");
		form.email1.focus();
		return false;
	}
	if (form.email2.value == "") {
		alert("이메일을 입력하세요.");
		form.email2.focus();
		return false;
	}
	if (form.bc_type.value == "") {
		alert("청소종류를 입력하세요.");
		form.bc_type.focus();
		return false;
	}
	if (form.bc_space.value == "") {
		alert("분양평수/등기평수를 입력하세요.");
		form.bc_space.focus();
		return false;
	}
	if (isNaN(form.bc_space.value)) {
		alert("분양평수/등기평수를 숫자만 입력하세요.");
		form.bc_space.focus();
		return false;
	}
	if (form.bc_date.value == "") {
		alert("청소 희망날짜를 선택하세요.");
		form.bc_date.focus();
		return false;
	}
}
</script>
<!-- 체험 희망날짜 datepicker적용 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script>
$( function() {
  $( "#datepicker" ).datepicker();
  $( "#datepicker" ).datepicker("option", "dateFormat", "yy-mm-dd");
} );
</script>
</head>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/market/sub03_title.gif" alt="블루크리닝 견적 의뢰" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;블루크리닝 견적 의뢰<p>
				</div>
				<form name="bcFrm" method="post" action="BCProcess.jsp"
					onsubmit="return validateForm(this);">
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;">
					<colgroup>
						<col width="25%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>고객명/회사명</th>
							<td style="text-align:left;"><input type="text" name="name"  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th rowspan="3">주소</th>
							<td style="text-align:left;"><input type="text" name="address1"  value="" class="join_input" id="sample6_postcode" style="width:70px;" />
							<button type="button" name="postBtn" class="btn btn-danger btn-xs" onclick="sample6_execDaumPostcode()">주소찾기</button>
							</td>
						</tr>
						<tr>
							<td style="text-align:left;"><input type="text" name="address2"  value="" class="join_input" id="sample6_address" style="width:250px;" readonly />
							<input type="text" id="sample6_extraAddress" style="width: 250px;" readonly>
							</td>
						</tr>
						<tr>
							<td style="text-align:left;"><input type="text" name="address3"  value="" class="join_input" id="sample6_detailAddress" style="width: 250px;" />
							</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td style="text-align:left;">
								<input type="text" name="phone_num1"  value="" class="join_input" style="width:50px;" /> - 
								<input type="text" name="phone_num2"  value="" class="join_input" style="width:50px;" /> - 
								<input type="text" name="phone_num3"  value="" class="join_input" style="width:50px;" />
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td style="text-align:left;">
								<input type="text" name="email1"  value="" class="join_input" style="width:100px;" /> @
								<input type="text" name="email2"  value="" class="join_input" style="width:100px;" />
							</td>
						</tr>
						<tr>
							<th>청소의뢰내역</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td>청소종류</td>
										<td style="border-right:0px;"><input type="text" name="bc_type"  value="" class="join_input" /></td>
									</tr>
									<tr>
										<td style="border-bottom:0px;">분양평수/등기평수</td>
										<td style="border:0px;"><input type="text" name="bc_space" value="" class="join_input" style="width: 50px; text-align: right;" placeholder="0" /> 평</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>청소 희망날짜</th>
							<td style="text-align:left;"><input type="text" name="bc_date"  value="" class="join_input" id="datepicker" /></td>
						</tr>
						<tr>
							<th>접수종류 구분</th>
							<td style="text-align:left;"><input type="radio" name="regi_type"  value="예약신청" checked /> 예약신청
							&nbsp;&nbsp;&nbsp;<input type="radio" name="regi_type"  value="견적문의" /> 견적문의</td>
						</tr>
						<tr>
							<th>기타특이사항</th>
							<td style="text-align:left;"><input type="text" name="note"  value="" class="join_input" style="width:400px;" placeholder="없음" /></td>
						</tr>
					</tbody>
				</table>
				<p style="text-align:center; margin-bottom:40px"><input type="image" src="../images/btn01.gif" />&nbsp;&nbsp;<a href="../main/main.jsp"><img src="../images/btn02.gif" /></a></p>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
