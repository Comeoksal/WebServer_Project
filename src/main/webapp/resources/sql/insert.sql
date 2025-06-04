USE movit;

INSERT INTO movie (id, title, content, price, score, filename, created_at, modified_at)
VALUES 
(1, '어벤져스', '영웅들이 모여서 싸우는 영화', 3000, 0.0, 'avengers.png', NOW(), NOW()),
(2, '라라랜드', '남녀가 만나는 로맨스 영화', 2000, 0.0, 'rara.png', NOW(), NOW()),
(3, '타짜', '도박꾼들의 영화', 1500, 0.0, 'tazza.png', NOW(), NOW());
