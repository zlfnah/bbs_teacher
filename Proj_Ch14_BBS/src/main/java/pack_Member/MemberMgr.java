package pack_Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import pack_DBCP.DBConnectionMgr;

public class MemberMgr {

	private DBConnectionMgr pool;

	public MemberMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

///////////////////////////////////////////////////////////////////	
/////////////   Member.jsp ID  중복확인 시작 /////////////////////
///////////////////////////////////////////////////////////////////

	public boolean checkId(String uId) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;

		String sql = null;
		boolean flag = false;

		try {
			objConn = pool.getConnection();
			sql = "select uId from tblMember where uId=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uId);

			flag = objPstmt.executeQuery().next();

		} catch (Exception e) {

			System.out.println("SQL 이슈 : " + e.getMessage());

		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		return flag;
	}
///////////////////////////////////////////////////////////////////	
/////////////   Member.jsp ID  중복확인 끝 /////////////////////
///////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////	
///////////// ZipCheck.jsp 우편번호 검색 시작 ////////////////////
///////////////////////////////////////////////////////////////////	
	public Vector<ZipCodeBean> zipCodeRead(String area3) {

		Vector<ZipCodeBean> vList = new Vector<>();

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;

		String sql = null;

		try {
			objConn = pool.getConnection();
			sql = "select * from tblZipCode where area3 like ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, "%" + area3 + "%");

			objRs = objPstmt.executeQuery();

			if (objRs != null) {
				while (objRs.next()) {

					ZipCodeBean zipBean = new ZipCodeBean();

					zipBean.setZipCode(objRs.getString("zipCode"));
					zipBean.setArea1(objRs.getString("area1"));
					zipBean.setArea2(objRs.getString("area2"));
					zipBean.setArea3(objRs.getString("area3"));
					zipBean.setArea4(objRs.getString("area4"));

					vList.add(zipBean);

				}
			}

		} catch (Exception e) {

			System.out.println("SQL 이슈 : " + e.getMessage());

		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		return vList;
	}
///////////////////////////////////////////////////////////////////	
///////////// ZipCheck.jsp 우편번호 검색 끝 //////////////////////
///////////////////////////////////////////////////////////////////	

///////////////////////////////////////////////////////////////////	
///////////// MemberProc.jsp 회원가입 시작 //////////////////////
///////////////////////////////////////////////////////////////////
	public boolean insertMember(MemberBean bean) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		String sql = null;
		boolean flag = false;

		try {
			objConn = pool.getConnection();
			sql = "insert into tblMember ";
			sql += "(uId, uPw, uName, uGender, ";
			sql += "uBirthday, uEmail, uZip, ";
			sql += "uAddr, uHobby, uJob) ";
			sql += "values ";
			sql += "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getuId());
			objPstmt.setString(2, bean.getuPw());
			objPstmt.setString(3, bean.getuName());
			objPstmt.setString(4, bean.getuGender());
			objPstmt.setString(5, bean.getuBirthday());
			objPstmt.setString(6, bean.getuEmail());
			objPstmt.setString(7, bean.getuZip());
			objPstmt.setString(8, bean.getuAddr());

			String[] hobby = bean.getuHobby();
			// Member.jsp에서 취미에서 선택한 체크기호의 값이 필드에 저장됨
			// {"인터넷", "게임", "영화"};

			String[] strList = { "인터넷", "여행", "게임", "영화", "운동" };
			char[] hobbyList = { '0', '0', '0', '0', '0' };

			for (int i = 0; i < hobby.length; i++) {
				// hobby.length => 3
				for (int j = 0; j < strList.length; j++) {
					// strList.length => 5
					if (hobby[i].equals(strList[j])) {
						hobbyList[j] = '1';
					}
				}

			}

			objPstmt.setString(9, new String(hobbyList));

			objPstmt.setString(10, bean.getuJob());
			int cnt = objPstmt.executeUpdate();
			if (cnt > 0)
				flag = true; // insert가 정상실행되었음을 의미

		} catch (Exception e) {

			System.out.println("SQL 이슈 : " + e.getMessage());

		} finally {
			pool.freeConnection(objConn, objPstmt);
		}

		return flag;
	}

///////////////////////////////////////////////////////////////////	
///////////// MemberProc.jsp 회원가입 끝 //////////////////////
///////////////////////////////////////////////////////////////////

	
	
///////////// 로그인 사용자 이름 반환(Login.jsp) 시작 //////////////////////	
	
