package dao;
import java.sql.*;
import java.util.*;
import util.*;
import vo.*;

public class TeacherSubjectDao {
	/*
	    교과목이 연결되지 않은 강사도 출력
		
		SELECT t.teacher_no, t.teacher_id, t.teacher_name,
			ts.subject_no, group_concat(s.subject_name SEPARATOR '/')
		FROM teacher t LEFT OUTER JOIN teacher_subject ts
							ON t.teacher_no = ts.teacher_no
								LEFT OUTER JOIN subject s
								on ts.subject_no = s.subject_no
		GROUP BY t.teacher_no, t.teacher_id, t.teacher_name
		LIMIT 0, 10;
	 */
	public ArrayList<HashMap<String, Object>> selectTeacherSubjectListByPage (
			int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> tsList = new ArrayList<>();
		//db 객체 생성 및 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//teacher 쿼리
		String sql = "SELECT t.teacher_no, t.teacher_id, t.teacher_name, "
				+ "		ts.subject_no, group_concat(s.subject_name SEPARATOR '/') AS allSubject "
				+ "FROM teacher t LEFT OUTER JOIN teacher_subject ts "
				+ "					ON t.teacher_no = ts.teacher_no "
				+ "						LEFT OUTER JOIN subject s "
				+ "						on ts.subject_no = s.subject_no "
				+ "GROUP BY t.teacher_no, t.teacher_id, t.teacher_name "
				+ "LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println("TeacherDao - SQL: " + sql);
		ResultSet rs = stmt.executeQuery();

		// teacher vo
		while (rs.next()) {
			HashMap<String, Object> ts = new HashMap<>();
			ts.put("teacherNo", rs.getInt("t.teacher_no"));
			ts.put("teacherId", rs.getString("t.teacher_id"));
			ts.put("teacherName", rs.getString("t.teacher_name"));
			ts.put("subjectNo", rs.getString("subject_no"));//concat으로 참조하는 모든 과목 번호를 알고싶다면, String 타입으로 변경.
			ts.put("allSubject", rs.getString("allSubject"));
			tsList.add(ts);	
		}
		return tsList;
	}
	//페이징 메소드
	public int selectTeacherSubjectListCnt() throws Exception {
		//count 쿼리
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String cntSql = "SELECT COUNT(*) FROM teacher";
		PreparedStatement cntStmt = conn.prepareStatement(cntSql);
		ResultSet cntRs = cntStmt.executeQuery();
		// 페이징 vo
		int totalRow = 0;
		if(cntRs.next()) {
			totalRow = cntRs.getInt("count(*)");
		}
		return totalRow;
	}
	
	
}
