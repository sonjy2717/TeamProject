<%@page import="model1.board.BoardDTO"%>
<%@page import="utils.MyCalendar"%> 
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model1.board.BoardDAO"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- 버튼관련 css임. 그런데 얘를 넣으면 월 넘기는 이전 창이 사라짐. -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">  -->

<style>
	#calendar{
		border: 1px solid gray;
		border-collapse: collapse;
	}
	#calendar th{
		border: 1px solid gray;
		width: 95px;
	} 
	#calendar td{
		width: 80px;
		height: 100px;
		border: 1px solid gray;
		text-align: left;
		vertical-align: top;
		position: relative;
	}
	th.sun{ text-align: center; font-size: 10pt; color: red; font-family: D2coding; vertical-align: top;}
	th.sat{ text-align: center; font-size: 10pt; color: blue; font-family: D2coding; vertical-align: top;}
	th.etc{ text-align: center; font-size: 10pt; color: black; font-family: D2coding; vertical-align: top;}
	
	
	td.sun{ text-align: left; font-size: 15pt; color: red; font-family: D2coding; vertical-align: top;}
	td.sat{ text-align: left; font-size: 15pt; color: blue; font-family: D2coding; vertical-align: top;}
	td.etc{ text-align: left; font-size: 15pt; color: black; font-family: D2coding; vertical-align: top;}
	
	td.redbefore{ text-align: left; font-size: 12pt; color: red; font-family: D2coding; vertical-align: top;}
	td.before{ text-align: left; font-size: 12pt; color: gray; font-family: D2coding; vertical-align: top;}
	
</style>
<body>
<%
String tname = "일정";
BoardDTO dto2 = new BoardDTO();
BoardDAO dao = new BoardDAO(application);
String idx = request.getParameter("idx");
dto2.setTname(tname);
// 컴퓨터 시스템의 년, 월 받아오기
	Date date = new Date();
	int year = date.getYear() +1900;
	int month = date.getMonth() +1;

	//	오류사항 걸러주기	
	try{
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		
		if(month>=13){
			year++;
			month =1;
		}else if(month <=0){
			year--;
			month =12;
		}
	}catch(Exception e){
		
	}
	
	/* //달력의 일정을 표현
	BoardDAO dao = new BoardDAO();
	
	//yyyymm
	String yyyymm = year+ BoardDAO.isTwo(String.valueOf(month));
	
	//게시글 가져옴
	Map<String,String> map = new HashMap<String, String>();
	map.put("id", "k001");
	map.put("yyyymm", yyyymm);
	
	List<calDto> clist = dao.getCalViewList(map);
	 */
	
	
	
%>  
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub02_title.gif" alt="프로그램일정" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정<p>
				</div>
			</div>
			
        
          
