<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<style>
.container {
    margin-top: 60px;
}

.clearfix {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;            
    padding: 0 15px;       
    justify-content: flex-start;
}

.movie-box {
    width: 200px;          
    flex-shrink: 0;        
}

.movie-card {
    position: relative;
    width: 100%;
    padding-bottom: 150%;
    overflow: hidden;
    border-radius: 10px;
    background-color: #111;
    border: 1px solid #444;
}

.movie-card img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>

    <title>마이리스트 목록</title>
</head>
<body>
<%@ include file="../header.jsp"%>

<div class="container">
    <%@ include file="../dbconn.jsp" %>
    <div class="clearfix">
        <%
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String sql = "select * from movie";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
        %>
        <div class="movie-box">
            <div class="movie-card">
                <img src="<%=request.getContextPath()%>/resources/images/<%=rs.getString("filename")%>" alt="영화 포스터">
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
