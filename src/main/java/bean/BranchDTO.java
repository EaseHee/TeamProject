package bean;

import java.util.Objects;

public class BranchDTO {
	private String branch_code;
	private String branch_pw;
	private String branch_name;
	private String branch_tel;
	private String branch_address;
	private String branch_note;
    
     public String getBranch_code() {
		return branch_code;
	}

	public void setBranch_code(String branch_code) {
		this.branch_code = branch_code;
	}

	public String getBranch_pw() {
		return branch_pw;
	}

	public void setBranch_pw(String branch_pw) {
		this.branch_pw = branch_pw;
	}

	public String getBranch_name() {
		return branch_name;
	}

	public void setBranch_name(String branch_name) {
		this.branch_name = branch_name;
	}

	public String getBranch_tel() {
		return branch_tel;
	}

	public void setBranch_tel(String branch_tel) {
		this.branch_tel = branch_tel;
	}

	public String getBranch_address() {
		return branch_address;
	}

	public void setBranch_address(String branch_address) {
		this.branch_address = branch_address;
	}

	public String getBranch_note() {
		return branch_note;
	}

	public void setBranch_note(String branch_note) {
		this.branch_note = branch_note;
	}

	@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        BranchDTO branch = (BranchDTO) o;
        return Objects.equals(branch_code, branch.branch_code);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(branch_code);
    }
}
