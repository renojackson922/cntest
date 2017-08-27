package codenator.cclass;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import codenator.member.MemberDTO;
public class CclassDAO {

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

	/* 과목 개설 */
	public void cinsert(CclassDTO cdto) throws Exception{
		Connection con = this.connect();

		String sql = "insert into class values(class_seq.nextval, ?, ?, ?, ?, ?, sysdate, sysdate)"; //validDate 필히 수정할 것 !
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, cdto.getProf_id());
		ps.setString(2, cdto.getCname());
		ps.setString(3, sha1(cdto.getCname()));
		ps.setInt(4, cdto.getMaxAttend());
		ps.setString(5, cdto.getCintro());

		ps.execute();
		con.close();
	}
	
	/*과목 리스트*/
	public List<CclassDTO> clist(int prof_id) throws Exception{
		Connection con = this.connect();

		String sql = "select * from class where prof_id =?"; //수정요함
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, prof_id);

		ResultSet rs = ps.executeQuery();

		List<CclassDTO> list = new ArrayList<>();
		
		//연결이 종료되기 전에 MemberDTO 객체에 rs의 데이터를 옮긴다

		while(rs.next()){
			CclassDTO cdto = new CclassDTO();
			//rs → cdto 데이터 이동
			
			cdto.setCno(rs.getInt("cno"));
			cdto.setProf_id(rs.getInt("prof_id"));
			cdto.setCname(rs.getString("cname"));
			cdto.setCid(rs.getString("cid"));
			cdto.setMaxAttend(rs.getInt("maxattend"));
			cdto.setCintro(rs.getString("cintro"));
			cdto.setCreateDate(rs.getString("createDate"));
			cdto.setValidDate(rs.getString("validDate"));
			
			list.add(cdto);
		}

		con.close();
		return list;
	}

	/*과목 검색*/
	public CclassDTO get(int prof_id, String cid) throws Exception{
		Connection con = this.connect();
		String sql = "select * from class where prof_id = ? and cid = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, prof_id);
		ps.setString(2, cid);
		ResultSet rs = ps.executeQuery();
		
		CclassDTO cdto = new CclassDTO();
		if(rs.next()){
			cdto.setCno(rs.getInt("cno"));
			cdto.setProf_id(rs.getInt("prof_id"));
			cdto.setCname(rs.getString("cname"));
			cdto.setCid(rs.getString("cid"));
			cdto.setMaxAttend(rs.getInt("maxattend"));
			cdto.setCintro(rs.getString("cintro"));
			cdto.setCreateDate(rs.getString("createDate"));
			cdto.setValidDate(rs.getString("validDate"));
		}
		
		return cdto;
	}
	
	public List<CclassDTO> search_all() throws Exception{
		Connection con = this.connect();
		String sql = "select * from class order by cno asc";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		//rs → NoticeDTO → List<NoticeDTO>

		List<CclassDTO> list = new ArrayList<>();

		while(rs.next()){
			CclassDTO cdto = new CclassDTO();
			cdto.setCno(rs.getInt("cno"));
			cdto.setProf_id(rs.getInt("prof_id"));
			cdto.setCname(rs.getString("cname"));
			cdto.setCid(rs.getString("cid"));
			cdto.setMaxAttend(rs.getInt("maxattend"));
			cdto.setCintro(rs.getString("cintro"));
			cdto.setCreateDate(rs.getString("createDate"));
			cdto.setValidDate(rs.getString("validDate"));

			list.add(cdto);
		}

		con.close();
		return list;
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
