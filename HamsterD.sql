DROP TABLE TB_COMMENT_LIKE;
DROP TABLE TB_IN_COMMENT;
DROP TABLE TB_COMMENT;
DROP TABLE TB_POST_LIKE;
DROP TABLE TB_POST;
DROP TABLE TB_PER_REV;
DROP TABLE TB_GROUP_REV;
DROP TABLE TB_SCHEDULE;
DROP TABLE TB_GROUP_COMMENT;
DROP TABLE TB_MEMBER;
DROP TABLE TB_STUDYGROUP;
DROP SEQUENCE SEQ_COMMENT_NO;
DROP SEQUENCE SEQ_COMMENT_LIKE_NO;
DROP SEQUENCE SEQ_GROUP_NO;
DROP SEQUENCE SEQ_GROUP_REV_NO;
DROP SEQUENCE SEQ_IN_COMMENT_NO;
DROP SEQUENCE SEQ_MEMBER_NO;
DROP SEQUENCE SEQ_POST_NO;
DROP SEQUENCE SEQ_PER_REV_NO;
DROP SEQUENCE SEQ_POST_LIKE;
DROP SEQUENCE SEQ_SCHEDULE_NO;
DROP SEQUENCE SEQ_GROUP_COMMENT_NO;


CREATE TABLE TB_MEMBER ( --멤버 테이블 생성
  MEMBER_NO NUMBER, 
  GROUP_NO NUMBER, --스터디 그룹 조인
  ID VARCHAR2(50) NOT NULL UNIQUE,
  PASSWORD VARCHAR2(200) NOT NULL,
  NAME VARCHAR2(50) NOT NULL,
  BIRTH DATE NOT NULL,
  GENDER VARCHAR2(10) NOT NULL,
  PHONE VARCHAR2(50) NOT NULL,
  ADDR VARCHAR2(1000) NOT NULL,
  ACADEMY_NAME VARCHAR2(50) NOT NULL,
  WEIGHT NUMBER DEFAULT 0,
  AUTHORITY VARCHAR2(200) DEFAULT 'ROLE_USER',  -- 스터디 그룹 방장 권한
  NICKNAME VARCHAR2(30) NOT NULL UNIQUE,
  EMAIL VARCHAR2(100) NOT NULL UNIQUE, 
  PROFILE VARCHAR2(1000)
);
CREATE TABLE TB_PER_REV(    -- 개인평가 테이블 생성
    REV_NO NUMBER,
    MEMBER_NO NUMBER,
    PENALTY NUMBER DEFAULT 0,
    FOOT_PRINT NUMBER DEFAULT 0
);
CREATE TABLE TB_STUDYGROUP( -- 스터디 그룹 테이블 생성
        
    GROUP_NO NUMBER DEFAULT 0,
    GROUPNAME VARCHAR2(50) NOT NULL UNIQUE,
    GROUPCONTENT VARCHAR2(200) NOT NULL UNIQUE,
    GROUPACADEMY VARCHAR2(50) NOT NULL UNIQUE,
    GROUPIMAGE VARCHAR2(200)
           
);
CREATE TABLE TB_GROUP_REV( -- 스터디 그룹리뷰 테이블 생성
    GROUP_REV_NO NUMBER,
    GROUP_NO NUMBER,
    MEMBER_NO NUMBER,
    GROUP_SCORE NUMBER, -- 평가점수
    REVIEW VARCHAR2(4000) -- 평가 내용
);
CREATE TABLE TB_SCHEDULE (  -- 스케줄 테이블 생성
    SCHEDULE_NO NUMBER, -- 스케줄 넘버
    SCHEDULE_TITLE VARCHAR2(100), -- 스케줄 제목
    SCHEDULE_CONTENT VARCHAR2(1000), -- 스케줄 내용
    SCHEDULE_DATE DATE, -- 스케줄 날짜
    GROUP_NO NUMBER, -- 스터디그룹 넘버(외래키 제약조건 걸어야함)
    MEMBER_NO NUMBER -- 멤버 넘버(외래키 제약조건 걸어야함)
);
CREATE TABLE TB_POST( -- 게시물 테이블 생성
    POST_NO NUMBER, --게시물 넘버
    POST_TITLE VARCHAR2(50) NOT NULL, -- 게시물 이름
    POST_CONTENT VARCHAR2(4000) NOT NULL, -- 게시물 내용 파일 포함
    CREATE_TIME DATE DEFAULT SYSDATE, -- 게시물 작성 날짜
    UPDATE_TIME DATE, -- 게시물 수정 날짜
    BOARD_VIEW NUMBER DEFAULT 0, -- 게시판 조회수
    SECURITYCHECK CHAR(1) DEFAULT 'N',
    MEMBER_NO NUMBER -- 멤버 테이블 FK (변수명 변경하기)
    
);
CREATE TABLE TB_POST_LIKE( --좋아요 테이블
    PLIKE_NO NUMBER, --좋아요 개수
    PLIKE_CREATE_TIME DATE DEFAULT SYSDATE, --좋아요 누른 시간
    POST_NO NUMBER, --POST테이블 FK
    MEMBER_NO NUMBER --MEMBER테이블 FK (변수명 변경하기)
);
CREATE TABLE TB_COMMENT( -- 게시물 댓글 테이블
    COMMENT_NO NUMBER, -- 댓글 SEQ
    MEMBER_NO NUMBER, -- 외래키, 멤버 SEQ
    COMMENT_CONTENT VARCHAR2(1000) NOT NULL, -- 댓글
    CO_CREATEDATE DATE DEFAULT SYSDATE, -- 댓글작성날짜
    CO_UPDATEDATE DATE, -- 댓글수정날짜
    CO_NICKNAME VARCHAR2(20), -- 댓글익명닉네임
    POST_NO NUMBER -- 외래키, 게시글 SEQ
);
CREATE TABLE TB_IN_COMMENT(-- 게시물 대댓글 테이블
    IN_COMMENT_NO NUMBER, -- 대댓글 SEQ
    IN_COMMENT_CONTENT VARCHAR2(1000) NOT NULL, -- 댓글
    IN_CO_CREATEDATE DATE DEFAULT SYSDATE, -- 댓글작성날짜
    IN_CO_UPDATEDATE DATE, -- 댓글수정날짜
    IN_CO_NICKNAME VARCHAR2(20), -- 댓글익명닉네임
    MEMBER_NO NUMBER, -- 외래키, 멤버 SEQ
    COMMENT_NO NUMBER, --외래키, 댓글 SEQ
    POST_NO NUMBER -- 외래키, 게시글 SEQ
 );
 CREATE TABLE TB_COMMENT_LIKE( -- 좋아요 게시물 댓글 테이블
 CLIKE_NO NUMBER, -- 좋아요 댓글 SEQ
 MEMBER_NO NUMBER, -- 외래키, 멤버 SEQ
 COMMENT_NO NUMBER, -- 외래키, 댓글 SEQ
 LI_CO_CREATEDATE DATE -- 좋아요 댓글 누른 시간
 );
 
 CREATE TABLE TB_GROUP_COMMENT( -- 그룹 댓글 테이블
    GROUP_COMMENT_NO NUMBER, -- 댓글 SEQ
    MEMBER_NO NUMBER, -- 외래키, 멤버 SEQ
    COMMENT_CONTENT VARCHAR2(1000) NOT NULL, -- 댓글
    CO_CREATEDATE DATE DEFAULT SYSDATE, -- 댓글작성날짜
    CO_UPDATEDATE DATE, -- 댓글수정날짜
    CO_NICKNAME VARCHAR2(20), -- 댓글익명닉네임
    GROUP_NO NUMBER -- 외래키, 게시글 SEQ
);
 
 
-- PRIMARY KEY(PK)
ALTER TABLE TB_COMMENT ADD CONSTRAINT TB_COMMENT_COMMENT_NO_PK PRIMARY KEY(COMMENT_NO); -- 게시물 댓글 : 댓글 SEQ 기본키
ALTER TABLE TB_COMMENT_LIKE ADD CONSTRAINT TB_COMMENT_LIKE_LIKE_PK PRIMARY KEY(CLIKE_NO); -- 게시물 댓글 좋아요 댓글 : 댓글 SEQ 기본키
ALTER TABLE TB_GROUP_REV ADD CONSTRAINT TB_GROUP_REV_GROUP_REV_NO_PK PRIMARY KEY(GROUP_REV_NO); -- 그룹평가(TB_GROUP_REV) 테이블의 GROUP_REV_NO 컬럼에  기본키(PRIMARY KEY) 제약조건 추가(부여)
ALTER TABLE TB_MEMBER ADD CONSTRAINT TB_MEMBER_MEMBER_NO_PK PRIMARY KEY(MEMBER_NO); -- 멤버(TB_MEMBER) 테이블의 MEMEBR_NO 컬럼에게  기본키(PRIMARY KEY) 제약조건 추가(부여)
ALTER TABLE TB_PER_REV ADD CONSTRAINT TB_PER_REV_REVIEW_NO_PK PRIMARY KEY(REV_NO); -- 개인평가(TB_PER_REV) 테이블의 REV_NO 컬럼에게 기본키(PRIMARY KEY) 제약조건 추가(부여)
ALTER TABLE TB_POST ADD CONSTRAINT TB_POST_POST_NO_PK PRIMARY KEY(POST_NO); -- 게시물(TB_POST) 테이블의 POST_NO 컬럼에 기본키(PRIMARY KEY) 제약조건 추가(부여)
ALTER TABLE TB_POST_LIKE ADD CONSTRAINT TB_POST_LIKE_PK PRIMARY KEY(PLIKE_NO); -- 게시물(TB_POST_LIKE) 테이블의 LIKE 컬럼에 기본키(PRIMARY KEY) 제약조건 추가(부여)
ALTER TABLE TB_STUDYGROUP ADD CONSTRAINT TB_STUDYGROUP_GROUP_NO_PK PRIMARY KEY(GROUP_NO); -- 스터디그룹(TB_STUDYGROUP) 테이블의 GROUP_NO 컬럼에 기본키(PRIMARY KEY) 제약조건 추가(부여)
ALTER TABLE TB_SCHEDULE ADD CONSTRAINT TB_SCHEDULE_SCHEDULE_NO_PK PRIMARY KEY(SCHEDULE_NO); -- 스케줄(TB_SCHEDULE) 테이블의 SCHEDULE_NO 컬럼에 기본키(PRIMARY KEY) 제약조건 추가(부여)
ALTER TABLE TB_IN_COMMENT ADD CONSTRAINT IN_COMMENT_NO_PK PRIMARY KEY(IN_COMMENT_NO); --게시물 대댓글 : 대댓글 SEQ 기본키
ALTER TABLE TB_GROUP_COMMENT ADD CONSTRAINT TB_GROUP_COMMENT_GROUP_COMMENT_NO_PK PRIMARY KEY(GROUP_COMMENT_NO); -- 그룹 댓글(TB_GROUP_COMMENT) 테이블의 GROUP_COMMENT_NO 컬럼 기본키
-- FOREIGN KEY(FK)
ALTER TABLE TB_COMMENT ADD CONSTRAINT TB_COMMENT_MEMBER_NO_FK FOREIGN KEY(MEMBER_NO) REFERENCES TB_MEMBER; -- 게시글 댓글 : 멤버 SEQ 외래키
ALTER TABLE TB_COMMENT ADD CONSTRAINT TB_COMMENT_POST_NO_FK FOREIGN KEY(POST_NO) REFERENCES TB_POST ON DELETE CASCADE; -- 게시글 댓글 : 게시글 SEQ 외래키
ALTER TABLE TB_COMMENT_LIKE ADD CONSTRAINT TB_COMMENT_LIKE_COMMENT_NO_FK FOREIGN KEY(COMMENT_NO) REFERENCES TB_COMMENT; -- 게시물 좋아요 댓글 : 댓글 SEQ 외래키
ALTER TABLE TB_COMMENT_LIKE ADD CONSTRAINT TB_COMMENT_LIKE_MEMBER_NO_FK FOREIGN KEY(MEMBER_NO) REFERENCES TB_MEMBER; -- 게시물 좋아요 댓글 : 멤버 SEQ 외래키
ALTER TABLE TB_GROUP_REV ADD CONSTRAINT TB_GROUP_REV_GROUP_NO_FK FOREIGN KEY(GROUP_NO) REFERENCES TB_STUDYGROUP; -- 그룹평가(TB_GROUP_REV) 테이블의 GROUP_NO 컬럼에게 외래키 제약조건 추가(부여) (참조하는 컬럼은 TB_STUDYGROUP 테이블의 기본키인 GROUP_NO 컬럼이다.)
ALTER TABLE TB_GROUP_REV ADD CONSTRAINT TB_GROUP_REV_MEMBER_NO_FK FOREIGN KEY(MEMBER_NO) REFERENCES TB_MEMBER; -- 그룹평가(TB_GROUP_REV) 테이블의 MEMBER_NO 컬럼에게 외래키 제약조건 추가(부여) (참조하는 컬럼은 TB_MEMBER 테이블의 기본키인 MEMBER_NO 컬럼이다.)
ALTER TABLE TB_MEMBER ADD CONSTRAINT TB_MEMBER_GROUP_NO_FK FOREIGN KEY(GROUP_NO) REFERENCES TB_STUDYGROUP; -- TB_MEMBER 테이블의 GROUP_NO 컬럼 외래키 제약조건 추가(부여) (참조하는 컬럼은 TB_STUDYGROUP 테이블의 기본키인 GROUP_NO 컬럼이다.)
ALTER TABLE TB_PER_REV ADD CONSTRAINT TB_PER_REV_MEMBER_NO_FK FOREIGN KEY(MEMBER_NO) REFERENCES TB_MEMBER; -- 개인평가(TB_PER_REV) 테이블의 MEMBER_NO 컬럼에게 외래키 제약조건 추가(부여) (참조하는 컬럼은 TB_MEMBER 테이블의 기본키인 MEMBER_NO 컬럼이다.)
ALTER TABLE TB_POST ADD CONSTRAINT TB_POST_MEMBER_NO_FK FOREIGN KEY(MEMBER_NO) REFERENCES TB_MEMBER; -- 게시물(TB_POST) 테이블의 MEMBER_NO 컬럼에게 외래키 제약조건 추가(부여) (참조하는 컬럼은 TB_MEMBER 테이블의 기본키인 MEMBER_NO 컬럼이다.)
ALTER TABLE TB_POST_LIKE ADD CONSTRAINT TB_POST_LIKE_MEMBER_NO_FK FOREIGN KEY(MEMBER_NO) REFERENCES TB_MEMBER; -- 게시물 좋아요(TB_POST_LIKE) 테이블의 MEMBER_NO 컬럼에게 외래키 제약조건 추가(부여) (참조하는 컬럼은 TB_MEMBER 테이블의 기본키인 MEMBER_NO 컬럼이다.)
ALTER TABLE TB_POST_LIKE ADD CONSTRAINT TB_POST_POST_NO_FK FOREIGN KEY(POST_NO) REFERENCES TB_POST; -- 게시물 좋아요(TB_POST_LIKE) 테이블의 POST_NO 컬럼에게 외래키 제약조건 추가(부여) (참조하는 컬럼은 TB_POST 테이블의 기본키인 POST_NO 컬럼이다.)
ALTER TABLE TB_SCHEDULE ADD CONSTRAINT TB_SCHEDULE_STUDYGROUP_NO_FK FOREIGN KEY(GROUP_NO) REFERENCES TB_STUDYGROUP; -- 스케줄(TB_SCHEDULE) 테이블의 GROUP_NO 컬럼에게 외래키 제약조건 추가(부여) (참조하는 컬럼은 TB_STUDYGROUP 테이블의 기본키인 GROUP_NO 컬럼이다.)
ALTER TABLE TB_SCHEDULE ADD CONSTRAINT TB_SCHEDULE_MEMBER_NO_FK FOREIGN KEY(MEMBER_NO) REFERENCES TB_MEMBER; -- 스케줄(TB_SCHEDULE) 테이블의 MEMBER_NO 컬럼에게 외래키 제약조건 추가(부여) (참조하는 컬럼은 TB_MEMBER 테이블의 기본키인 MEMBER_NO 컬럼이다.)
ALTER TABLE TB_IN_COMMENT ADD CONSTRAINT TB_IN_COMMENT_MEMBER_NO_FK FOREIGN KEY(MEMBER_NO) REFERENCES TB_MEMBER; -- 대댓글(TB_IN_COMMENT) 테이블의 MEMBER_NO 컬럼에게 외래키 제약조건 추가(부여) (참조하는 컬럼은 TB_MEMBER 테이블의 기본키인 MEMBER_NO 컬럼이다.)
ALTER TABLE TB_IN_COMMENT ADD CONSTRAINT TB_IN_COMMENT_POST_NO_FK FOREIGN KEY(POST_NO) REFERENCES TB_POST; -- 대댓글(TB_IN_COMMENT) 테이블의 POST_NO 컬럼에게 외래키 제약조건 추가(부여) (참조하는 컬럼은 TB_POST 테이블의 기본키인 POST_NO 컬럼이다.)
ALTER TABLE TB_IN_COMMENT ADD CONSTRAINT TB_IN_COMMENT_COMMENT_NO_FK FOREIGN KEY(COMMENT_NO) REFERENCES TB_COMMENT  ON DELETE CASCADE; -- 대댓글(TB_IN_COMMENT) 테이블의 TB_COMMENT 컬럼에게 외래키 제약조건 추가(부여) (참조하는 컬럼은 TB_COMMENT 테이블의 기본키인 COMMENT_NO 컬럼이다.)
ALTER TABLE TB_IN_COMMENT ADD FOREIGN KEY (IN_COMMENT_NO) REFERENCES TB_COMMENT(COMMENT_NO) ON DELETE CASCADE;

    -- 대댓글 포함된 댓글 삭제 시 부모키 위배되기 때문에 지정해줘야함
    -- 대댓글은 null 표시되고 db값에는 남아있음
    -- 대댓글도 삭제하고 싶으면  로 변경해주면 됨
