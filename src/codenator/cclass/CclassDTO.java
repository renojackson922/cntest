package codenator.cclass;

public class CclassDTO {
	private int cno;
	private int prof_id;
	private String cname;
	private String cid;
	private int maxAttend;
	private String cintro;
	private String createDate;
	private String validDate;
	
	public CclassDTO(){
		super();
	}
	public int getCno() {
		return cno;
	}
	public void setCno(int no) {
		this.cno = no;
	}
	public int getProf_id() {
		return prof_id;
	}
	public void setProf_id(int prof_id) {
		this.prof_id = prof_id;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String name) {
		this.cname = name;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public int getMaxAttend() {
		return maxAttend;
	}
	public void setMaxAttend(int maxAttend) {
		this.maxAttend = maxAttend;
	}
	public String getCintro() {
		return cintro;
	}
	public void setCintro(String cintro) {
		this.cintro = cintro;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getValidDate() {
		return validDate;
	}
	public void setValidDate(String validDate) {
		this.validDate = validDate;
	}
	
}