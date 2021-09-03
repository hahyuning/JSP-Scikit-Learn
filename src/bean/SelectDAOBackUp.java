package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils.Collections;

public class SelectDAO {
		Connection con;
		DBConnectionMgr mgr;
		
		public SelectDAO() {
			mgr = DBConnectionMgr.getInstance();
		}

//0. 뭐지 이건

	public ArrayList<SelectDTO> accountMovie(String account) { // dto Id입력
		ArrayList<SelectDTO> list = new ArrayList<>(); // 1. 객체랑 타입 선언
		SelectDTO dto2 = null;

		try {
			con = mgr.getConnection();

			// 3) sql문 결정
			String sql = "select * from account where account_name = ?"; // where account_name ? ;
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, account);
			// ps.setString(
			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ResultSet rs = ps.executeQuery();
			System.out.println("4. sql문 전송 ok..");

			while (rs.next()) { // 검색 결과가 있는지 체크해주는 메서드
				System.out.println("검색 결과가 있어요.!!");
				dto2 = new SelectDTO();
				String id = rs.getString(1);
				String AccountName = rs.getString(2);
				String like = rs.getString(3);
				String play = rs.getString(4);
				String unlike = rs.getString(5);
				dto2.setId(id);
				dto2.setAccount_name(AccountName);
				dto2.setLike(like);
				dto2.setPlay(play);
				dto2.setUnlike(unlike);
				list.add(dto2);
			}
			mgr.freeConnection(con, ps);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 1. list 객체 반환
	}

//1. 계정 별 영화 목록 반환 -> play split으로 영화제목 반환 **쓰고있음

