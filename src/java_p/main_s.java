 
package java_p;
 
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
 
public class main_s {
    public static StringBuilder sb;//
 
    public static void main(String[] args) {
        String clientId = "GTls0_4u16OES15kar4q";// 애플리케이션 클라이언트 아이디값";
        String clientSecret = "qwEr0ztyIY";// 애플리케이션 클라이언트 시크릿값";\
        int display = 2; // 검색결과갯수. 최대100개
        String movietext = null ;
        try {
            String text = URLEncoder.encode("아트메가128", "utf-8");
           
            //String apiURL = "https://openapi.naver.com/v1/search/movie.xml?query="";
            //String apiURL = "https://openapi.naver.com/v1/search/blog.json?query="text"&display=" + display + "&"; //원래 샘플
            // String apiURL = "https://openapi.naver.com/v1/search/blog.json?query="movieText"; //text 입력 받으면 되는거
            String apiURL = "https://openapi.naver.com/v1/search/movie.xml?query=&$@&*$&@!*$&*!$&//벤허//&display=10&start=1&target=movie";
            
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) { 
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { 
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            sb = new StringBuilder();
            String line;
 
            while ((line = br.readLine()) != null) {
                sb.append(line + "\n");
            }
            br.close();
            con.disconnect();
            System.out.println(sb);
        } catch (Exception e) {
            System.out.println(e);
        }
 
    }
}

