# 데이터 베이스 생성
DROP DATABASE IF EXISTS lfcFan;
CREATE DATABASE lfcFan;
USE lfcFan;

# 게시물 테이블 생성
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(200) NOT NULL,
    `body` TEXT NOT NULL,
    reading INT(10) NOT NULL
);

# 게시물 데이터 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1',
reading=0;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2',
reading=0;

# 게시물 테이블 생성
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    loginId CHAR(20) NOT NULL,
    loginPw CHAR(100) NOT NULL,
    `name` CHAR(100) NOT NULL,
    email CHAR(100) NOT NULL
);

# 회원 생성
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'elwl44',
loginPw = '1234',
`name` = '박범규',
email='pbk11908@naver.com';

# 회원 생성
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'elwl45',
loginPw = '1234',
`name` = '박범규2',
email='parkbk1908@gmail.com';

# 게시물 테이블에 memberId 칼럼 추가
ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;
# 기존 게시물들의 작성자는 1번 회원으로 정한다.
UPDATE article SET memberId = 1 WHERE memberId = 0;

SELECT * FROM article;

# 게시물 데이터 추가
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3',
memberId = 2;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목4',
`body` = '내용4',
memberId = 2; 

# 댓글 테이블 생성
CREATE TABLE reply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `body` TEXT NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relId INT(10) UNSIGNED NOT NULL, # 관련 데이터 ID
    relTypeCode CHAR(50) NOT NULL # 관련 데이터 타입
);

SELECT * FROM reply; 

# 게시판 테이블 추가
CREATE TABLE board (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `name` CHAR(20) UNIQUE NOT NULL,
    `code` CHAR(20) UNIQUE NOT NULL
);

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = '공지사항',
`code` = 'notice';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = '자유',
`code` = 'free'; 

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = '축구',
`code` = 'soccer'; 

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = '뉴스',
`code` = 'news'; 

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = '선수소개',
`code` = 'player';
 
# 게시물 테이블에 boardId 칼럼 추가
ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER updateDate;
UPDATE article SET boardId = 1 WHERE id <= 2;
UPDATE article SET boardId = 2 WHERE id > 2;

# 부가정보테이블 
# 댓글 테이블 추가
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `relTypeCode` CHAR(20) NOT NULL,
    `relId` INT(10) UNSIGNED NOT NULL,
    `typeCode` CHAR(30) NOT NULL,
    `type2Code` CHAR(30) NOT NULL,
    `value` TEXT NOT NULL
);

# attr 유니크 인덱스 걸기
## 변수찾는 속도 최적화
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`); 

## 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `typeCode`, `type2Code`);

# attr에 만료날짜 추가
ALTER TABLE `attr` ADD COLUMN `expireDate` DATETIME NULL AFTER `value`;

# 기존 패스워드 암호화
UPDATE `member`
SET loginPw = SHA2(loginPw, 256);

# 기존 인덱스 삭제후 유니크로 변경, 왜냐하면 attr의 특정 조합은 유니크여야 하기 때문에
ALTER TABLE `attr` DROP INDEX relTypeCode;
ALTER TABLE `attr` ADD UNIQUE INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`);  

# 이메일 본인인증쿼리
INSERT INTO attr (regDate, updateDate, `relTypeCode`,
		`relId`, `typeCode`, `type2Code`, `value`, expireDate)
		VALUES (NOW(),
		NOW(), 'member', 1, 'extra', 'emailAuthCode', 'c1136e1f-1fbf-4acc-9393-eea1bb5fdb7c',
		NULL)
		ON DUPLICATE KEY UPDATE
		updateDate = NOW() , `value` =
		'c1136e1f-1fbf-4acc-9393-eea1bb5fdb7c', expireDate = NULL;

INSERT INTO attr (regDate, updateDate, `relTypeCode`,
		`relId`, `typeCode`, `type2Code`, `value`, expireDate)
		VALUES (NOW(),
		NOW(), 'member', 1, 'extra', 'authedEmail', 'pbk11908@naver.com',
		NULL)
		ON DUPLICATE KEY UPDATE
		updateDate = NOW() , `value` =
		'pbk11908@naver.com', expireDate = NULL;

# 파일 테이블 추가
CREATE TABLE genFile (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, # 번호
  regDate DATETIME DEFAULT NULL, # 작성날짜
  updateDate DATETIME DEFAULT NULL, # 갱신날짜
  delDate DATETIME DEFAULT NULL, # 삭제날짜
  delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0, # 삭제상태(0:미삭제,1:삭제)
  relTypeCode CHAR(50) NOT NULL, # 관련 데이터 타입(article, member)
  relId INT(10) UNSIGNED NOT NULL, # 관련 데이터 번호
  originFileName VARCHAR(100) NOT NULL, # 업로드 당시의 파일이름
  fileExt CHAR(10) NOT NULL, # 확장자
  typeCode CHAR(20) NOT NULL, # 종류코드 (common)
  type2Code CHAR(20) NOT NULL, # 종류2코드 (attatchment)
  fileSize INT(10) UNSIGNED NOT NULL, # 파일의 사이즈
  fileExtTypeCode CHAR(10) NOT NULL, # 파일규격코드(img, video)
  fileExtType2Code CHAR(10) NOT NULL, # 파일규격2코드(jpg, mp4)
  fileNo SMALLINT(2) UNSIGNED NOT NULL, # 파일번호 (1)
  fileDir CHAR(20) NOT NULL, # 파일이 저장되는 폴더명
  PRIMARY KEY (id),
  KEY relId (relId,relTypeCode,typeCode,type2Code,fileNo)
);

#선수 테이블 추가
CREATE TABLE player (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    firstName CHAR(30) NOT NULL,
    lastName CHAR(30) NOT NULL,
    backNumber INT(10) NOT NULL,
    POSITION CHAR(20) NOT NULL,
    nationality CHAR(30) NOT NULL,
    height INT(10) NOT NULL,
    weight INT(10) NOT NULL,
    dateofBirth CHAR(10) NOT NULL
);