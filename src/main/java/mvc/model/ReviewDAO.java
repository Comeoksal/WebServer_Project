package mvc.model;

import java.sql.*;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReviewDAO {

    private static ReviewDAO instance;

    private ReviewDAO() {}

    public static ReviewDAO getInstance() {
        if (instance == null) {
            instance = new ReviewDAO();
        }
        return instance;
    }

    private Connection getConnection() throws Exception {
        Context initContext = new InitialContext();
        Context envContext = (Context) initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource) envContext.lookup("jdbc/MovitDB");
        return ds.getConnection();
    }

    public ArrayList<ReviewDTO> getReviewList(String keyword, String sort) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<ReviewDTO> list = new ArrayList<>();

        String orderBy;
        switch (sort) {
            case "popular": orderBy = "like_count DESC"; break;
            case "oldest": orderBy = "r.created_at ASC"; break;
            default: orderBy = "r.created_at DESC"; break;
        }

        String sql =
            "select r.id, r.content, r.score, r.created_at, r.modified_at, r.user_id, " +
            "r.movie_id, m.title as movie_title, COUNT(l.id) as like_count " +
            "from review r " +
            "join movie m on r.movie_id = m.id " +
            "left join like_review l on r.id = l.review_id " +
            "where m.title like ? " +
            "group by r.id, r.content, r.score, r.created_at, r.modified_at, r.user_id, r.movie_id, m.title " +
            "order by " + orderBy + " limit 50";

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setId(rs.getLong("id"));
                review.setContent(rs.getString("content"));
                review.setScore(rs.getFloat("score"));
                review.setCreatedAt(rs.getTimestamp("created_at"));
                review.setModifiedAt(rs.getTimestamp("modified_at"));
                review.setUserId(rs.getLong("user_id"));
                review.setMovieId(rs.getLong("movie_id"));
                review.setLikes(rs.getInt("like_count"));
                review.setTitle(rs.getString("movie_title"));
                list.add(review);
            }
        } catch (Exception ex) {
            System.out.println("getReviewLis 예외: " + ex);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
        return list;
    }

    public void insertReview(ReviewDTO review) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();
            String sql = "insert into review (content, score, created_at, modified_at, user_id, movie_id) values (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, review.getContent());
            pstmt.setFloat(2, review.getScore());
            pstmt.setTimestamp(3, review.getCreatedAt());
            pstmt.setTimestamp(4, review.getModifiedAt());
            pstmt.setLong(5, review.getUserId());
            pstmt.setLong(6, review.getMovieId());
            pstmt.executeUpdate();

            pstmt.close();

            String updateSql = "update movie set score = (select AVG(score) from review where movie_id = ?) where id = ?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setLong(1, review.getMovieId());
            pstmt.setLong(2, review.getMovieId());
            pstmt.executeUpdate();
        } catch (Exception ex) {
            System.out.println("insertReview 예외: " + ex);
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
    }

    public void toggleLike(long userId, long reviewId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();

            String checkSql = "select COUNT(*) from like_review where user_id = ? and review_id = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setLong(1, userId);
            pstmt.setLong(2, reviewId);
            rs = pstmt.executeQuery();

            boolean hasLiked = false;
            if (rs.next()) {
                hasLiked = rs.getInt(1) > 0;
            }
            rs.close();
            pstmt.close();

            if (hasLiked) {
                String deleteSql = "delete from like_review where user_id = ? and review_id = ?";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setLong(1, userId);
                pstmt.setLong(2, reviewId);
                pstmt.executeUpdate();
            } else {
                String insertSql = "insert into like_review (user_id, review_id) values (?, ?)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setLong(1, userId);
                pstmt.setLong(2, reviewId);
                pstmt.executeUpdate();
            }
        } catch (Exception ex) {
            System.out.println("toggleLike 예외: " + ex);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
    }
}