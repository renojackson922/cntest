package codenator.notice;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.io.File;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NoticeDAO {

	private static DataSource pc;
	static{
		try{
			//context.xml 탐사 로봇 생성
			Context robot = new InitialContext();
			pc = (DataSource)robot.lookup("java:comp/env/jdbc/oracle");
		}catch(Exception e){
			System.out.println("DB연결 실패");
			e.printStackTrace();
		}
	}

	private Connection connect() throws Exception{
		return pc.getConnection();
	}


	public void insert(NoticeDTO ndto) throws Exception{
		Connection con = this.connect();
		/*con.setAutoCommit(false);//수동 commit 모드 설정
		 */		

		String sql = "insert into notice values(notice_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate, 0)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, ndto.getSubject());
		ps.setString(2, ndto.getCid());
		ps.setString(3, ndto.getWriter());
		ps.setInt(4, ndto.getProf_id());
		ps.setString(5, ndto.getTitle());
		ps.setString(6, ndto.getDetail());

		ps.execute();
		
		con.close();

	}

	public NoticeDTO get(int no) throws Exception{
		Connection con = this.connect();
		String sql = "select * from notice where no=?"; //cid=? and prof_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ResultSet rs = ps.executeQuery();

		NoticeDTO ndto = new NoticeDTO();
		if(rs.next()){
			//rs → ndto
			ndto.setNo(rs.getInt("no"));
			ndto.setSubject(rs.getString("subject"));
			ndto.setCid(rs.getString("cid"));
			ndto.setWriter(rs.getString("writer"));
			ndto.setProf_id(rs.getInt("prof_id"));
			ndto.setTitle(rs.getString("title"));
			ndto.setDetail(rs.getString("detail"));
			ndto.setReg(rs.getString("reg")); //http://localhost:8080/codenator/page/menu/stu/stu_main.jsp#
			ndto.setRead(rs.getInt("read"));
		}

		return ndto;
	}

	public List<NoticeDTO> search(int prof_id, String cid) throws Exception{
		Connection con = this.connect();
		String sql = "select no,subject,cid,writer,prof_id,title,replace(detail,chr(13)||chr(10),'<br>'),reg,read from notice"
				+ " where prof_id = ? and cid = ? order by no asc";
		
		//String sql = "select * from notice where "+type+"like ?"

		PreparedStatement ps = con.prepareStatement(sql);

		/*ps.setString(1, "%"+key+"%");*/
		ps.setInt(1, prof_id);
		ps.setString(2, cid);
		
		ResultSet rs = ps.executeQuery();
		//rs → NoticeDTO → List<NoticeDTO>

		List<NoticeDTO> list = new ArrayList<>();

		while(rs.next()){
			NoticeDTO ndto = new NoticeDTO();
			/*ndto.setRn(rs.getInt("rn"));*/

			ndto.setNo(rs.getInt("no"));
			ndto.setSubject(rs.getString("subject"));
			ndto.setCid(rs.getString("cid"));
			ndto.setWriter(rs.getString("writer"));
			ndto.setProf_id(rs.getInt("prof_id"));
			ndto.setTitle(rs.getString("title"));
			ndto.setDetail(rs.getString("replace(detail,chr(13)||chr(10),'<br>')"));
			ndto.setReg(rs.getString("reg"));
			ndto.setRead(rs.getInt("read"));

			list.add(ndto);
		}

		con.close();
		return list;
	} 
	
	public void remove(int no, String cid) throws Exception{
		Connection con = this.connect();
		
		String sql = "delete notice where no=? and cid=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ps.setString(2, cid);
		
		ps.execute();
		
		con.close();
		//return;
	}
}
