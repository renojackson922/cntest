package codenator.assign;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import codenator.cclass.CclassDTO;
import codenator.notice.NoticeDTO;

public class AssignDAO {

	//미리 관리되고 있는 Oracle PC방의 정보를 가져와야 한다(javax.sql.DataSource)
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

	public void insert(AssignDTO adto) throws Exception{
		Connection con = this.connect();

		String sql = "insert into assign values(assign_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate,sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, adto.getCname());
		ps.setString(2, adto.getCid());
		ps.setInt(3, adto.getProf_id());
		ps.setString(4, adto.getWriter());
		ps.setString(5, adto.getVisible());
		ps.setString(6, adto.getTitle());
		ps.setString(7, adto.getDetail());
		ps.setString(8, adto.getPurpose());
		ps.setString(9, adto.getLang());
		ps.setString(10, adto.getAnswer_input1());
		ps.setString(11, adto.getAnswer_output1());
		ps.setString(12, adto.getAnswer_input2());
		ps.setString(13, adto.getAnswer_output2());
		ps.setString(14, adto.getMaincode());
		ps.execute();
		con.close();
	}

	public AssignDTO get(int no) throws Exception{
		Connection con = this.connect();
		String sql = "select no,cname,cid,prof_id,writer,visible,title,replace(detail,chr(13)||chr(10),'<br>'),replace(purpose,chr(13)||chr(10),'<br>'),"
				+" lang, answer_input1,answer_output1,answer_input2,answer_output2," 
				+"maincode,a_start,a_end from assign where no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ResultSet rs = ps.executeQuery();

		AssignDTO adto = new AssignDTO();
		if(rs.next()){
			//rs → adto
			adto.setNo(rs.getInt("no"));
			adto.setCname(rs.getString("cname"));
			adto.setCid(rs.getString("cid"));
			adto.setProf_id(rs.getInt("prof_id"));
			adto.setWriter(rs.getString("writer"));
			adto.setVisible(rs.getString("visible"));
			adto.setTitle(rs.getString("title"));
			adto.setDetail(rs.getString("replace(detail,chr(13)||chr(10),'<br>')"));
			adto.setPurpose(rs.getString("replace(purpose,chr(13)||chr(10),'<br>')"));
			adto.setLang(rs.getString("lang"));
			adto.setAnswer_input1(rs.getString("answer_input1"));	
			adto.setAnswer_output1(rs.getString("answer_output1"));	
			adto.setAnswer_input2(rs.getString("answer_input2"));	
			adto.setAnswer_output2(rs.getString("answer_output2"));	
			adto.setMaincode(rs.getString("maincode"));			
			adto.setA_start(rs.getString("a_start"));
			adto.setA_end(rs.getString("a_end"));
		}

		return adto;
	}

	public List<AssignDTO> search(String cid) throws Exception{
		Connection con = this.connect();
		String sql = "select no,cname,cid,prof_id,writer,visible,title,replace(detail,chr(13)||chr(10),'<br>'),replace(purpose,chr(13)||chr(10),'<br>'),"
				+" lang, replace(answer_input1,chr(13)||chr(10),'<br>'), replace(answer_output1,chr(13)||chr(10),'<br>')," 
				+" replace(answer_input2,chr(13)||chr(10),'<br>'), replace(answer_output2,chr(13)||chr(10),'<br>'),"
				+" maincode,a_start,a_end from assign where cid=? order by no asc";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, cid);
		
		ResultSet rs = ps.executeQuery();
		List<AssignDTO> list = new ArrayList<>();

		while(rs.next()){
			AssignDTO adto = new AssignDTO();

			adto.setNo(rs.getInt("no"));
			adto.setCname(rs.getString("cname"));
			adto.setCid(rs.getString("cid"));
			adto.setProf_id(rs.getInt("prof_id"));
			adto.setWriter(rs.getString("writer"));
			adto.setVisible(rs.getString("visible"));
			adto.setTitle(rs.getString("title"));
			adto.setDetail(rs.getString("replace(detail,chr(13)||chr(10),'<br>')"));
			adto.setPurpose(rs.getString("replace(purpose,chr(13)||chr(10),'<br>')"));
			adto.setLang(rs.getString("lang"));
			adto.setAnswer_input1(rs.getString("replace(answer_input1,chr(13)||chr(10),'<br>')"));	
			adto.setAnswer_output1(rs.getString("replace(answer_output1,chr(13)||chr(10),'<br>')"));	
			adto.setAnswer_input2(rs.getString("replace(answer_input2,chr(13)||chr(10),'<br>')"));	
			adto.setAnswer_output2(rs.getString("replace(answer_output2,chr(13)||chr(10),'<br>')"));	
			adto.setMaincode(rs.getString("maincode"));			
			adto.setA_start(rs.getString("a_start"));
			adto.setA_end(rs.getString("a_end"));

			list.add(adto);
		}

		con.close();
		return list;
	}

	//전체 검색
	public List<AssignDTO> search_all() throws Exception{
		Connection con = this.connect();
		String sql = "select no,cname,cid,prof_id,writer,visible,title,replace(detail,chr(13)||chr(10),'<br>'),replace(purpose,chr(13)||chr(10),'<br>'),"
				+" lang, answer_input1,answer_output1,answer_input2,answer_output2," 
				+"maincode,a_start,a_end from assign order by no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		//rs → NoticeDTO → List<NoticeDTO>

		List<AssignDTO> list = new ArrayList<>();

		while(rs.next()){
			AssignDTO adto = new AssignDTO();
			
			adto.setNo(rs.getInt("no"));
			adto.setCname(rs.getString("cname"));
			adto.setCid(rs.getString("cid"));
			adto.setProf_id(rs.getInt("prof_id"));
			adto.setWriter(rs.getString("writer"));
			adto.setVisible(rs.getString("visible"));
			adto.setTitle(rs.getString("title"));
			adto.setDetail(rs.getString("replace(detail,chr(13)||chr(10),'<br>')"));
			adto.setPurpose(rs.getString("replace(purpose,chr(13)||chr(10),'<br>')"));
			adto.setLang(rs.getString("lang"));
			adto.setAnswer_input1(rs.getString("answer_input1"));	
			adto.setAnswer_output1(rs.getString("answer_output1"));	
			adto.setAnswer_input2(rs.getString("answer_input2"));	
			adto.setAnswer_output2(rs.getString("answer_output2"));	
			adto.setMaincode(rs.getString("maincode"));			
			adto.setA_start(rs.getString("a_start"));
			adto.setA_end(rs.getString("a_end"));
			
			list.add(adto);
		}

		con.close();
		return list;
	} 

	public void remove(int no, String cid) throws Exception{
		Connection con = this.connect();
		
		String sql = "delete assign where no=? and cid=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ps.setString(2, cid);
		
		ps.execute();
		
		con.close();
		//return;
	}
	
	public String sha1(String s) {
		try {
			// Create MD5 Hash
			MessageDigest digest = MessageDigest.getInstance("SHA-1");
			digest.update(s.getBytes());
			byte messageDigest[] = digest.digest();
			System.out.println(digest.digest());

			// Create Hex String
			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < messageDigest.length; i++)
				hexString.append(Integer.toHexString(0xFF & messageDigest[i]));
			return hexString.toString();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return "";
	}
	

	
}
