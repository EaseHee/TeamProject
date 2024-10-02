<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int numPerPage = 5; 	//한 페이지 당 보여질 글의 개수
	
	int totalRecord = 0; 	//총 글의 개수
	int totalPage = 0; 		//총 페이지 수
	int nowPage = 0; 		//현재 페이지
	int beginPerPage = 0; 	//페이지별 시작번호
	totalRecord = list1.size();
	totalPage = (totalRecord + numPerPage - 1) / numPerPage;
	if(request.getParameter("nowPage") != null ){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
		if(nowPage == -1){
			if(totalPage > 0){
				nowPage = totalPage - 1;
			}
			else nowPage = 0;
		}
		if(nowPage == totalPage){
			nowPage = 0;
		}											
	}		
	beginPerPage = nowPage*numPerPage;
%>