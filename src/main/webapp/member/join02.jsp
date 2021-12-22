<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>


<script>
	//회원정보 입력 확인
	var validateForm = function(frm) {
		if(frm.name.value==''){
            alert('이름을 입력하세요');
            frm.name.focus();
            return false;
        }
		if(frm.id.value==''){
            alert('아이디를 입력하세요');
            frm.id.focus();
            return false;
        }
		if(frm.pass.value==''){
            alert('비밀번호를 입력하세요');
            frm.pass.focus();
            return false;
        }
		if(frm.pass2.value==''){
            alert('비밀번호확인을 입력하세요');
            frm.pass2.focus();
            return false;
        }
        //비밀번호 : 입력값이 둘 다 동일한지 검증. 만약 틀리면 다시 입력요구
        if(frm.pass.value != frm.pass2.value){
            alert('입력한 패스워드가 일치하지 않습니다.');
            //frm.pass.value="";//기존에 입력된 패스워드를
            frm.pass2.value="";//지워준다.
            frm.pass2.focus();
            return false;
        }
		if(!frm.tel1.value || !frm.tel2.value || !frm.tel3.value){
            alert('전화번호를 입력하세요');
            return false;
        }
		if(!frm.mobile1.value || !frm.mobile2.value || !frm.mobile3.value){
            alert('휴대폰번호를 입력하세요');
            return false;
        }
		
		//아이디는 8~12자로 입력
        if(!(frm.id.value.length>=4 && frm.id.value.length<=12)){
            alert("아이디는 4~12자 사이만 가능합니다.");
            frm.id.value = '';//잘못된 입력값이므로 지워준다.
            frm.id.focus();//재입력해야 하므로 포커싱 한다.
            return false;//서버로 전송을 중단해야 하므로 false반환
        }
		
        /*
        아이디를 구성하는 각 문자가 소문자a~z, 대문자A~Z 숫자0~9사이가 아니라면
        잘못된 문자가 포함된 경우이므로 전송을 중단해야 한다.
	    */
	    for(var i=0 ; i<frm.id.value.length; i++){//아이디의 길이만큼 반복
	        if(!((frm.id.value[i]>='a'&& frm.id.value[i]<='z') ||
	            (frm.id.value[i]>='A'&& frm.id.value[i]<='Z') ||
	            (frm.id.value[i]>='0'&& frm.id.value[i]<='9'))){
	            alert('아이디는 영문과 숫자의 조합으로만 사용할 수 있습니다.');
	            frm.id.value='';
	            frm.id.focus();
	            return false;
	        }
    	}
		//패스워드는 4~12자로 입력
        if(!(frm.pass.value.length>=4 && frm.pass.value.length<=12)){
            alert("패스워드는 4~12자 사이만 가능합니다.");
            frm.pass.value = '';//잘못된 입력값이므로 지워준다.
            frm.pass.focus();//재입력해야 하므로 포커싱 한다.
            return false;//서버로 전송을 중단해야 하므로 false반환
        }
		
        /*
        패스워드를 구성하는 각 문자가 소문자a~z, 대문자A~Z 숫자0~9사이가 아니라면
        잘못된 문자가 포함된 경우이므로 전송을 중단해야 한다.
	    */
	    for(var i=0 ; i<frm.pass.value.length; i++){//아이디의 길이만큼 반복
	        if(!((frm.pass.value[i]>='a'&& frm.pass.value[i]<='z') ||
	            (frm.pass.value[i]>='A'&& frm.pass.value[i]<='Z') ||
	            (frm.pass.value[i]>='0'&& frm.pass.value[i]<='9'))){
	            alert('패스워드는 영문과 숫자의 조합으로만 사용할 수 있습니다.');
	            frm.pass.value='';
	            frm.pass.focus();
	            return false;
	        }
    	}
	}
	

	
	// 이메일 골라서 인풋박스에 집어넣는 작업과 직접 입력 누를때 외에는 작성 못하도록 disabled 속성 추가.
	function email_input(frm){
    var domain = last_email_check2.value;
    if(domain==''){//--선택-- 부분을 선택했을때 
        frm.email_1.value='';//모든 입력값을 지운다.
        frm.email_2.value='';
    }
    else if(domain=='직접입력'){//직접입력을 선택했을때
        frm.email_2.readOnly = false;//사용자가 입력해야 하므로 readonly속성을 해제한다.
        frm.email_2.value='';
        frm.email_2.focus();
    }
    else{//도메인을 선택했을때
        frm.email_2.value=domain;//선택한 도메인을 입력한다.
        frm.email_2.readOnly=true;//입력된 값을 수정할 수 없도록 readonly속성을 활성화한다.
    }
}
	
	//아이디 중복체크.
	function id_check_person(fn) {
		
		//아이디가 입력되지 않은 상태라면...
        if(fn.id.value==""){
            alert("아이디를 입력 후 중복확인을 눌러주세요");
            fn.id.focus();
        }
        else{
            /*
            중복확인창을 띄울 때 기존 입력된 내용을 수정할 수 없도록
            readonly속성을 추가한다.
            아이디 중복확인이 끝난 후 다시 아이디를 변경하는것을 
            막기 위해서다.
            */
            fn.id.readOnly = true;
            /*
            부모창에서 입력된 아이디를 파라미터로 팝업창으로 전달한다.
            이때 파라미터명은 id이고 전달되는 값은 입력된 아이디이다.
            */
            window.open("./id_overapping.jsp?id="+fn.id.value,
                "idover", "width=600,height=300");
        }
	}



