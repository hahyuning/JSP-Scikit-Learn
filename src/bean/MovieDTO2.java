package bean;

public class MovieDTO2 {
private int rank;
private String movie_name;
private String pd;
private String genre;
private String url;
private String movie_content; 

public String getMovie_content() {
	return movie_content;
}
public void setMovie_content(String movie_content) {
	this.movie_content = movie_content;
}
public int getRank() {
	return rank;
}
public void setRank(int rank) {
	this.rank = rank;
}
public String getMovie_name() {
	return movie_name;
}
public void setMovie_name(String movie_name) {
	this.movie_name = movie_name;
}
public String getPd() {
	return pd;
}
public void setPd(String pd) {
	this.pd = pd;
}
public String getGenre() {
	return genre;
}
public void setGenre(String genre) {
	this.genre = genre;
}
public String getUrl() {
	return url;
}
public void setUrl(String url) {
	this.url = url;
}
@Override
public String toString() {
	return "MovieDTO [rank=" + rank + ", movie_name=" + movie_name + ", pd=" + pd + ", genre=" + genre + ", url=" + url
			+ "]";
}

}
