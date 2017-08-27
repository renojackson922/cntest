package codenator.board;

import java.text.SimpleDateFormat;
import java.util.Date;

public class BoardDTO {
	/* �ӽ� Ȯ�ο� rn �߰� */
	private int rn;
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	
	private int no;
	private String writer;
	private String title;
	private String detail;
	private String pw;
	private String reg;
	private int read;
	private int reply;
	
	/* ���� ���� �׸� �߰� */
	private String filename;
	private long filesize;

	/* �亯�� �Խ��� ���� �׸� �߰� */
	private int groupno;
	private int groupseq;
	private int depth;
	
	public int getGroupno() {
		return groupno;
	}
	public void setGroupno(int groupno) {
		this.groupno = groupno;
	}
	public int getGroupseq() {
		return groupseq;
	}
	public void setGroupseq(int groupseq) {
		this.groupseq = groupseq;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public long getFilesize() {
		return filesize;
	}
	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}
	public BoardDTO() {
		super();
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDetail() {
		return detail;
	}
	
	public String getWeb() {
		return detail.replace("\n", "<br>");
	}
	
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getReg() {
		return reg;
	}
	//�ð��� ���õ� �߰� ��ɵ��� ����
	public String getTime(){
		return reg.substring(11, 16);
	}
	public String getDate(){
		return reg.substring(0, 10);
	}
	//�˾Ƽ� �������� ���
	public String getAuto(){
		//yyyy-MM-dd�� ���ϴ� ��� : Date, SimpleDateFormat, Calendar
		
		//Date date = new Date();
		//Format f = new SimpleDateFormat("yyyy-MM-dd");
		//String today = f.format(date);
		
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		if(getDate().equals(today))
			return getTime();
		else
			return getDate();
	}
	
	public void setReg(String reg) {
		this.reg = reg;
	}
	public int getRead() {
		return read;
	}
	public void setRead(int read) {
		this.read = read;
	}
	public int getReply() {
		return reply;
	}
	public void setReply(int reply) {
		this.reply = reply;
	}
	
	/* �ֽű� ���θ� Ȯ���ϴ� getNew() �޼ҵ带 ����, �ֽű��� ������ 1�ð� */
	public boolean getNew(){
		String today = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		String day = today.substring(0, 10);
		
		if(day.equals(getDate())){
			String t1 = today.substring(11, 13);		//23
			String t2 = reg.substring(11, 13);			//11
			int v1 = Integer.parseInt(t1);
			int v2 = Integer.parseInt(t2);
			return v1 - v2 == 0 || v1 - v2 == 1;
		}
		return false;
	}
}














