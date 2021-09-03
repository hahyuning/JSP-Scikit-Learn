package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MemberDAO {
	Connection con;
	DBConnectionMgr mgr;
	
	public MemberDAO() {
		mgr = DBConnectionMgr.getInstance();			
	}
	
	public int idOver(MemberDTO dto) {
		int result = 0;
		try {
			con = mgr.getConnection();
			String sql = "select * from member1 where id = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getId());

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				result = 1;
			}
			mgr.freeConnection(con, ps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public void insert(MemberDTO dto) {
		try {
			con = mgr.getConnection();
			String sql = "insert into member1 values (?, ?, '', ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getId());
			ps.setString(2, dto.getPw());
			ps.setInt(3, dto.getMembership());

			ps.executeUpdate();
			
			con.close();
			ps.close();
			mgr.freeConnection(con, ps);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int login(MemberDTO dto) {
		int result = 0;
		try {
			con = mgr.getConnection();
			String sql = "select * from member1 where id = ? and pw = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getId());
			ps.setString(2, dto.getPw());

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				result = 1;
			}
			mgr.freeConnection(con, ps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public ArrayList<Object> acccount(MemberDTO dto) {
		ArrayList<Object> list = null;
		try {
			con = mgr.getConnection();
			String sql = "select account, membership from member1 where id = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getId());

			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				list = new ArrayList<Object>();
				list.add(rs.getString(1));
				list.add(rs.getInt(2));
			}
			mgr.freeConnection(con, ps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public int update(MemberDTO dto) {
		int result = 0;
		try {
			con = mgr.getConnection();
			String sql = "update member1 set account = ? where id = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getAccount());
			ps.setString(2, dto.getId());

			result = ps.executeUpdate();
			
			
			con.close();
			ps.close();
			mgr.freeConnection(con, ps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
