package utils;

public class BoardPage {
	
	public static String pagingStr(int totalCount, int pageSize, int blockPage,
			int pageNum, String reqUrl, String field, String word) {
		
		String pagingStr="";
		
		//전체 페이지 수 계산
		int totalPages = (int)(Math.ceil((double)totalCount/pageSize));
		
		//페이지 블럭의 첫번째 수를 계산
		int pageTemp = (((pageNum-1)/blockPage)* blockPage)+1;
		
		//검색필드와 검색어 모두 존재하는 경우
		if(field !=null & word!=null) {
			if(pageTemp !=1) {
				pagingStr += "<a class='page-link' href='"+reqUrl+"?searchField="+field+"&searchWord="+word
						+ "&pageNum=1'><i class='bi bi-skip-backward-fill'></i></a>";
				pagingStr+="<a class='page-link' href='"+reqUrl+"?searchField="+field+"&searchWord="+word+"&pageNum="+(pageTemp-1)
						+"'><i class='bi bi-skip-start-fill'></i></a>";
				
			}
			
			//각 페이지로 바로가기 링크(blcokPage) 수 만큼 출력됨
					int blockCount = 1;
					while(blockCount <= blockPage  && pageTemp <= totalPages) {
						if(pageTemp == pageNum) {
							//현재 페이지는 링크 안걸음
							pagingStr+="<li class='page-item active'><a class='page-link' href='"+reqUrl+"?searchField="+field+"&searchWord="+word+
									"&pageNum="+pageTemp
									+"'>"+pageTemp+"</a></li>";
						}else {
							pagingStr+="<li class='page-item'><a class='page-link' href='"+reqUrl+"?searchField="+field+"&searchWord="+word+
									"&pageNum="+pageTemp
									+"'>"+pageTemp+"</a></li>";
						}
						pageTemp++;
						blockCount++;
					}
					
					
					
					//다음블럭으로 바로가기 링크
					if(pageTemp<=totalPages) {
						pagingStr += "<a class='page-link' href='"+ reqUrl +"?searchField="+field+"&searchWord="+word
								+"&pageNum="+pageTemp
								+"'><i class='bi bi-skip-end-fill'></i></a>";
						pagingStr+="<a class='page-link' href='"+reqUrl +"?searchField="+field+"&searchWord="+word
								+"&pageNum="+ totalPages
								+"'><i class='bi bi-skip-forward-fill'></i></a>";
					}
			
			return pagingStr;
		}
		else{
			//검색이 활성화되지 않는 경우
			if(pageTemp !=1) {
				pagingStr += "<a class='page-link' href='"+reqUrl+"?pageNumum=1'><i class='bi bi-skip-backward-fill'></i></a>";
				pagingStr+="<a class='page-link' href='"+reqUrl+"?pageNum="+(pageTemp-1)
						+"'><i class='bi bi-skip-start-fill'></i></a>";
				
			}
			//각 페이지로 바로가기 링크(blcokPage) 수 만큼 출력됨
			int blockCount = 1;
			while(blockCount <= blockPage  && pageTemp <= totalPages) {
				if(pageTemp == pageNum) {
					//현재 페이지는 링크 안걸음
					pagingStr+="<li class='page-item active'><a class='page-link' href='"+reqUrl+"?pageNum="+pageTemp
							+"'>"+pageTemp+"</a></li>";
				}else {
					pagingStr+="<li class='page-item'><a class='page-link' href='"+reqUrl+"?pageNum="+pageTemp
							+"'>"+pageTemp+"</a></li>";
				}
				pageTemp++;
				blockCount++;
			}
			
			
			
			//다음블럭으로 바로가기 링크
			if(pageTemp<=totalPages) {
				pagingStr += "<a class='page-link' href='"+ reqUrl +"?pageNum="+pageTemp
						+"'><i class='bi bi-skip-end-fill'></i></a>";
				pagingStr+="<a class='page-link' href='"+reqUrl +"?pageNum="+ totalPages
						+"'><i class='bi bi-skip-forward-fill'></i></a>";
			}
			
			return pagingStr;
			
		}
	}
	
	public static String pagingStr(int totalCount, int pageSize, int blockPage,
			int pageNum, String reqUrl) {
		
		String pagingStr = "";
		
		//전체 페이지 수 계산
		int totalPages = (int)(Math.ceil(((double) totalCount / pageSize)));
		
		//페이지 블럭의 첫 번째 수를 계산
		int pageTemp = (((pageNum - 1) / blockPage) * blockPage) + 1;
		
		//이전 블럭으로 바로가기 링크(첫 번째 블럭에서는 숨김처리)
		if (pageTemp != 1) {
			pagingStr += "<a href='" + reqUrl + "?pageNum=1'>[첫 페이지]</a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a href='" + reqUrl + "?pageNum=" + (pageTemp - 1)
					+ "'>[이전 블록]</a>";
		}
		
		//각 페이지로 바로가기 링크(blockPage 수 만큼 출력됨)
		int blockCount = 1;
		while (blockCount <= blockPage && pageTemp <= totalPages) {
			if (pageTemp == pageNum) {
				//현재 페이지는 링크를 걸지 않음
				pagingStr += "&nbsp;" + pageTemp + "&nbsp;";
			}
			else {
				pagingStr += "&nbsp;<a href='" + reqUrl + "?pageNum=" + pageTemp
						+ "'>" + pageTemp + "</a>&nbsp;";
			}
			pageTemp++;
			blockCount++;
		}
		
		//다음 블럭으로 바로가기 링크
		if (pageTemp <= totalPages) {
			pagingStr += "<a href='" + reqUrl + "?pageNum=" + pageTemp
					+ "'>[다음 블록]</a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a href='" + reqUrl + "?pageNum=" + totalPages
					+ "'>[마지막 페이지]</a>";
		}
		
		return pagingStr;
	}
}
