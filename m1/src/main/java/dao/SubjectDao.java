package dao;
import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.*;

public class SubjectDao {
	// 1) 과목목록 조회
	public ArrayList<Subject> selectSubjectListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Subject> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select subject_no, subject_name, subject_time, createdate, updatedate from subject ORDER BY subject_no limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println("subjectDao - SQL: " + sql);
		ResultSet rs = stmt.executeQuery();
		//vo타입으로 변경
		while(rs.next()){
			Subject s = new Subject();
			s.setSubjectNo(rs.getInt("subject_no"));
			s.setSubjectName(rs.getString("subject_name"));
			s.setSubjectTime(rs.getInt("subject_time"));
			s.setCreatedate(rs.getString("createdate"));
			s.setUpdatedate(rs.getString("updatedate"));
			list.add(s);
		}
		return list;
	}
	// 2) 과목추가
	public int insertSubject(Subject subject) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String insertSql = "INSERT INTO subject(subject_name, subject_time, createdate, updatedate) values(?, ?, NOW(), NOW())";
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		insertStmt.setString(1, subject.getSubjectName());
		insertStmt.setInt(2, subject.getSubjectTime());
		int row = insertStmt.executeUpdate();
		System.out.println("subjectDao - insertSql: " + insertSql);
		return row;
	}
	// 3) 과목삭제
	public int deleteSubject(int subjectNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String deleteSql = "DELETE FROM subject WHERE subject_no = ?";
		PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
		deleteStmt.setInt(1, subjectNo);
		int row = deleteStmt.executeUpdate();
		System.out.println("subjectDao - deleteSql: " + deleteSql);
		return row;
	}
	// 4) 과목수정
	public int updateSubject(Subject subject) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String updateSql = "UPDATE subject SET subject_name=?, subject_time=?, updatedate=NOW()";
		PreparedStatement updateStmt = conn.prepareStatement(updateSql);
		updateStmt.setString(1, subject.getSubjectName());
		updateStmt.setInt(2, subject.getSubjectTime());
		int row = updateStmt.executeUpdate();
		return row;
	}
	
	// 5) 과목 하나 상세 조회
	public Subject selectSubjectOne(int subjectNo) throws Exception {
		Subject subject = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String oneSql = "select subject_no, subject_name, subject_time, createdate, updatedate from subject where subject_no = ?";
		PreparedStatement oneStmt = conn.prepareStatement(oneSql);
		oneStmt.setInt(1, subjectNo);
		ResultSet oneRs = oneStmt.executeQuery();
		if(oneRs.next()){
			subject = new Subject();
			subject.setSubjectNo(oneRs.getInt("subject_no"));
			subject.setSubjectName(oneRs.getString("subject_name"));
			subject.setSubjectTime(oneRs.getInt("subject_time"));
			subject.setCreatedate(oneRs.getString("createdate"));
			subject.setUpdatedate(oneRs.getString("updatedate"));
		}
		return subject;
	}
	// 6) 과목전체row 페이징
	public int selectSubjectCnt() throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String cntSql = "SELECT count(*) count FROM subject";
		PreparedStatement cntStmt = conn.prepareStatement(cntSql);
		ResultSet cntRs = cntStmt.executeQuery();
		// count 값을 vo타입으로 변환
		if(cntRs.next()) {
			row = cntRs.getInt("count");
		}
		return row;
	}
}