	public String getMemberName(String uId) {
		
		String uName = "";
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;

		String sql = null;

		try {
			objConn = pool.getConnection();
			sql = "select uName from tblMember where uId=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uId);

			objRs = objPstmt.executeQuery();
			if (objRs.next()) {
				uName = objRs.getNString(1);				
			}

		} catch (Exception e) {

			System.out.println("SQL 이슈 : " + e.getMessage());

		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		
		return uName;
	}
	
/////////// 로그인 사용자 이름 반환(Login.jsp) 끝 //////////////////////	
	
	
	
	
///////////////////////////////////////////////////////////////////	
///////////// LoginProc.jsp 로그인 시작 //////////////////////
///////////////////////////////////////////////////////////////////

	public boolean loginMember(String uId, String uPw) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;

		String sql = null;
		boolean flag = false;

		try {
			objConn = pool.getConnection();
			sql = "select uId from tblMember where uId=? and uPw=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uId);
			objPstmt.setString(2, uPw);

			flag = objPstmt.executeQuery().next();

		} catch (Exception e) {

			System.out.println("SQL 이슈 : " + e.getMessage());

		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		return flag;
	}
///////////////////////////////////////////////////////////////////	
///////////// LoginProc.jsp 로그인 끝 //////////////////////
///////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////	
/////// Member_Mod.jsp 회원정보 수정 입력폼 시작 /////////////
///////////////////////////////////////////////////////////////////

	public Vector modifyMember(String uId) {

		Vector<MemberBean> vList = new Vector<>();

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;

		String sql = null;

		try {
			objConn = pool.getConnection();
			sql = "select * from tblMember where uId=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uId);

			objRs = objPstmt.executeQuery();

			if (objRs != null) {
				while (objRs.next()) {

					MemberBean memBean = new MemberBean();

					memBean.setuId(objRs.getString("uId"));
					memBean.setuPw(objRs.getString("uPw"));
					memBean.setuName(objRs.getString("uName"));
					memBean.setuEmail(objRs.getString("uEmail"));
					memBean.setuGender(objRs.getString("uGender"));
					memBean.setuBirthday(objRs.getString("uBirthday"));
					memBean.setuZip(objRs.getString("uZip"));
					memBean.setuAddr(objRs.getString("uAddr"));

					// DB에서 반환받은 셀의 데이터를 String[] 자료형으로 변경후 필드에 대입 시작
					String str = objRs.getString("uHobby");
					String[] hobbyList = { "0", "0", "0", "0", "0" };
					char ch = '0';
					for (int i = 0; i < str.length(); i++) {
						ch = str.charAt(i);
						hobbyList[i] = Character.toString(ch);
					}
					memBean.setuHobby(hobbyList);
					// DB에서 반환받은 셀의 데이터를 String[] 자료형으로 변경후 필드에 대입 끝

					memBean.setuJob(objRs.getString("uJob"));

					vList.add(memBean);

				}
			}

		} catch (Exception e) {

			System.out.println("SQL 이슈 : " + e.getMessage());

		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		return vList;
	}

///////////////////////////////////////////////////////////////////	
/////// Member_Mod.jsp 회원정보 수정 입력폼 끝 /////////////
///////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////	
/////// Member_ModProc.jsp 회원정보 수정 시작 /////////////
///////////////////////////////////////////////////////////////////	
	public boolean modifyMember(String uPw, String uName, String uJob, String uId) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		String sql = null;
		boolean flag = false;

		try {
			objConn = pool.getConnection();

			sql = "update tblMember set ";
			sql += "uPw=?, uName=?, uJob=? ";
			sql += "where uId = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uPw);
			objPstmt.setString(2, uName);
			objPstmt.setString(3, uJob);
			objPstmt.setString(4, uId);

			int cnt = objPstmt.executeUpdate();
			if (cnt > 0)
				flag = true; // update가 정상실행되었음을 의미

		} catch (Exception e) {

			System.out.println("SQL 이슈 : " + e.getMessage());

		} finally {
			pool.freeConnection(objConn, objPstmt);
		}

		return flag;
	}

///////////////////////////////////////////////////////////////////	
/////// Member_ModProc.jsp 회원정보 수정 끝 /////////////
///////////////////////////////////////////////////////////////////

	
	
///////////////////////////////////////////////////////////////////	
////////////// Member_Del.jsp 회원탈퇴 시작 ////////////////////
///////////////////////////////////////////////////////////////////	
	public boolean deleteMember(String uId) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		String sql = null;
		boolean flag = false;

		try {
			objConn = pool.getConnection();

			sql = "delete from tblMember where uId = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uId);

			int cnt = objPstmt.executeUpdate();
			if (cnt > 0)
				flag = true; // update가 정상실행되었음을 의미

		} catch (Exception e) {

			System.out.println("SQL 이슈 : " + e.getMessage());

		} finally {
			pool.freeConnection(objConn, objPstmt);
		}

		return flag;
	}

///////////////////////////////////////////////////////////////////	
//////////////Member_Del.jsp 회원탈퇴 끝 ////////////////////
///////////////////////////////////////////////////////////////////

} // End of Class
