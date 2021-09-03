package project;

public class NaverMovie {

	static String input;

	public static void main(String[] args) {
			File file = new File("C:\Users\crawl.text");
		try {
			input = "기생충";
			Connection naverMovie = Jsoup.connect("https://movie.naver.com/movie/search/result.nhn?query=" + input + "&section=all&ie=utf8"); // 웹사이트 연결
			Document movie = naverMovie.get(); // 웹사이트 정보 등록 -> meltitle 에 입력
			Elements nsection = movie.select(".search_list_1 "); // 노래 디렉토리 크롤링-> mellist 입력
			Elements test1 = movie.select("img"); // 노래 디렉토리 크롤링-> mellist 입력
			String test2 = test1.get(3).attr("src");
			System.out.println(nsection);
			System.out.println("--------------");
			System.out.println(test1);
			System.out.println(test2); //이거 반환 하면됨
			
			FileWriter fw = new FileWriter(file, true);
			fw.write(test2);
			fw.close();
		}
		catch (Exception o) { //
			o.printStackTrace();
		}
	}
}

// 배열입력값 받게 하고
// dao select -> 