ALTER TABLE TB_GROUP_COMMENT ADD CONSTRAINT TB_GROUP_COMMENT_MEMBER_NO_FK FOREIGN KEY(MEMBER_NO) REFERENCES TB_MEMBER; -- 그룹 댓글 : 멤버 SEQ 외래키
ALTER TABLE TB_GROUP_COMMENT ADD CONSTRAINT TB_GROUP_COMMENT_GROUP_NO_FK FOREIGN KEY(GROUP_NO) REFERENCES TB_STUDYGROUP; -- 그룹 댓글 : 스터디그룹 SEQ 외래키
ALTER TABLE TB_IN_COMMENT DROP CONSTRAINT SYS_C009486;
--시퀀스 생성
 CREATE SEQUENCE SEQ_COMMENT_NO; -- TB_COMMENT의 COMMENT_NO 컬럼 SEQ (댓글 번호)
 CREATE SEQUENCE SEQ_COMMENT_LIKE_NO; -- TB_COMMENT_LIKE의 CLIKE_NO 컬럼 SEQ (댓글 번호)
 CREATE SEQUENCE SEQ_GROUP_NO; -- TB_STUDYGROUP의 GROUP_NO 컬럼 SEQ (스터디그룹 번호)
 CREATE SEQUENCE SEQ_GROUP_REV_NO; -- TB_GROUP_REV의 GROUP_REV_NO 컬럼 SEQ(그룹평가 번호)
 CREATE SEQUENCE SEQ_IN_COMMENT_NO; -- TB_IN_COMMENT의 IN_COMMENT_NO 컬럼 SEQ (대댓글 번호)
 CREATE SEQUENCE SEQ_MEMBER_NO;  -- TB_MEMBER의 MEMBER_NO 컬럼 SEQ (멤버 번호)
 CREATE SEQUENCE SEQ_POST_NO; -- TB_POST의 POST_NO 컬럼 SEQ (게시글 번호)
 CREATE SEQUENCE SEQ_PER_REV_NO; -- TB_PER_REV의 PER_REV_NO 컬럼 SEQ(개인평가 번호)
 CREATE SEQUENCE SEQ_POST_LIKE; -- TB_POST_LIKE의 PLIKE_NO 컬럼 SEQ (게시물 좋아요 번호(갯수)
 CREATE SEQUENCE SEQ_SCHEDULE_NO; -- TB_SCHEDULE SCHEDULE_NO 컬럼 SEQ (스케줄 번호)
 CREATE SEQUENCE SEQ_GROUP_COMMENT_NO; -- TB_GROUP_COMMENT의 GROUP_COMMENT_NO 컬럼 SEQ(댓글 번호)
 --날짜 포맷 변경
 ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
-- ALTER TABLE TB_MEMBER MODIFY BIRTH DATE(date_format(BIRTH(),'YYYY-MM-DD'));
--
--
UPDATE tb_post SET board_view = board_view + 1 WHERE post_no =1;


commit;