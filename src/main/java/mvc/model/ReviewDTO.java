package mvc.model;

import java.sql.Timestamp;

public class ReviewDTO {
	private long id;
	private String content;
	private float score;
	private Timestamp createdAt;
	private Timestamp modifiedAt;
	private long userId;
	private long movieId;
	private int likes;
	private String title;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public ReviewDTO() {
		super();
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public float getScore() {
		return score;
	}
	public void setScore(float score) {
		this.score = score;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getModifiedAt() {
		return modifiedAt;
	}
	public void setModifiedAt(Timestamp modifiedAt) {
		this.modifiedAt = modifiedAt;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public long getMovieId() {
		return movieId;
	}
	public void setMovieId(long movieId) {
		this.movieId = movieId;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	
}
