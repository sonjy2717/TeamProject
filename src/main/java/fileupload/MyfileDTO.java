package fileupload;

public class MyfileDTO {
   
    private String idx; 	//일련번호
    private String id;   	//작성자
    private String title;  	//제목
 // private String cate;    //카테고리 (필요없음)
    private String ofile;  	//original file name - 원본파일명
    private String sfile;  	//saved file name - 서버에 저장된 파일명
    private String postdate;//작성일

    //생성자 필요없음
    
    //getter / setter 메서드 추가
    public String getIdx() { 
        return idx;
    }
	public void setIdx(String idx) { 
        this.idx = idx;
    }
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getOfile() {
        return ofile;
    }
    public void setOfile(String ofile) {
        this.ofile = ofile;
    }
    public String getSfile() {
        return sfile;
    }
    public void setSfile(String sfile) {
        this.sfile = sfile;
    }
    public String getPostdate() {
        return postdate;
    }
    public void setPostdate(String postdate) {
        this.postdate = postdate;
    }
}