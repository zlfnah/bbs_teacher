package pack_BBS;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pack_DBCP.DBConnectionMgr;

public class BoardMgr {

	private DBConnectionMgr pool;
	private static final String SAVEFOLER = "D:/JSP_BigData_0616/zzupd/silsp/jsp_Model1/Proj_Ch14_BBS/src/main/webapp/fileUpload";
	// 수식어 static final 이 함께 사용된 필드를 상수필드라고함.
	// 상수필드는 선언과 동시에 반드시 초기화해야 함.
	// 필드명은 모두 대문자, 단어간 연결은 밑줄
	// 재초기화 안됨

	private static String encType = "UTF-8";
	private static int maxSize = 5 * 1024 * 1024;

	public BoardMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		}

	}

///////////////  게시판 입력(PostProc.jsp) 시작  ///////////////
	public void insertBoard(HttpServletRequest req) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		MultipartRequest multi = null;
		int fileSize = 0;
		String fileName = null;

		try {
			objConn = pool.getConnection();
			sql = "select max(num) from tblBoard";
			objPstmt = objConn.prepareStatement(sql);
			objRs = objPstmt.executeQuery();

			int ref = 1; // 답변글 작성용, 원본글의 글번호(num)와 일치
			if (objRs.next())
				ref = objRs.getInt(1) + 1;
			// 현재 DB tblBoard에 데이터가 3개(num 컬럼에 1, 2, 3)가
			// 있다고 가정하면 max(num)는 3을 반환함. 그러므로 새 글번호를
			// 참조하는 DB의 컬럼 ref는 4가 됨.

			File file = new File(SAVEFOLER);

			if (!file.exists())
				file.mkdirs();

			multi = new MultipartRequest(req, SAVEFOLER, maxSize, encType, new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("fileName") != null) {
				fileName = multi.getFilesystemName("fileName");
				fileSize = (int) multi.getFile("fileName").length();
			}
			String content = multi.getParameter("content");

			if (multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}

			sql = "insert into tblBoard (";
			sql += "uName, subject, content, ref, pos, depth, ";
			sql += "regDate, ip, count, fileName, fileSize) values (";
			sql += "?, ?, ?, ?, 0, 0,     now(), ?, 0, ?, ?)";

			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, multi.getParameter("uName"));
			objPstmt.setString(2, multi.getParameter("subject"));
			objPstmt.setString(3, content);
			objPstmt.setInt(4, ref);
			objPstmt.setString(5, multi.getParameter("ip"));
			objPstmt.setString(6, fileName);
			objPstmt.setInt(7, fileSize);
			objPstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

	}
///////////////  게시판 입력(PostProc.jsp) 끝    ///////////////	

///////////////////////////////////////////////////////////////////
///////////////  게시판 리스트 작업관련(List.jsp) 시작  ///////////////
///////////////////////////////////////////////////////////////////

