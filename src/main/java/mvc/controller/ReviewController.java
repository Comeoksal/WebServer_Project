package mvc.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import mvc.model.ReviewDAO;
import mvc.model.ReviewDTO;

public class ReviewController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 10;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());

		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");

		if (command.equals("/Review.do")) {
			requestReviewList(request);
			RequestDispatcher rd = request.getRequestDispatcher("/review/community.jsp");
			rd.forward(request, response);
		} else if (command.equals("/ReviewWriteForm.do")) {
			RequestDispatcher rd = request.getRequestDispatcher("./review/review.jsp");
			rd.forward(request, response);
		} else if (command.equals("/ReviewWriteAction.do")) {
			requestReviewWrite(request);
			response.sendRedirect("Review.do");
		} else if (command.equals("/ReviewLikeToggle.do")) {
			requestToggleLike(request, response);
			String referer = request.getHeader("Referer");
			response.sendRedirect(referer != null ? referer : "Review.do");
		}
	}

	public void requestReviewList(HttpServletRequest request) {
		ReviewDAO dao = ReviewDAO.getInstance();

		String keyword = request.getParameter("query");
		if (keyword == null) keyword = "";

		String sort = request.getParameter("sort");
		if (sort == null) sort = "recent";

		ArrayList<ReviewDTO> reviewList = dao.getReviewList(keyword, sort);
		request.setAttribute("reviewList", reviewList);
	}

	public void requestReviewWrite(HttpServletRequest request) {
		ReviewDAO dao = ReviewDAO.getInstance();
		ReviewDTO review = new ReviewDTO();

		review.setContent(request.getParameter("content"));
		review.setScore(Float.parseFloat(request.getParameter("score")));
		review.setUserId(Long.parseLong(request.getParameter("user_id")));
		review.setMovieId(Long.parseLong(request.getParameter("movie_id")));

		Timestamp now = new Timestamp(System.currentTimeMillis());
		review.setCreatedAt(now);
		review.setModifiedAt(now);

		dao.insertReview(review);
	}

	public void requestToggleLike(HttpServletRequest request, HttpServletResponse response) throws IOException{
		long userId = Long.parseLong(request.getParameter("user_id"));
		long reviewId = Long.parseLong(request.getParameter("review_id"));
		
		ReviewDAO dao = ReviewDAO.getInstance();
		dao.toggleLike(userId, reviewId);
	}
}