<table id="calendar">

 	<a href="./sub02.jsp?year=<%=year-1 %>&month=<%=month%>"><img src='../images/cal_a01.gif' ></a>
   	<a href="./sub02.jsp?year=<%=year %>&month=<%=month-1%>"><img src='../images/cal_a01.gif' ></a>
   		<sapn class="y"><%=year%></sapn>년
   		<span class="m"><%=month%></span>월
   	<a href="./sub02.jsp?year=<%=year %>&month=<%=month+1%>"><img src='../images/cal_a02.gif' ></a>
   	<a href="./sub02.jsp?year=<%=year+1 %>&month=<%=month%>"><img src='../images/cal_a02.gif' ></a>
	<br /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<!--<button type="button" onclick="location.href='sub02_write.jsp';">글쓰기</button>  -->
       
       <th class ='sun'>일</th>
       <th class ='etc'>월</td>
       <th class ='etc'>화</td>
       <th class ='etc'>수</td>
       <th class ='etc'>목</td>
       <th class ='etc'>금</td>
       <th class ='sat'>토</td>
    </tr>
       <%

		int first = MyCalendar.weekDay(year, month, 1);
	

		int start = 0 ;
		start = month ==1? MyCalendar.lastDay(year-1, 12)- first : MyCalendar.lastDay(year, month-1)- first;


		for(int i= 1; i<= first; i++){
			if(i==1){
				out.println("<td class = 'redbefore'>"+(month ==1? 12 : month-1)+"/"+ ++start +"</td>");
			}else{
				out.println("<td class = 'before'>"+(month ==1? 12 : month-1)+"/"+ ++start +"</td>");
			}
		}
		

		Map<String, BoardDTO> printTitle = dao.printCalTitle("일정");
		String printCal = ""; 
		 for (String key : printTitle.keySet()){
		        System.out.println("Key:"+key+", Value:"+ printTitle.get(key).getTitle());
		  }
		
		// System.out.println(printTitle.get("2021-12-11").getTitle());
		// System.out.println(printTitle.get("2021-12-11").getCalDate());
		// System.out.println(printTitle.get("2021-12-18").getCalDate());
		//out.println(MyCalendar.lastDay(2021, 11));
		//out.println(MyCalendar.weekDay(2021, 12, 25));
		/*
		printCal = Integer.toString(year)+"-"+ Integer.toString(month) +"-" ; 
					printCal += Integer.toString(i); 
		*/
		System.out.println("8월 일정 확인: "+printTitle.get("2021-08-28").getTitle());
		for(int i = 1; i <= MyCalendar.lastDay(year, month); i++){
			String exp="";
			switch(MyCalendar.weekDay(year, month, i)){
				case 0 :
					printCal = Integer.toString(year)+"-";
					if(month<10){
					printCal +="0"+ Integer.toString(month) +"-" ; 
					}else{
					printCal += Integer.toString(month) +"-" ; 
					}
					if(i<10){
						printCal +="0" + Integer.toString(i);
					}
					else{
					printCal += Integer.toString(i);
					}
					System.out.println("printCal 확인1: "+printCal);
	
					if(printTitle.get(printCal) != null){
						exp+= "<td class ='etc'><span style='color:red'>" +i +"</span><br/><a href=sub01_view.jsp?idx="+printTitle.get(printCal).getIdx()+"&tname="+tname+">";
						exp+= printTitle.get(printCal).getTitle();
						exp+="</a></td>";
					}
					else{
						exp+= "<td class ='etc'><span style='color:red'>" +i +"</span><br/></td>";
					}
					out.println(exp);
					break;
				case 6 :
					printCal = Integer.toString(year)+"-";
					if(month<10){
						printCal +="0"+ Integer.toString(month) +"-" ; 
					}else{
						printCal += Integer.toString(month) +"-" ; 
					}
					if(i<10){
						printCal +="0" + Integer.toString(i);
					}
					else{
						printCal += Integer.toString(i);
					}
					System.out.println("printCal 확인2: "+printCal);
					if(printTitle.get(printCal) != null){
						exp+= "<td class ='etc'><span style='color:blue'>" +i +"</span><br/><a href=sub01_view.jsp?idx="+printTitle.get(printCal).getIdx()+"&tname="+tname+">";
						exp+= printTitle.get(printCal).getTitle();
						exp+="</a></td>";
					}
					else{
						exp+= "<td class ='etc'><span style='color:blue'>" +i +"</span><br/></td>";
					}
					out.println(exp);
					break;
				default :
					printCal = Integer.toString(year)+"-";
					if(month<10){
						printCal +="0"+ Integer.toString(month) +"-" ; 
					}else{
						printCal += Integer.toString(month) +"-" ; 
					}
					if(i<10){
						printCal +="0" + Integer.toString(i);
					}
					else{
						printCal += Integer.toString(i);
					}
					System.out.println("printCal 확인3: "+printCal);
					if(printTitle.get(printCal) != null){
						exp+= "<td class ='etc'>" +i +"<br/><a href=sub01_view.jsp?idx="+printTitle.get(printCal).getIdx()+"&tname="+tname+">";
						exp+= printTitle.get(printCal).getTitle();
						exp+="</a></td>";
					}
					else{
						exp+= "<td class ='etc'>" +i +"<br/></td>";
					}
					out.println(exp);
					break;
			}
			

			if(MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)){
				out.println("</tr><tr>");			
			}
		}
		if(MyCalendar.weekDay(year, month, MyCalendar.lastDay(year, month)) !=6){
			for(int i = MyCalendar.weekDay(year, month, MyCalendar.lastDay(year, month))+1; i < 7; i++){
				out.println("<td></td>");	
			}
		}
	%>
  </table>
 
  <!-- 버튼 -->
  <div class="row mb-3" style="padding-right:50px;">
	<div class="col d-flex justify-content-end">
	<!-- 각종 버튼 부분 -->
	<!-- <button type="reset" class="btn">Reset</button> -->
	 <!-- <button type="button" onclick="location.href='sub02_write.jsp';">글쓰기</button> -->
	 <%
            if(session.getAttribute("user_id") != null
            && session.getAttribute("user_id").toString().equals("admin")){
            %> 
	<button type="button" class="btn btn-info"  onclick="location.href='sub02_write.jsp';" style="margin:10px">글쓰기</button>
	<%
        }
	%>
	<!-- css넣으면 위에 월 버튼이 사라짐 -->
	</div>
</div>
  
  
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
