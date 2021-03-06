package codenator.member;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/*import codenator.notice.NoticeDTO;*/
public class MemberDAO {
	static String prof_seq;
	
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
	
	public void insert(MemberDTO mdto) throws Exception{
		Connection con = this.connect();
		
		String sql = "select TO_CHAR(prof_seq.nextval) from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		prof_seq = rs.getString(1);
		
		/* 援щ텇?꽑 */
		
		sql = "insert into member values(member_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
		ps = con.prepareStatement(sql);
		
		ps.setString(1, mdto.getPower());
		if(mdto.getPower().equals("admin")){
			ps.setString(2, "19920829");
		}else if(mdto.getPower().equals("prof")){
			ps.setString(2, prof_seq);
		}else ps.setString(2, "-1");
		ps.setString(3, mdto.getName());
		ps.setString(4, mdto.getId());
		ps.setString(5, mdto.getPw());
		ps.setString(6, mdto.getBelong());
		ps.setString(7, mdto.getIntro());
		ps.setString(8, mdto.getTel());
		ps.setString(9, mdto.getBirth());
		ps.execute();
		con.close();
	}
	
	public boolean login(String id, String pw) throws Exception{
		Connection con = this.connect();
		
		String sql = "select * from member where id=? and pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		ps.setString(2, pw);
		
		ResultSet rs = ps.executeQuery();
		boolean result = rs.next();
		
		con.close();
		return result;
	}
	
	public MemberDTO search(String id) throws Exception{
		Connection con = this.connect();
		
		String sql = "select * from member where id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		//占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙풉占? 占쏙옙占쏙옙 MemberDTO 占쏙옙체占쏙옙 rs占쏙옙 占쏙옙占쏙옙占싶몌옙 占신깍옙占?
		MemberDTO mdto = new MemberDTO();
		if(rs.next()){
			//rs 占쏙옙 mdto 占쏙옙占쏙옙占쏙옙 占싱듸옙
			mdto.setNo(rs.getInt("no"));
			mdto.setPower(rs.getString("power"));
			mdto.setProf_id(rs.getString("prof_id"));
			mdto.setName(rs.getString("name"));
			mdto.setId(rs.getString("id"));
			mdto.setPw(rs.getString("pw"));
			mdto.setBelong(rs.getString("belong"));
			mdto.setIntro(rs.getString("intro"));
			mdto.setTel(rs.getString("tel"));
			mdto.setBirth(rs.getString("birth"));	
			mdto.setJoindate(rs.getString("joindate"));
		}
		
		con.close();
		return mdto;
	}
	
	public void drop(String id) throws Exception{
		Connection con = this.connect();
		
		String sql = "delete member where id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		
		ps.execute();
		
		con.close();
		//return;
	}
	
	public void edit(MemberDTO mdto) throws Exception{
		Connection con = this.connect();
		
		String sql = "update member set pw=?, tel=?, birth=? where id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getPw());
		ps.setString(2, mdto.getTel());
		ps.setString(3, mdto.getBirth());
		ps.setString(4, mdto.getId());
		
		ps.execute();
		
		con.close();
		//return;
	}
	
	public boolean find(String id) throws Exception{
		Connection con = this.connect();
		
		String sql = "select * from member where id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		boolean result = rs.next();
		
		con.close();
		return result;
	}
	
	public List<MemberDTO> search_all() throws Exception{
		Connection con = this.connect();
		String sql = "select * from member order by no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		//rs ?넂 NoticeDTO ?넂 List<NoticeDTO>

		List<MemberDTO> list = new ArrayList<>();

		while(rs.next()){
			MemberDTO mdto = new MemberDTO();
			mdto.setNo(rs.getInt("no"));
			mdto.setPower(rs.getString("power"));
			mdto.setProf_id(rs.getString("prof_id"));
			mdto.setName(rs.getString("name"));
			mdto.setId(rs.getString("id"));
			mdto.setPw(sha1(rs.getString("pw")));
			mdto.setBelong(rs.getString("belong"));
			mdto.setIntro(rs.getString("intro"));
			mdto.setTel(rs.getString("tel"));
			mdto.setBirth(rs.getString("birth"));
			mdto.setJoindate(rs.getString("joindate"));

			list.add(mdto);
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
