package bean;

import java.util.Objects;

public class NoticeDTO {
	private int notice_no; 			// 공지사항 번호
	private String notice_title; 	// 공지사항 제목
	private String notice_content; 	// 공지사항 내용
	private String notice_reg; 		// 공지사항 작성일
	private int notice_check; 		// 공지사항 중요여부
	
	// 공지사항 번호
	public int getNotice_no() {
		return notice_no;
	}
	
	// 공지사항 제목
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	
	// 공지사항 내용
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	
	// 공지사항 작성일
	public String getNotice_reg() {
		return notice_reg;
	}
	public void setNotice_reg(String notice_reg) {
		this.notice_reg = notice_reg;
	}
	
	// 공지사항 중요여부
	public int getNotice_check() {
		return notice_check;
	}
	public void setNotice_check(int notice_check) {
		this.notice_check = notice_check;
	}

	@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        NoticeDTO notice = (NoticeDTO) o;
        return Objects.equals(notice_no, notice.notice_no);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(notice_no);
    }
}