///////////////  게시판 리스트 출력(List.jsp) 시작    ///////////////
	public Vector<BoardBean> getBoardList(String keyField, String keyWord, int start, int end) {

		Vector<BoardBean> vList = new Vector<>();
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;

		try {
			objConn = pool.getConnection(); // DB연동
			
			
			if (keyWord.equals("null") || keyWord.equals("")) {
				// 검색어가 없을 경우
				sql = "select * from tblBoard "
						+ "order by ref desc, pos asc limit ?, ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setInt(1, start);
				objPstmt.setInt(2, end);
			} else {
				// 검색어가 있을 경우
				sql = "select * from tblBoard "
						+ "where "+ keyField +" like ? "
						+ "order by ref desc, pos asc limit ?, ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setString(1, "%"+keyWord+"%");
				objPstmt.setInt(2, start);
				objPstmt.setInt(3, end);				
			}
			
			
			objRs = objPstmt.executeQuery();

			while (objRs.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(objRs.getInt("num"));
				bean.setuName(objRs.getString("uName"));
				bean.setSubject(objRs.getString("subject"));
				bean.setPos(objRs.getInt("pos"));
				bean.setRef(objRs.getInt("ref"));
				bean.setDepth(objRs.getInt("depth"));
				bean.setRegDate(objRs.getString("regDate"));
				bean.setCount(objRs.getInt("count"));
				vList.add(bean);
			}
		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		return vList;
	}

///////////////  게시판 리스트 출력(List.jsp) 끝    ///////////////

//////////////////총 게시물 수(List.jsp) 시작 //////////////////
	public int getTotalCount(String keyField, String keyWord) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		int totalCnt = 0;

		try {
			objConn = pool.getConnection(); // DB연동
			
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(*) from tblBoard";
				objPstmt = objConn.prepareStatement(sql);
			} else {
				sql = "select count(*) from tblBoard ";
				sql += "where "+keyField+" like ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setString(1, "%" + keyWord + "%");
			}

			objRs = objPstmt.executeQuery();

			if (objRs.next()) {
				totalCnt = objRs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		return totalCnt;
	}
//////////////////총 게시물 수(List.jsp) 끝 //////////////////

///////////////////////////////////////////////////////////////////
///////////////  게시판 리스트 작업관련(List.jsp) 끝  ///////////////
///////////////////////////////////////////////////////////////////

////////  게시판 뷰페이지 출력(Read.jsp, 내용보기 페이지) 시작 ////////

	public void upCount(int num) {
		// 조회수 증가 시작
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		String sql = null;

		try {
			objConn = pool.getConnection(); // DB연동
			sql = "update tblBoard set count = count+1 where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objPstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt);
		}

	} // upCount( ), 조회수 증가 끝

	public BoardBean getBoard(int num) {
//		뷰페이지 게시글 데이터 반환 시작
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;

		BoardBean bean = new BoardBean();
		try {
			objConn = pool.getConnection(); // DB연동
			sql = "select * from tblBoard where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objRs = objPstmt.executeQuery();

			if (objRs.next()) {
				bean.setNum(objRs.getInt("num"));
				bean.setuName(objRs.getString("uName"));
				bean.setSubject(objRs.getString("subject"));
				bean.setContent(objRs.getString("content"));
				bean.setPos(objRs.getInt("pos"));
				bean.setRef(objRs.getInt("ref"));
				bean.setDepth(objRs.getInt("depth"));
				bean.setRegDate(objRs.getString("regDate"));
				bean.setuPw(objRs.getString("uPw"));
				bean.setCount(objRs.getInt("count"));
				bean.setFileName(objRs.getString("fileName"));
				bean.setFileSize(objRs.getInt("fileSize"));
				bean.setIp(objRs.getString("ip"));
			}

		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		return bean;
	} // getBoard( ), 게시글 데이터 반환

	public static void main(String[] args) {
		System.out.println(len);
	}

	public static int len;
	public void downLoad(HttpServletRequest req, HttpServletResponse res, JspWriter out, PageContext pageContext) {
		String fileName = req.getParameter("fileName"); // 다운로드할 파일 매개변수명 일치
		try {
			File file = new File(UtilMgr.con(SAVEFOLER + File.separator + fileName));

			byte[] b = new byte[(int) file.length()];
			res.setHeader("Accept-Ranges", "bytes");
			String strClient = req.getHeader("User-Agent");
			res.setContentType("application/smnet;charset=utf-8");
			res.setHeader("Content-Disposition", "attachment;fileName=" + fileName + ";");

			out.clear();
			out = pageContext.pushBody();

			if (file.isFile()) {
				BufferedInputStream fIn = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream fOuts = new BufferedOutputStream(res.getOutputStream());
				int read = 0;
				while ((read = fIn.read(b)) != -1) {
					fOuts.write(b, 0, read);
				}
				fOuts.close();
				fIn.close();

			}

		} catch (Exception e) {
			System.out.println("파일 처리 이슈 : " + e.getMessage());
		}

	}

//////   게시판 뷰페이지 출력(Read.jsp, 내용보기 페이지) 끝  ////////	

////////////////// 게시글 삭제(Delete.jsp) 시작 //////////////////
	public int deleteBoard(int num) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;

		int exeCnt = 0; // 삭제 데이터 수, DB 삭제가 실행되었는지 여부 판단

		try {
			objConn = pool.getConnection(); // DB연동

			//////////// 게시글의 파일 삭제 시작 ///////////////
			sql = "select fileName from tblBoard where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objRs = objPstmt.executeQuery();

			if (objRs.next() && objRs.getString(1) != null) {
				if (!objRs.getString(1).equals("")) {
					String fName = objRs.getString(1);
					String fileSrc = SAVEFOLER + "/" + fName;
					File file = new File(fileSrc);

					if (file.exists())
						file.delete(); // 파일 삭제 실행

				}
			}
			//////////// 게시글의 파일 삭제 끝 ///////////////

			//////////// 게시글 삭제 시작 ///////////////
			sql = "delete from tblBoard where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			exeCnt = objPstmt.executeUpdate();
			//////////// 게시글 삭제 끝 ///////////////

		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		return exeCnt;
	}
////////////////게시글 삭제(Delete.jsp) 끝 //////////////////

	
	
//////// 게시글 수정페이지 (UpdateProc.jsp) 시작 ////////

	public int updateBoard(BoardBean bean) {
		// 조회수 증가 시작
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		String sql = null;
		int exeCnt = 0;

		try {
			objConn = pool.getConnection(); // DB연동
			sql = "update tblBoard set uName=?, subject=?, content=? where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getuName());
			objPstmt.setString(2, bean.getSubject());
			objPstmt.setString(3, bean.getContent());
			objPstmt.setInt(4, bean.getNum());
			exeCnt = objPstmt.executeUpdate();
			// exeCnt : DB에서 실제 적용된 데이터(=row, 로우)의 개수 저장됨

		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt);
		}

		return exeCnt;
	}

//////게시글 수정페이지 (UpdateProc.jsp) 끝 ////////	
		
	

///////// 게시글 답변 페이지 (ReplyProc.jsp) 시작 //////////
	public int replyBoard(BoardBean bean) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		int cnt = 0;
	

		try {
			objConn = pool.getConnection(); // DB연동

			//////////// 게시글의 파일 삭제 시작 ///////////////
			sql = "insert into tblBoard (";
			sql += "uName, content, subject, ";
			sql += "ref, pos, depth,  ";
			sql += "regDate, uPw, count, ip) values (";
			sql += "?, ?, ?, ?, ?, ?,now(), ?, 0, ?)";

			int depth = bean.getDepth() + 1;
			int pos = bean.getPos() + 1;
			
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getuName());
			objPstmt.setString(2, bean.getContent());
			objPstmt.setString(3, bean.getSubject());
			objPstmt.setInt(4, bean.getRef());
			objPstmt.setInt(5, pos);
			objPstmt.setInt(6, depth);
			objPstmt.setString(7, bean.getuPw());
			objPstmt.setString(8, bean.getIp());
			cnt = objPstmt.executeUpdate();


		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		return cnt;  // DB에 실제 입력된 데이터 수(= Row Count) 반환
	}
	
	
	
	/////////////// 답변글 끼어들기 메서드 시작 ///////////////
	public int replyUpBoard(int ref, int pos) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		int cnt = 0;
		

		try {
			objConn = pool.getConnection(); // DB연동

			//////////// 게시글의 파일 삭제 시작 ///////////////
			sql = "update tblBoard set pos = pos + 1 ";
			sql += "where ref = ? and pos > ?";
			
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, ref);
			objPstmt.setInt(2, pos);
			cnt = objPstmt.executeUpdate();


		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		
		return cnt;
	}	
	/////////////// 답변글 끼어들기 메서드 끝 ///////////////
	

///////// 게시글 답변 페이지 (ReplyProc.jsp) 끝 //////////

}
