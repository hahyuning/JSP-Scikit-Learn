package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class MovieDAO {
	Connection con;
	DBConnectionMgr mgr;
	public MovieDAO() {
		 mgr = DBConnectionMgr.getInstance();
	}
	
	//4.검색을 할 예정. 
	public ArrayList<MovieDTO2> list() {
		ArrayList<MovieDTO2> list = new ArrayList<>();
		MovieDTO2 dto2 =null;
		try {
			con = mgr.getConnection();
			String sql = "select * from movie";
			PreparedStatement ps = con.prepareStatement(sql);
			
			//4) sql문 전송
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) { //검색 결과가 있는지 체크해주는 메서드
				dto2 = new MovieDTO2();
				String movie_name = rs.getString(3);
				String director = rs.getString(4);
				String genre = rs.getString(10);
				String url = rs.getString(12);
				String movie_content = rs.getString(13);
				dto2.setMovie_name(movie_name);
				dto2.setPd(director);;
				dto2.setGenre(genre);
				dto2.setUrl(url);
				dto2.setMovie_content(movie_content);
				list.add(dto2);
			}
			mgr.freeConnection(con, ps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public ArrayList<MovieDTO2> select(MovieDTO2 dto) {
		ArrayList<MovieDTO2> list = new ArrayList<>();
		MovieDTO2 dto2 = null;			
		try {
			con = mgr.getConnection();
			//3) sql문 결정
			String sql = "select * from movie where genre = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getMovie_name());
			ps.setString(2, dto.getGenre());
			ps.setString(3, dto.getUrl());
			
			//4) sql문 전송
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) { //검색 결과가 있는지 체크해주는 메서드
				dto2 = new MovieDTO2();
				String movie_name = rs.getString(1);
				String genre = rs.getString(2);
				String url = rs.getString(3);
				dto2.setMovie_name(movie_name);
				dto2.setGenre(genre);
				dto2.setUrl(url);
				list.add(dto2);
			}
			mgr.freeConnection(con, ps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	
	
	 public void updateUnlike(AccountDTO dto) {
	      MovieDAO dao = new MovieDAO();
	      AccountDTO dto2 = dao.selectPlay(dto); 	//id =a 와 account1 =b 인 row값 호출
	      try {
	         con = mgr.getConnection();

	         // 3) sql문 결정

	         String sql = "update account1 set unlike = ? where id =? and account = ?";
	         PreparedStatement ps = con.prepareStatement(sql);
	         if (dto2.getUnlike()==null) {
	        	 ps.setString(1, dto.getUnlike());
	        	 ps.setString(2, dto.getId());
	        	 ps.setString(3, dto.getAccount());
	        	 ps.executeUpdate();
			}else {
				 ps.setString(1, dto2.getUnlike() + "," + dto.getUnlike());
	        	 ps.setString(2, dto.getId());
	        	 ps.setString(3, dto.getAccount());
	        	 ps.executeUpdate();
			}

	         // 4) sql문 전송
	         System.out.println("4. sql문 전송 ok..");
	         mgr.freeConnection(con, ps);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }
	 	
	 public void updatemlike(AccountDTO dto) {
	      MovieDAO dao = new MovieDAO();
	      AccountDTO dto2 = dao.selectPlay(dto); 	//id =a 와 account_name =b 인 row값 호출
	      try {
	         con = mgr.getConnection();

	         // 3) sql문 결정

	         String sql = "update account1 set mlike = ? where id =? and account = ?";
	         PreparedStatement ps = con.prepareStatement(sql);
	         if (dto2.getMlike()==null) {
	        	 ps.setString(1, dto.getMlike());
		         ps.setString(2, dto.getId());
		         ps.setString(3, dto.getAccount());
		         ps.executeUpdate();
			}else {
	         ps.setString(1, dto2.getMlike() + "," + dto.getMlike());
	         ps.setString(2, dto.getId());
	         ps.setString(3, dto.getAccount());
	         ps.executeUpdate();
			}

	        
	         mgr.freeConnection(con, ps);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }
	 public void updatePlay(AccountDTO dto) {
	      MovieDAO dao = new MovieDAO();
	      AccountDTO dto2 = dao.selectPlay(dto); 	//id =a 와 account1 =b 인 row값 호출
	      try {
	         con = mgr.getConnection();

	         // 3) sql문 결정

	         String sql = "update account1 set play = ? where id =? and account = ?";
	         PreparedStatement ps = con.prepareStatement(sql);
	         if (dto2.getPlay()==null) {
	        	 ps.setString(1, dto.getPlay());
	        	 ps.setString(2, dto.getId());
	        	 ps.setString(3, dto.getAccount());
	        	 ps.executeUpdate();
			}else {
				ps.setString(1, dto2.getPlay() + "," + dto.getPlay());
	        	 ps.setString(2, dto.getId());
	        	 ps.setString(3, dto.getAccount());
	        	 ps.executeUpdate();
			}

	         // 4) sql문 전송
	         System.out.println("4. sql문 전송 ok..");
	         mgr.freeConnection(con, ps);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }

	   // play 만 return select문

	   public AccountDTO selectPlay(AccountDTO dto) {
	      AccountDTO dto2 = null;

	      try {
	         con = mgr.getConnection();

	         // 3) sql문 결정
	         String sql = "select * from account1 where id=? and account =?";
	         PreparedStatement ps = con.prepareStatement(sql);
	         
	         ps.setString(1, dto.getId());
	         ps.setString(2, dto.getAccount());
	         System.out.println("3. sql문 결정 ok..");

	         // 4) sql문 전송
	         ResultSet rs = ps.executeQuery();
	         System.out.println("4. sql문 전송 ok..");

	         if (rs.next()) { // 검색 결과가 있는지 체크해주는 메서드
	            System.out.println("검색 결과가 있어요.!!");
	            dto2 = new AccountDTO();
	            String id = rs.getString(1);
	            String account_name = rs.getString(2);
	            String like = rs.getString(3);
	            String play = rs.getString(4);
	            String unlike = rs.getString(5);
	            
	            dto2.setId(id);
	            dto2.setAccount(account_name);
	            dto2.setMlike(like);
	            dto2.setPlay(play);
	            dto2.setUnlike(unlike);
	         }
	         mgr.freeConnection(con,ps);

	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return dto2;
	   }
	
	
}