</script>



<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    function zipFind(){
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                // 예제를 참고하여 다양한 활용법을 확인해 보세요.
                var frm = document.join;
                frm.zip1.value = data.zonecode;//12345(우편번호)
                frm.addr1.value = data.address;//"서울시 금천구 가산동"(기본주소)
                frm.addr2.focus();

            }
        }).open();
    }
    /*
    thisObj 엘리먼트에 inputLen 글자를 입력하면 nextName 엘리먼트로
    포커스를 이동시킨다.
    */
    function focusmove(thisObj, nextName, inputLen){
        //현재 입력된 글자수
        var strLen = thisObj.value.length;
        if(strLen>=inputLen){
            //alert('포커스이동');확인용
            /*
            eval()함수는 문자열로 주어진 인수를 JS코드로 해석하여 실행한다.
            document.myform = > 문서객체
            nextName => 문자열
            따라서 객체와 문자열을 바로 연결하면 에러가 발생한다.
            해결책은 객체를 문자열로 변경한 후 eval()함수를 통해 JS코드로 재변환한다.
            */
            eval('document.myform.'+nextName).focus();
        }
    }
    </script>


 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				<form  name="join" method="post" action="joinProcess.jsp"
					onsubmit="return validateForm(this);">
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="" class="join_input" /></td>     <!-- <a onclick="id_check_person(this.form);" style="cursor:hand;"><img src="../images/btn_idcheck.gif" alt="중복확인"/></a>-->
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td><input type="text" name="id"  value="" class="join_input" />&nbsp;<button type="button" name="idovr"  onclick="id_check_person(this.form);" style="cursor:hand;"><img src="../images/btn_idcheck.gif" alt="중복확인"/></button>&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" name="pass" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="pass2" value="" class="join_input" /></td>
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
 
	<input type="text" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
	<input type="text" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
	<select name="last_email_check2" onChange="email_input(this.form);" class="pass" id="last_email_check2" >
		<option selected="" value="">선택해주세요</option>
		<option value="직접입력" >직접입력</option>
		<option value="dreamwiz.com" >dreamwiz.com</option>
		<option value="empal.com" >empal.com</option>
		<option value="empas.com" >empas.com</option>
		<option value="freechal.com" >freechal.com</option>
		<option value="hanafos.com" >hanafos.com</option>
		<option value="hanmail.net" >hanmail.net</option>
		<option value="hotmail.com" >hotmail.com</option>
		<option value="intizen.com" >intizen.com</option>
		<option value="korea.com" >korea.com</option>
		<option value="kornet.net" >kornet.net</option>
		<option value="msn.co.kr" >msn.co.kr</option>
		<option value="nate.com" >nate.com</option>
		<option value="naver.com" >naver.com</option>
		<option value="netian.com" >netian.com</option>
		<option value="orgio.co.kr" >orgio.co.kr</option>
		<option value="paran.com" >paran.com</option>
		<option value="sayclub.com" >sayclub.com</option>
		<option value="yahoo.co.kr" >yahoo.co.kr</option>
		<option value="yahoo.com" >yahoo.com</option>
	</select>
	 
						<input type="checkbox" name="open_email" value="1">
						<span>이메일 수신동의</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" name="zip1" value=""  class="join_input" style="width:100px;" />
						<a href="javascript:;" title="새 창으로 열림" onclick="zipFind('zipFind', '<?=$_Common[bbs_path]?>member_zipcode_find.php', 590, 500, 0);" onkeypress="">[우편번호검색]</a>
						<br/>
						
						<input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
						
						</td>
					</tr>
				</table>
				<p style="text-align:center; margin-bottom:20px"><input type="image" name="button1" src="../images/btn01.gif" ></a>&nbsp;&nbsp;<a href="#"><img src="../images/btn02.gif" /></a></p>
				</form>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
