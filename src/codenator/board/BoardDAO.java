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
	
	//�̸� �����ǰ� �ִ� Oracle PC���� ������ �����;� �Ѵ�(javax.sql.DataSource)
	private static DataSource pc;
	static{
		try{
			//context.xml Ž�� �κ� ����
			Context robot = new InitialContext();
			pc = (DataSource)robot.lookup("java:comp/env/jdbc/oracle");
		}catch(Exception e){
			System.out.println("DB���� ����");
			e.printStackTrace();
		}
	}
	
	private Connection connect() throws Exception{
		return pc.getConnection();
	}
	
	public int insert(MultipartRequest multi) throws Exception{
		Connection con = this.connect();
		
		con.setAutoCommit(false);//���� commit ��� ����
		
		//�������� ������� ������ ��, �ش� ���� groupno, groupseq, depth�� ������ش�
		int test = Integer.parseInt(multi.getParameter("groupno"));
		int groupno;
		int groupseq;
		int depth;
		if(test == 0){		//����
			groupseq = 0;
			depth = 0;
			
			String sql = "select max(groupno) from board";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();//100%
			groupno = rs.getInt(1) + 1;
		}else{					//���
			
			//[1] �������� ������ ����
			int origin_groupno = Integer.parseInt(multi.getParameter("groupno"));
			int origin_groupseq = Integer.parseInt(multi.getParameter("groupseq"));
			int origin_depth = Integer.parseInt(multi.getParameter("depth"));

			//[2] groupseq�� ���
			//first			�����ۺ��� ������ ���� �� �� ���� ����� ��
			//second	�����۰� ���� ���� �� ���� ����� ��
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
			ps.close();//��� 1ȸ ����
			
			if(first == 0 && second == 0){
				//SQL ������ : �׷� ������
				sql = "select max(groupseq) from board where groupno=?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, origin_groupno);
				rs = ps.executeQuery();
				rs.next();//100%
				groupseq = rs.getInt(1)+1;//������ + 1
				rs.close();
				ps.close();
			}else if(first == 0 && second != 0){
				//second
				groupseq = second;
			}else if(first != 0 && second == 0){
				//first
				groupseq = first;
			}else{
				//first, second�߿��� ������
				groupseq = Math.min(first, second);
			}
			
			//������ �׸� ����
			groupno = origin_groupno;
			depth = origin_depth+1;
			
			//groupseq �� �ڸ����� ���� ��� �׷� ���� ���� + 1
			sql = "update board set groupseq = groupseq+1 where groupno=? and groupseq>=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, groupno);
			ps.setInt(2, groupseq);
			ps.execute();
			ps.close();
		}
		
		//[1] ���
		String sql = "insert into board values(board_seq.nextval, ?, ?, ?, ?, sysdate, 0, 0, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, multi.getParameter("writer"));
		ps.setString(2, multi.getParameter("title"));
		ps.setString(3, multi.getParameter("detail"));
		ps.setString(4, multi.getParameter("pw"));
		
		ps.setString(5, multi.getFilesystemName("file"));
		File f = multi.getFile("file");
		ps.setLong(6, f==null?0:f.length());//f�� ������ 0, ������ ũ�⸦ ����ְڴ�
 		
		ps.setInt(7, groupno);
		ps.setInt(8, groupseq);
		ps.setInt(9, depth);
		
		ps.execute();

		//[2] ���� ����� �Խñ��� ��ȣ�� �˾ƿ´�
		sql = "select max(no) from board";
		ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();//100%
		int no = rs.getInt(1);//rs.getInt("max(no)")
		
		con.commit();//Ŀ��
		
		con.close();
		return no;
	}
	
	public List<BoardDTO> search(String type, String key, int sn, int en) throws Exception{
		Connection con = this.connect();
		
		//[1] select * from board where title like ?			type==title �� ���
		//[2] select * from board where writer like ? 		type==writer �� ���
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
		//rs �� BoardDTO �� List<BoardDTO>
		
		List<BoardDTO> list = new ArrayList<>();
		
		while(rs.next()){
			//rs �� BoardDTO
			BoardDTO bdto = new BoardDTO();
			//������ �̵�
			bdto.setRn(rs.getInt("rn"));
			
			bdto.setNo(rs.getInt("no"));
			bdto.setWriter(rs.getString("writer"));
			bdto.setTitle(rs.getString("title"));
			bdto.setDetail(rs.getString("detail"));
			bdto.setPw(rs.getString("pw"));
			bdto.setReg(rs.getString("reg"));
			bdto.setRead(rs.getInt("read"));
			bdto.setReply(rs.getInt("reply"));
			
			/* ���� ���� �׸� �߰� */
			bdto.setFilename(rs.getString("filename"));
			bdto.setFilesize(rs.getLong("filesize"));
			
			/* �亯�� �Խ��� �׸� �߰� */
			bdto.setGroupno(rs.getInt("groupno"));
			bdto.setGroupseq(rs.getInt("groupseq"));
			bdto.setDepth(rs.getInt("depth"));
			
			//list�� �߰�
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
			//rs �� bdto
			bdto.setNo(rs.getInt("no"));
			bdto.setWriter(rs.getString("writer"));
			bdto.setTitle(rs.getString("title"));
			bdto.setDetail(rs.getString("detail"));
			bdto.setPw(rs.getString("pw"));
			bdto.setReg(rs.getString("reg"));
			bdto.setRead(rs.getInt("read"));
			bdto.setReply(rs.getInt("reply"));
			
			/* ���� ���� �׸� �߰� */
			bdto.setFilename(rs.getString("filename"));
			bdto.setFilesize(rs.getLong("filesize"));
			
			/* �亯�� �Խ��� �׸� �߰� */
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
















