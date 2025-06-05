USE movit;

CREATE TABLE IF NOT EXISTS movie (
    id INT AUTO_INCREMENT PRIMARY KEY,               -- 영화 ID
    title VARCHAR(255) NOT NULL,                     -- 영화 제목
    content TEXT NOT NULL,                           -- 영화 내용설명
    price INT NOT NULL,                              -- 영화 가격
    score DOUBLE DEFAULT 0.0,                        -- 영화 평점
    image varchar(255) NOT NULL,					 -- 영화 포스터 사진
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,   -- 생성 시각
    modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  -- 수정 시각
)DEFAULT CHARSET=utf8;
