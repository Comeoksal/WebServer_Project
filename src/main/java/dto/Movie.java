package dto;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Movie implements Serializable{
	
	private static final long serialVersionUID = -424700572038677000L;
	
	private int movieId; 	//영화 아이디
	private String title;		//영화 제목
	private String content;		//영화 내용설명
	private int price;			//영화 가격
	private double score;		//영화 평점
	private LocalDateTime created_at;	//추가 시기
	private LocalDateTime modified_at; //수정 시기
	
	public Movie() {
		super();
	}
	
	public Movie(int movieId, String title, String content, int price) {
		this.movieId = movieId;
		this.title = title;
		this.content = content;
		this.price = price;
		this.score = 0.0;
		this.created_at = LocalDateTime.now();
		this.modified_at = LocalDateTime.now();
	}
}