package codenator.board;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class BoardDAO {
	
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
	
	public int insert(MultipartRequest multi) throws Exception{
		Connection con = this.connect();
		
		con.setAutoCommit(false);//수동 commit 모드 설정
		
		//새글인지 답글인지 구별한 뒤, 해당 글의 groupno, groupseq, depth를 계산해준다
		int test = Integer.parseInt(multi.getParameter("groupno"));
		int groupno;
		int groupseq;
		int depth;
		if(test == 0){		//새글
			groupseq = 0;
			depth = 0;
			
			String sql = "select max(groupno) from board";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();//100%
			groupno = rs.getInt(1) + 1;
		}else{					//답글
			
			//[1] 원본글의 정보를 추출
			int origin_groupno = Integer.parseInt(multi.getParameter("groupno"));
			int origin_groupseq = Integer.parseInt(multi.getParameter("groupseq"));
			int origin_depth = Integer.parseInt(multi.getParameter("depth"));

			//[2] groupseq를 계산
			//first			원본글보다 차수가 낮은 글 중 가장 가까운 글
			//second	원본글과 같은 차수 중 가장 가까운 글
			String sql = 	"select ("
										+ "select min(groupseq) from board "
										+ "where groupno=? and groupseq>? and depth<?"
								+ ") as first, ("
										+ "select min(groupseq) from board "
										+ "where groupno=? and groupseq>? and depth=?"
								+ ") as second from dual";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, origin_groupno);
			ps.setInt(2, origin_groupseq);
			ps.setInt(3, origin_depth);
			ps.setInt(4, origin_groupno);
			ps.setInt(5, origin_groupseq);
			ps.setInt(6, origin_depth);
			ResultSet rs = ps.executeQuery();
			rs.next();//100%
			int first = rs.getInt("first");
			int second = rs.getInt("second");
			rs.close();
			ps.close();//명령 1회 종료
			
			if(first == 0 && second == 0){
				//SQL 재전송 : 그룹 마지막
				sql = "select max(groupseq) from board where groupno=?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, origin_groupno);
				rs = ps.executeQuery();
				rs.next();//100%
				groupseq = rs.getInt(1)+1;//마지막 + 1
				rs.close();
				ps.close();
			}else if(first == 0 && second != 0){
				//second
				groupseq = second;
			}else if(first != 0 && second == 0){
				//first
				groupseq = first;
			}else{
				//first, second중에서 작은값
				groupseq = Math.min(first, second);
			}
			
			//나머지 항목 설정
			groupno = origin_groupno;
			depth = origin_depth+1;
			
			//groupseq 의 자리부터 뒤의 모든 그룹 내의 글을 + 1
			sql = "update board set groupseq = groupseq+1 where groupno=? and groupseq>=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, groupno);
			ps.setInt(2, groupseq);
			ps.execute();
			ps.close();
		}
		
		//[1] 등록
		String sql = "insert into board values(board_seq.nextval, ?, ?, ?, ?, sysdate, 0, 0, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, multi.getParameter("writer"));
		ps.setString(2, multi.getParameter("title"));
		ps.setString(3, multi.getParameter("detail"));
		ps.setString(4, multi.getParameter("pw"));
		
		ps.setString(5, multi.getFilesystemName("file"));
		File f = multi.getFile("file");
		ps.setLong(6, f==null?0:f.length());//f가 없으면 0, 있으면 크기를 집어넣겠다
 		
		ps.setInt(7, groupno);
		ps.setInt(8, groupseq);
		ps.setInt(9, depth);
		
		ps.execute();

		//[2] 지금 등록한 게시글의 번호를 알아온다
		sql = "select max(no) from board";
		ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();//100%
		int no = rs.getInt(1);//rs.getInt("max(no)")
		
		con.commit();//커밋
		
		con.close();
		return no;
	}
	
	public List<BoardDTO> search(String type, String key, int sn, int en) throws Exception{
		Connection con = this.connect();
		
		//[1] select * from board where title like ?			type==title 일 경우
		//[2] select * from board where writer like ? 		type==writer 일 경우
		String sql = "select * from ("
								+ "select rownum rn, A.* from ("
										+ "select * from board where "+type+" like ? order by groupno desc, groupseq asc"
								+ ")A"
						+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, "%"+key+"%");
		ps.setInt(2, sn);
		ps.setInt(3, en);
		
		ResultSet rs = ps.executeQuery();
		//rs → BoardDTO → List<BoardDTO>
		
		List<BoardDTO> list = new ArrayList<>();
		
		while(rs.next()){
			//rs → BoardDTO
			BoardDTO bdto = new BoardDTO();
			//데이터 이동
			bdto.setRn(rs.getInt("rn"));
			
			bdto.setNo(rs.getInt("no"));
			bdto.setWriter(rs.getString("writer"));
			bdto.setTitle(rs.getString("title"));
			bdto.setDetail(rs.getString("detail"));
			bdto.setPw(rs.getString("pw"));
			bdto.setReg(rs.getString("reg"));
			bdto.setRead(rs.getInt("read"));
			bdto.setReply(rs.getInt("reply"));
			
			/* 파일 관련 항목 추가 */
			bdto.setFilename(rs.getString("filename"));
			bdto.setFilesize(rs.getLong("filesize"));
			
			/* 답변형 게시판 항목 추가 */
			bdto.setGroupno(rs.getInt("groupno"));
			bdto.setGroupseq(rs.getInt("groupseq"));
			bdto.setDepth(rs.getInt("depth"));
			
			//list에 추가
			list.add(bdto);
		}
		
		con.close();
		return list;
	}
	
	public BoardDTO get(int no) throws Exception{
		Connection con = this.connect();
		
		String sql = "select * from board where no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ResultSet rs = ps.executeQuery();
		
		BoardDTO bdto = new BoardDTO();
		if(rs.next()){
			//rs → bdto
			bdto.setNo(rs.getInt("no"));
			bdto.setWriter(rs.getString("writer"));
			bdto.setTitle(rs.getString("title"));
			bdto.setDetail(rs.getString("detail"));
			bdto.setPw(rs.getString("pw"));
			bdto.setReg(rs.getString("reg"));
			bdto.setRead(rs.getInt("read"));
			bdto.setReply(rs.getInt("reply"));
			
			/* 파일 관련 항목 추가 */
			bdto.setFilename(rs.getString("filename"));
			bdto.setFilesize(rs.getLong("filesize"));
			
			/* 답변형 게시판 항목 추가 */
			bdto.setGroupno(rs.getInt("groupno"));
			bdto.setGroupseq(rs.getInt("groupseq"));
			bdto.setDepth(rs.getInt("depth"));
		}
		
		con.close();
		return bdto;
	}
	
	public void read(int no) throws Exception{
		Connection con = this.connect();
		
		String sql = "update board set read = read+1 where no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ps.execute();
		
		con.close();
		//return;
	}
	
	public boolean checkpw(int no, String pw) throws Exception{
		Connection con = this.connect();
		
		//String sql = "select pw from board where no=?";
		String sql = "select * from board where no=? and pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ps.setString(2, pw);
		
		ResultSet rs = ps.executeQuery();
		boolean result = rs.next();
		con.close();
		
		return result;
	}
	
	public void delete(int no) throws Exception{
		Connection con = this.connect();
		
		String sql = "delete board where no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		
		ps.execute();
		
		con.close();
		//return;
	}
	
	public void edit(BoardDTO bdto) throws Exception{
		Connection con = this.connect();
		
		String sql = "update board set title=?, detail=?, pw=? where no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, bdto.getTitle());
		ps.setString(2, bdto.getDetail());
		ps.setString(3, bdto.getPw());
		ps.setInt(4, bdto.getNo());
		ps.execute();
		
		con.close();
		//return;
	}
	
	public int getBoardcount(String type, String key) throws Exception{
		Connection con = this.connect();

		String sql = "select count(*) from board where "+type+" like '%'||?||'%'";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		
		ResultSet rs = ps.executeQuery();
		rs.next();//100%
		int count = rs.getInt(1);
		
		con.close();
		return count;
	}
	
}
















