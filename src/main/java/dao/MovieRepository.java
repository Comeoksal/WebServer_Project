package dao;

import java.util.ArrayList;
import dto.Movie;

public class MovieRepository{
	
	private ArrayList<Movie> listOfMovies = new ArrayList<Movie>();
	
	public MovieRepository() {
		Movie movie1 = new Movie(1, "어벤져스", "영웅들이 모여서 싸우는 영화", 3000);
		Movie movie2 = new Movie(2, "라라랜드", "남녀가 만나는 로맨스 영화", 2000);
		Movie movie3 = new Movie(3, "타짜", "도박꾼들의 영화", 1500);
		
		listOfMovies.add(movie1);
		listOfMovies.add(movie2);
		listOfMovies.add(movie3);
	}
	
	public ArrayList<Movie> getAllMovies(){
		return listOfMovies;
	}
}