	public String[] myMovie(String account) { // dto Id입력
		String[] bag = null;
		try {
			con = mgr.getConnection();

			// 3) sql문 결정
			String sql = "select play from account where account_name = ?"; // where account_name ? ;
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, account);
			// ps.setString(
			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ResultSet rs = ps.executeQuery();
			System.out.println("4. sql문 전송 ok..");

			if (rs.next()) { // 검색 결과가 있는지 체크해주는 메서드
				String play = rs.getString(1);
				bag = play.split(",");
			}
			mgr.freeConnection(con, ps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bag; // 1. list 객체 반환
	}

//2. url 반환 dao

	public String returnUrl(String aDto) { // adto = 영화제목 입력 -> url 반환
		String returnUrl = null;
		try {
			con = mgr.getConnection();
			
			// 3) sql문 결정
			String sql = "select url from movie where movie_name = ?"; // 제목에 따라 url 반환
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, aDto);
			// ps.setString(
			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ResultSet rs = ps.executeQuery();
			System.out.println("4. sql문 전송 ok..");

			if (rs.next()) { // 검색 결과가 있는지 체크해주는 메서드
				returnUrl = rs.getString(1);

			}
			mgr.freeConnection(con, ps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnUrl; // 1. list 객체 반환
	}

	// 3. 장르 추천 DAO

	public ArrayList<MovieDTO> recomGenre(String mName) { // dto Id입력
		ArrayList<MovieDTO> list = new ArrayList<>(); // 1. 객체랑 타입 선언
		MovieDTO dto2 = null;

		try {
			con = mgr.getConnection();

			// 3) sql문 결정
			String sql = "select movie_name, genre, url from movie where genre in (select genre from movie where movie_name = ? ) order by rand() limit 13"; // where
																																					// account_name
																																					// ?
																																					// ;
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, mName);
			// ps.setString(
			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ResultSet rs = ps.executeQuery();
			System.out.println("4. sql문 전송 ok..");

			while (rs.next()) { // 검색 결과가 있는지 체크해주는 메서드
				System.out.println("검색 결과가 있어요.!!");
				dto2 = new MovieDTO();
				String movieName = rs.getString(1);
				String genre = rs.getString(2);
				String url = rs.getString(3);
				dto2.setMovie_name(movieName);
				dto2.setGenre(genre);
				dto2.setUrl(url);

				list.add(dto2);
			}
			mgr.freeConnection(con, ps);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list; // 1. list 객체 반환
	}

//4. 계정 영화 ArrayList 배열 

	public ArrayList<SelectDTO> list() { // dto Id입력
		ArrayList<SelectDTO> list = new ArrayList<>(); // 1. 객체랑 타입 선언
		SelectDTO dto2 = null;

		try {
			con = mgr.getConnection();

			// 3) sql문 결정
			String sql = "select * from account"; // where account_name ? ;
			PreparedStatement ps = con.prepareStatement(sql);
			// ps.setString(
			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ResultSet rs = ps.executeQuery();
			System.out.println("4. sql문 전송 ok..");

			while (rs.next()) { // 검색 결과가 있는지 체크해주는 메서드
				System.out.println("검색 결과가 있어요.!!");
				dto2 = new SelectDTO();
				String id = rs.getString(1);
				String AccountName = rs.getString(2);
				String like = rs.getString(3);
				String play = rs.getString(4);
				String unlike = rs.getString(5);
				dto2.setId(id);
				dto2.setAccount_name(AccountName);
				dto2.setLike(like);
				dto2.setPlay(play);
				dto2.setUnlike(unlike);
				list.add(dto2);
			}
			mgr.freeConnection(con, ps);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 1. list 객체 반환
	}

//1. 처음 회원가입시 영화 업데이트
	
	public void firstInsertMovie(SelectDTO dto) {
		// 매개변수(파라메터, parameter), 지역변수
		System.out.println("회원가입 처리하다.");
		try {
			con = mgr.getConnection();

			// 3) sql문 결정

			String sql = "update account set play = ? where account_name = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getPlay());
			ps.setString(2, dto.getAccount_name());

			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ps.executeUpdate();
			System.out.println("4. sql문 전송 ok..");

			mgr.freeConnection(con,ps);
	
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
//-------------

//-- 테스트 해볼려헀던 것 -> Insert 문

	public void insert(SelectDTO dto) {
		// 매개변수(파라메터, parameter), 지역변수
		System.out.println("회원가입 처리하다.");
		try {
			con = mgr.getConnection();

			// 3) sql문 결정

			String sql = "insert into chosun values (?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getId());
			ps.setString(2, dto.getAccount_name());
			ps.setString(3, dto.getLike());
			ps.setString(4, dto.getPlay());
			ps.setString(5, dto.getUnlike());

			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ps.executeUpdate();
			System.out.println("4. sql문 전송 ok..");

			mgr.freeConnection(con,ps);
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

//테스트 : 영화 선택 후 업데이트 할려했음

	public void update(SelectDTO dto) {
		System.out.println("회원수정 처리하다.");
		SelectDAO dao = new SelectDAO();
		SelectDTO dto2 = dao.selectPlay(dto);
		
		try {
			con = mgr.getConnection();

			// 3) sql문 결정

			String sql = "update account set play = ? where account_name = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto2.getPlay() + "," + dto.getPlay());
			ps.setString(2, dto.getAccount_name());

			// 4) sql문 전송
			ps.executeUpdate();
			System.out.println("4. sql문 전송 ok..");
			mgr.freeConnection(con, ps);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// play 만 return select문

	public SelectDTO selectPlay(SelectDTO dto) {
		SelectDTO dto2 = null;

		try {
			con = mgr.getConnection();

			// 3) sql문 결정
			String sql = "select * from account where account_name = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getAccount_name());
			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ResultSet rs = ps.executeQuery();
			System.out.println("4. sql문 전송 ok..");

			if (rs.next()) { // 검색 결과가 있는지 체크해주는 메서드
				System.out.println("검색 결과가 있어요.!!");
				dto2 = new SelectDTO();
				String id = rs.getString(1);
				String accountName = rs.getString(2);
				String like = rs.getString(3);
				String play = rs.getString(4);
				String unLike = rs.getString(5);
				dto2.setId(id);
				dto2.setAccount_name(accountName);
				dto2.setLike(like);
				dto2.setPlay(play);
				dto2.setUnlike(unLike);
			}
			mgr.freeConnection(con,ps);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto2;
	}

	// 0. ArrayList 배열 영화반환

	public ArrayList<MovieDTO> MovieList() { // 1. 리턴타입 지정, 괄호안은 입력값
		ArrayList<MovieDTO> MovieList = new ArrayList<>(); // 1. 객체랑 타입 선언
		MovieDTO dto2 = null;

		try {
			con = mgr.getConnection();
			// 3) sql문 결정
			String sql = "select * from movie ";
			PreparedStatement ps = con.prepareStatement(sql);
			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ResultSet rs = ps.executeQuery();
			System.out.println("4. sql문 전송 ok..");

			while (rs.next()) { // 검색 결과가 있는지 체크해주는 메서드
				System.out.println("검색 결과가 있어요.!!");
				dto2 = new MovieDTO();
				String number = rs.getString(1);
				String id = rs.getString(2);
				String movie_name = rs.getString(3);
				String director = rs.getString(4);
				String release_date = rs.getString(5);
				String type = rs.getString(6);
				String country = rs.getString(7);
				String sales = rs.getString(8);
				String view = rs.getString(9);
				String genre = rs.getString(10);
				String grade = rs.getString(11);
				String url = rs.getString(12);

				dto2.setNumber(number);
				dto2.setId(id);
				dto2.setMovie_name(movie_name);
				dto2.setDirector(director);
				dto2.setRelease_date(release_date);
				dto2.setType(type);
				dto2.setCountry(country);
				dto2.setSales(sales);
				dto2.setView(view);
				dto2.setGenre(genre);
				dto2.setGrade(grade);
				dto2.setUrl(url);
				MovieList.add(dto2);
			}
			mgr.freeConnection(con,ps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return MovieList; // 1. list 객체 반환
	}

	// 1. insert movie DAO -> 처음 가입시 영화 인서트됨

	public void insertM(SelectDTO dto) {
		// 매개변수(파라메터, parameter), 지역변수
		System.out.println("회원가입 처리하다.");
		try {
			con = mgr.getConnection();

			// 3) sql문 결정

			String sql = "insert into account values (?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getId());
			ps.setString(2, dto.getAccount_name());
			ps.setString(3, dto.getLike());
			ps.setString(4, dto.getPlay());
			ps.setString(5, dto.getUnlike());

			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ps.executeUpdate();
			System.out.println("4. sql문 전송 ok..");
			mgr.freeConnection(con,ps);
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

//account session 값 반환하는 dao 

	public SelectDTO selectAccount(SelectDTO dto) {
		SelectDTO dto2 = null;

		try {
			con = mgr.getConnection();

			// 3) sql문 결정
			String sql = "select * from account where account_name = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			// ps.setString(1, dto.getId());
			ps.setString(1, dto.getAccount_name());
			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ResultSet rs = ps.executeQuery();
			System.out.println("4. sql문 전송 ok..");

			if (rs.next()) { // 검색 결과가 있는지 체크해주는 메서드
				System.out.println("검색 결과가 있어요.!!");
				dto2 = new SelectDTO();
				String id = rs.getString(1);
				String accountName = rs.getString(2);
				String like = rs.getString(3);
				String play = rs.getString(4);
				String unLike = rs.getString(5);
				dto2.setId(id);
				dto2.setAccount_name(accountName);
				dto2.setLike(like);
				dto2.setPlay(play);
				dto2.setUnlike(unLike);
			}
			mgr.freeConnection(con,ps);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto2;
	}

//new coming만 반환

	public ArrayList<MovieDTO> newComing() { // dto Id입력
		ArrayList<MovieDTO> dto2 = new ArrayList<>();
		MovieDTO dto = null;

		try {
			con = mgr.getConnection();

			// 3) sql문 결정
			String sql = "select movie_name, url, release_date from movie order by release_date desc limit 30"; // where
																												// account_name
																												// ? ;
			PreparedStatement ps = con.prepareStatement(sql);
			// ps.setString(
			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ResultSet rs = ps.executeQuery();
			System.out.println("4. sql문 전송 ok..");

			while (rs.next()) {
				System.out.println("검색 결과가 있어요.!!");
				dto = new MovieDTO();
				String movie_name = rs.getString(1);
				String url = rs.getString(2);
				String release_date = rs.getString(3);
				dto.setMovie_name(movie_name);
				dto.setUrl(url);
				dto.setRelease_date(release_date);
				dto2.add(dto);
			}
			mgr.freeConnection(con,ps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto2; // 1. list 객체 반환
	}


	public String checkAccount(String account) {
		String dto2 = null;

		try {
			con = mgr.getConnection();

			// 3) sql문 결정
			String sql = "select play from account where account_name = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, account);
			System.out.println("3. sql문 결정 ok..");

			// 4) sql문 전송
			ResultSet rs = ps.executeQuery();
			System.out.println("4. sql문 전송 ok..");

			if (rs.next()) { // 검색 결과가 있는지 체크해주는 메서드
				System.out.println("검색 결과가 있어요.!!");
				String play = rs.getString(1);
				dto2 = play;
			}
			mgr.freeConnection(con, ps);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto2;
	}
}