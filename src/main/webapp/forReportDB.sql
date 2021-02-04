
-- system 계정에서 작업 --------------------------------------------------

-- (1) 사용자계정 생성 :forreport/forreport
CREATE USER forreport IDENTIFIED BY forreport;
---(2) 계정 사용 허가
GRANT CONNECT,Resource TO forreport;--필수
Grant create view,create synonym to forreport;--옵션

-- forreport 계정에서 작업 -----------------------------------------------

/* 사용자 테이블 */
CREATE TABLE tbl_user (
   id VARCHAR2(20) NOT NULL, /* ID */
   password VARCHAR2(100) NOT NULL, /* 암호 */
   name VARCHAR2(20) NOT NULL, /* 이름 */
   phone VARCHAR2(12) NOT NULL, /* 휴대폰번호 */
   email VARCHAR2(30) NOT NULL, /* 이메일 */
   grade number default 0 NOT NULL, /* 등급 */
   enabled number(1) default 1 NOT NULL
);

CREATE UNIQUE INDEX PK_tbl_user
   ON tbl_user (
      id ASC
   );

ALTER TABLE tbl_user
   ADD
      CONSTRAINT PK_tbl_user
      PRIMARY KEY (
         id
      );

/* 상품종류 */
CREATE TABLE tbl_category (
   largeca NUMBER NOT NULL, /* 대분류 */
   smallca NUMBER NOT NULL /* 소분류 */
);

CREATE UNIQUE INDEX PK_tbl_category
   ON tbl_category (
      largeca ASC,
      smallca ASC
   );

ALTER TABLE tbl_category
   ADD
      CONSTRAINT PK_tbl_category
      PRIMARY KEY (
         largeca,
         smallca
      );


/* 상품테이블 */
CREATE TABLE tbl_product (
   pronum NUMBER NOT NULL, /* 상품번호 */
   id VARCHAR2(20), /* ID */
   largeca NUMBER NOT NULL, /* 대분류 */
   smallca NUMBER NOT NULL, /* 소분류 */
   title VARCHAR2(100) NOT NULL, /* 제목 */
   proname VARCHAR2(100) NOT NULL, /* 상품명 */
   prodsc VARCHAR2(3000) NOT NULL, /* 상품설명 */
   price NUMBER NOT NULL, /* 가격 */
   uploaddate DATE default sysdate NOT NULL, /* 작성일 */
   approval NUMBER default 0 NOT NULL /* 승인여부 */
);

CREATE UNIQUE INDEX PK_tbl_product
   ON tbl_product (
      pronum ASC
   );

ALTER TABLE tbl_product
   ADD
      CONSTRAINT PK_tbl_product
      PRIMARY KEY (
         pronum
      );

/* 썸네일 업로드 테이블 */
CREATE TABLE tbl_upload (
   pronum NUMBER NOT NULL, /* 상품번호 */
   uuid VARCHAR2(100) NOT NULL, /* UUID */
   filedirectory VARCHAR2(200) NOT NULL, /* 파일경로 */
   filename VARCHAR2(100) NOT NULL /* 파일이름 */
);

CREATE UNIQUE INDEX PK_tbl_upload
   ON tbl_upload (
      pronum ASC
   );

ALTER TABLE tbl_upload
   ADD
      CONSTRAINT PK_tbl_upload
      PRIMARY KEY (
         pronum
      );


/* 주문(결제)테이블 */
CREATE TABLE tbl_order (
   ordernum NUMBER NOT NULL, /* 주문번호 */
   pronum NUMBER NOT NULL, /* 상품번호 */
   id VARCHAR2(20), /* ID */
   paymethod VARCHAR2(20) NOT NULL, /* 결제방식 */
   payprice NUMBER NOT NULL, /* 결제금액 */
   orderdate DATE default sysdate NOT NULL /* 주문일자 */
);

CREATE UNIQUE INDEX PK_tbl_order
   ON tbl_order (
      ordernum ASC
   );

ALTER TABLE tbl_order
   ADD
      CONSTRAINT PK_tbl_order
      PRIMARY KEY (
         ordernum
      );

/* 장바구니 테이블 */
CREATE TABLE tbl_cart (
   cartnum NUMBER NOT NULL, /* 장바구니번호 */
   id VARCHAR2(20), /* ID */
   pronum NUMBER NOT NULL /* 상품번호 */
);

CREATE UNIQUE INDEX PK_tbl_cart
   ON tbl_cart (
      cartnum ASC
   );

ALTER TABLE tbl_cart
   ADD
      CONSTRAINT PK_tbl_cart
      PRIMARY KEY (
         cartnum
      );

/* 리뷰 테이블 */
CREATE TABLE tbl_review (
   reviewnum NUMBER NOT NULL, /* 리뷰번호 */
   pronum NUMBER NOT NULL, /* 상품번호 */
   id VARCHAR2(20), /* ID */
   review VARCHAR2(1000) NOT NULL, /* 작성내용 */
   reviewdate DATE NOT NULL, /* 작성일 */
   rate NUMBER default 0 NOT NULL /* 별점 */
);

CREATE UNIQUE INDEX PK_tbl_review
   ON tbl_review (
      reviewnum ASC
   );

ALTER TABLE tbl_review
   ADD
      CONSTRAINT PK_tbl_review
      PRIMARY KEY (
         reviewnum
      );
        
/* 공지사항테이블 */
CREATE TABLE tbl_notice (
   noticenum NUMBER NOT NULL, /* 공지사항번호 */
   noticetitle VARCHAR2(100) NOT NULL, /* 제목 */
   notice VARCHAR2(3000) NOT NULL, /* 내용 */
   writedate DATE default sysdate NOT NULL, /* 작성일 */
   revisedate DATE default sysdate NOT NULL /* 수정일 */
);

ALTER TABLE tbl_notice
   ADD
      CONSTRAINT PK_tbl_notice
      PRIMARY KEY (
         noticenum
      );
        
/* 자주묻는질문 테이블 */
CREATE TABLE tbl_question (
   questionnum NUMBER NOT NULL, /* 질문번호 */
   questiontitle VARCHAR2(100) NOT NULL, /* 제목 */
   question VARCHAR2(3000) not null/* 내용 */
);        

ALTER TABLE tbl_question
   ADD
      CONSTRAINT PK_tbl_question
      PRIMARY KEY (
         questionnum
      );

/* 권한 테이블 */
CREATE TABLE tbl_auth (
   auth varchar2(50) NOT NULL, /* 권한 */
   id VARCHAR2(20) NOT NULL /* ID */
);

/* 자동로그인 테이블 */ /*이름 절대 바꾸면 안됨*/
CREATE TABLE persistent_logins (
	username VARCHAR2(80) NOT NULL, 
	series VARCHAR2(80) NOT NULL, 
	token VARCHAR2(80) NOT NULL, 
	last_used TIMESTAMP NOT NULL 
);

-- 주문번호를 추가!!
/* 가상계좌 테이블 */
CREATE TABLE tbl_vbank(
    id VARCHAR2(20) NOT NULL,   /* ID */
    ordernum number NOT NULL,   /* 주문번호 */
    vbnum VARCHAR2(100) NOT NULL,   /* 입금계좌명 */
    vbname VARCHAR2(50) NOT NULL,   /* 은행명 */
    vbholder VARCHAR2(30) NOT NULL,   /* 예금주 */
    vbdate DATE NOT NULL    /* 입금기한 */
);


-- 참조(FK)
ALTER TABLE tbl_product
   ADD
      CONSTRAINT FK_tbl_category_TO_tbl_product
      FOREIGN KEY (
         largeca,
         smallca
      )
      REFERENCES tbl_category (
         largeca,
         smallca
      );

ALTER TABLE tbl_product
   ADD
      CONSTRAINT FK_tbl_user_TO_tbl_product
      FOREIGN KEY (
         id
      )
      REFERENCES tbl_user (
         id
      ) on delete set null;

ALTER TABLE tbl_upload
   ADD
      CONSTRAINT FK_tbl_product_TO_tbl_upload
      FOREIGN KEY (
         pronum
      )
      REFERENCES tbl_product (
         pronum
      );

ALTER TABLE tbl_order
   ADD
      CONSTRAINT FK_tbl_product_TO_tbl_order
      FOREIGN KEY (
         pronum
      )
      REFERENCES tbl_product (
         pronum
      );

ALTER TABLE tbl_order
   ADD
      CONSTRAINT FK_tbl_user_TO_tbl_order
      FOREIGN KEY (
         id
      )
      REFERENCES tbl_user (
         id
      ) on delete set null;

ALTER TABLE tbl_cart
   ADD
      CONSTRAINT FK_tbl_user_TO_tbl_cart
      FOREIGN KEY (
         id
      )
      REFERENCES tbl_user (
         id
      ) on delete cascade;

ALTER TABLE tbl_cart
   ADD
      CONSTRAINT FK_tbl_product_TO_tbl_cart
      FOREIGN KEY (
         pronum
      )
      REFERENCES tbl_product (
         pronum
      );

ALTER TABLE tbl_review
   ADD
      CONSTRAINT FK_tbl_user_TO_tbl_review
      FOREIGN KEY (
         id
      )
      REFERENCES tbl_user (
         id
      ) on delete set null;

ALTER TABLE tbl_review
   ADD
      CONSTRAINT FK_tbl_product_TO_tbl_review
      FOREIGN KEY (
         pronum
      )
      REFERENCES tbl_product (
         pronum
      );
    
ALTER TABLE tbl_auth
   ADD
      CONSTRAINT FK_tbl_user_TO_tbl_auth
      FOREIGN KEY (
         id
      )
      REFERENCES tbl_user (
         id
      ) on delete cascade;
      

/* 가상계좌 테이블 FK 추가 */
ALTER TABLE tbl_vbank
   ADD
      CONSTRAINT FK_tbl_user_TO_tbl_vbank
      FOREIGN KEY (
         id
      )
      REFERENCES tbl_user (
         id
      ) on delete cascade;

ALTER TABLE tbl_vbank
   ADD
      CONSTRAINT FK_tbl_order_TO_tbl_vbank
      FOREIGN KEY (
         ordernum
      )
      REFERENCES tbl_order (
         ordernum
      );
        
--시퀀스 생성 
create sequence seq_cart;
create sequence seq_product;
create sequence seq_order;
create sequence seq_review;
create sequence seq_notice;
create sequence seq_question;

-- ! 관리자 계정 추가 !
-- 관리자 계정은 테스트 코드를 수행해 작성합니다
--user1, user1, user1Name, 01000001111, user1@user1.com, 0
--user2, user2, user2Name, 01000002222, user2@user2.com, 0
--user3, user3, user3Name, 01000003333, user3@user3.com, 0
--user4, user4, user4Name, 01000004444, user4@user4.com, 0
--user5, user5, user5Name, 01000005555, user5@user5.com, 0
--user6, user6, user6Name, 01000006666, user6@user6.com, 0
--user7, user7, user7Name, 01000007777, user7@user7.com, 0
--user8, user8, user8Name, 01000008888, user8@user8.com, 0
--user9, user9, user9Name, 01000009999, user9@user9.com, 0
--user10, user10, user10Name, 01000001010, user10@user10.com, 0
--aa, aa, aaName, 01011112222, aa@aa.com, 0
--bb, bb, bbName, 01022222222, bb@bb.com, 0

-- 테이블 내용 조회
select * from tbl_category;
select * from tbl_user;
select * from tbl_auth;
select * from tbl_product;
select * from tbl_cart;
select * from tbl_order;
select * from tbl_vbank;
select * from tbl_review;
select * from tbl_upload;
select * from tbl_notice;
select * from tbl_question;

-- 데이터 삭제
delete tbl_user;

--- 테이블 삭제(모든 테이블을 삭제할 경우, 아래 순서대로 해야 문제 없이 삭제됩니다)
drop table tbl_vbank;
drop table tbl_auth;
drop table tbl_question;
drop table tbl_notice;
drop table tbl_review;
drop table tbl_cart;
drop table tbl_order;
drop table tbl_upload;
drop table tbl_product;
drop table tbl_category;
drop table tbl_user;

commit;

-- 카테고리 테이블(tbl_category)에 데이터 추가
insert into tbl_category values('0', '0');  -- 리포트(0)/인문사회(0)
insert into tbl_category values('0', '1');  -- 리포트(0)/자연공학(1)
insert into tbl_category values('0', '2');  -- 리포트(0)/예술체육(2)
insert into tbl_category values('0', '3');  -- 리포트(0)/교양(3)
insert into tbl_category values('1', '0');  -- 논문(1)/인문사회(0)
insert into tbl_category values('1', '1');  -- 논문(1)/자연공학(1)
insert into tbl_category values('1', '2');  -- 논문(1)/예술체육(2)
insert into tbl_category values('1', '3');  -- 논문(1)/교양(3)

-- 페이징 처리 확인을 위한 가짜 데이터(tbl_product) 추가
-- 레포트(0) 인문사회(0)
insert into tbl_product values(seq_product.nextval, 'bb', '0', '0', '레포트인문사회title1', 'proname1', 'prodcs1', '100', sysdate, '1'); -- 상품번호, 업로드아이디, 대카테고리, 소카테고리, 제목, 상품명, 설명, 가격, 승인(0 - 미승인)
insert into tbl_product values(seq_product.nextval, 'bb', '0', '0', '레포트인문사회title2', 'proname2', 'prodcs2', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '0', '레포트인문사회title3', 'proname3', 'prodcs3', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '0', '레포트인문사회title4', 'proname4', 'prodcs4', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '0', '레포트인문사회title5', 'proname5', 'prodcs5', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '0', '레포트인문사회title6', 'proname6', 'prodcs6', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '0', '레포트인문사회title7', 'proname7', 'prodcs7', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '0', '레포트인문사회title8', 'proname8', 'prodcs8', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '0', '레포트인문사회title9', 'proname9', 'prodcs9', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '0', '레포트인문사회title10', 'proname10', 'prodcs10', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '0', '레포트인문사회title11', 'proname11', 'prodcs11', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '0', '레포트인문사회title12', 'proname12', 'prodcs12', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '0', '레포트인문사회title13', 'proname13', 'prodcs13', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '0', '레포트인문사회title14', 'proname14', 'prodcs14', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '0', '레포트인문사회title15', 'proname15', 'prodcs15', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '0', '레포트인문사회title16', 'proname16', 'prodcs16', '100', sysdate, '1');

-- 레포트(0) 자연공학(1)
insert into tbl_product values(seq_product.nextval, 'bb', '0', '1', '레포트자연공학title1', 'proname1', 'prodcs1', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '1', '레포트자연공학title2', 'proname2', 'prodcs2', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '1', '레포트자연공학title3', 'proname3', 'prodcs3', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '1', '레포트자연공학title4', 'proname4', 'prodcs4', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '1', '레포트자연공학title5', 'proname5', 'prodcs5', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '1', '레포트자연공학title6', 'proname6', 'prodcs6', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '1', '레포트자연공학title7', 'proname7', 'prodcs7', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '1', '레포트자연공학title8', 'proname8', 'prodcs8', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '1', '레포트자연공학title9', 'proname9', 'prodcs9', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '1', '레포트자연공학title10', 'proname10', 'prodcs10', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '1', '레포트자연공학title11', 'proname11', 'prodcs11', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '1', '레포트자연공학title12', 'proname12', 'prodcs12', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '1', '레포트자연공학title13', 'proname13', 'prodcs13', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '1', '레포트자연공학title14', 'proname14', 'prodcs14', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '1', '레포트자연공학title15', 'proname15', 'prodcs15', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '1', '레포트자연공학title16', 'proname16', 'prodcs16', '100', sysdate, '1');

-- 레포트(0) 예술체육(2)
insert into tbl_product values(seq_product.nextval, 'bb', '0', '2', '레포트예술체육title1', 'proname1', 'prodcs1', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '2', '레포트예술체육title2', 'proname2', 'prodcs2', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '2', '레포트예술체육title3', 'proname3', 'prodcs3', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '2', '레포트예술체육title4', 'proname4', 'prodcs4', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '2', '레포트예술체육title5', 'proname5', 'prodcs5', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '2', '레포트예술체육title6', 'proname6', 'prodcs6', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '2', '레포트예술체육title7', 'proname7', 'prodcs7', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '2', '레포트예술체육title8', 'proname8', 'prodcs8', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '2', '레포트예술체육title9', 'proname9', 'prodcs9', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '2', '레포트예술체육title10', 'proname10', 'prodcs10', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '2', '레포트예술체육title11', 'proname11', 'prodcs11', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '2', '레포트예술체육title12', 'proname12', 'prodcs12', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '2', '레포트예술체육title13', 'proname13', 'prodcs13', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '2', '레포트예술체육title14', 'proname14', 'prodcs14', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '2', '레포트예술체육title15', 'proname15', 'prodcs15', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '2', '레포트예술체육title16', 'proname16', 'prodcs16', '100', sysdate, '1');

-- 레포트(0) 교양(3)
insert into tbl_product values(seq_product.nextval, 'bb', '0', '3', '레포트교양title1', 'proname1', 'prodcs1', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '3', '레포트교양title2', 'proname2', 'prodcs2', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '3', 레포트교양'title3', 'proname3', 'prodcs3', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '3', '레포트교양title4', 'proname4', 'prodcs4', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '3', '레포트교양title5', 'proname5', 'prodcs5', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '3', '레포트교양title6', 'proname6', 'prodcs6', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '3', '레포트교양title7', 'proname7', 'prodcs7', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '3', '레포트교양title8', 'proname8', 'prodcs8', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '3', '레포트교양title9', 'proname9', 'prodcs9', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '3', '레포트교양title10', 'proname10', 'prodcs10', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '3', '레포트교양title11', 'proname11', 'prodcs11', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '0', '3', '레포트교양title12', 'proname12', 'prodcs12', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '3', '레포트교양title13', 'proname13', 'prodcs13', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '3', '레포트교양title14', 'proname14', 'prodcs14', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '3', '레포트교양title15', 'proname15', 'prodcs15', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '0', '3', '레포트교양title16', 'proname16', 'prodcs16', '100', sysdate, '1');

-- 논문(1) 인문사회(0)
insert into tbl_product values(seq_product.nextval, 'bb', '1', '0', '논문인문사회title1', 'proname1', 'prodcs1', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '0', '논문인문사회title2', 'proname2', 'prodcs2', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '0', '논문인문사회title3', 'proname3', 'prodcs3', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '0', '논문인문사회title4', 'proname4', 'prodcs4', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '0', '논문인문사회title5', 'proname5', 'prodcs5', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '0', '논문인문사회title6', 'proname6', 'prodcs6', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '0', '논문인문사회title7', 'proname7', 'prodcs7', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '0', '논문인문사회title8', 'proname8', 'prodcs8', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '0', '논문인문사회title9', 'proname9', 'prodcs9', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '0', '논문인문사회title10', 'proname10', 'prodcs10', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '0', '논문인문사회title11', 'proname11', 'prodcs11', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '0', '논문인문사회title12', 'proname12', 'prodcs12', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '0', '논문인문사회title13', 'proname13', 'prodcs13', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '0', '논문인문사회title14', 'proname14', 'prodcs14', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '0', '논문인문사회title15', 'proname15', 'prodcs15', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '0', '논문인문사회title16', 'proname16', 'prodcs16', '100', sysdate, '1');

-- 논문(1) 자연공학(1)
insert into tbl_product values(seq_product.nextval, 'bb', '1', '1', '논문자연공학title1', 'proname1', 'prodcs1', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '1', '논문자연공학title2', 'proname2', 'prodcs2', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '1', '논문자연공학title3', 'proname3', 'prodcs3', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '1', '논문자연공학title4', 'proname4', 'prodcs4', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '1', '논문자연공학title5', 'proname5', 'prodcs5', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '1', '논문자연공학title6', 'proname6', 'prodcs6', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '1', '논문자연공학title7', 'proname7', 'prodcs7', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '1', '논문자연공학title8', 'proname8', 'prodcs8', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '1', '논문자연공학title9', 'proname9', 'prodcs9', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '1', '논문자연공학title10', 'proname10', 'prodcs10', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '1', '논문자연공학title11', 'proname11', 'prodcs11', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '1', '논문자연공학title12', 'proname12', 'prodcs12', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '1', '논문자연공학title13', 'proname13', 'prodcs13', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '1', '논문자연공학title14', 'proname14', 'prodcs14', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '1', '논문자연공학title15', 'proname15', 'prodcs15', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '1', '논문자연공학title16', 'proname16', 'prodcs16', '100', sysdate, '1');

--논문(1) 예술체육(2)
insert into tbl_product values(seq_product.nextval, 'bb', '1', '2', '논문예술체육title1', 'proname1', 'prodcs1', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '2', '논문예술체육title2', 'proname2', 'prodcs2', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '2', '논문예술체육title3', 'proname3', 'prodcs3', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '2', '논문예술체육title4', 'proname4', 'prodcs4', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '2', '논문예술체육title5', 'proname5', 'prodcs5', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '2', '논문예술체육title6', 'proname6', 'prodcs6', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '2', '논문예술체육title7', 'proname7', 'prodcs7', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '2', '논문예술체육title8', 'proname8', 'prodcs8', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '2', '논문예술체육title9', 'proname9', 'prodcs9', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '2', '논문예술체육title10', 'proname10', 'prodcs10', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '2', '논문예술체육title11', 'proname11', 'prodcs11', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '2', '논문예술체육title12', 'proname12', 'prodcs12', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '2', '논문예술체육title13', 'proname13', 'prodcs13', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '2', '논문예술체육title14', 'proname14', 'prodcs14', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '2', '논문예술체육title15', 'proname15', 'prodcs15', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '2', '논문예술체육title16', 'proname16', 'prodcs16', '100', sysdate, '1');

-- 논문(1) 교양(3)
insert into tbl_product values(seq_product.nextval, 'bb', '1', '3', '논문교양title1', 'proname1', 'prodcs1', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '3', '논문교양title2', 'proname2', 'prodcs2', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '3', '논문교양title3', 'proname3', 'prodcs3', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '3', '논문교양title4', 'proname4', 'prodcs4', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '3', '논문교양title5', 'proname5', 'prodcs5', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '3', '논문교양title6', 'proname6', 'prodcs6', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '3', '논문교양title7', 'proname7', 'prodcs7', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '3', '논문교양title8', 'proname8', 'prodcs8', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '3', '논문교양title9', 'proname9', 'prodcs9', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '3', '논문교양title10', 'proname10', 'prodcs10', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '3', '논문교양title11', 'proname11', 'prodcs11', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'bb', '1', '3', '논문교양title12', 'proname12', 'prodcs12', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '3', '논문교양title13', 'proname13', 'prodcs13', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '3', '논문교양title14', 'proname14', 'prodcs14', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '3', '논문교양title15', 'proname15', 'prodcs15', '100', sysdate, '1');
insert into tbl_product values(seq_product.nextval, 'aa', '1', '3', '논문교양title16', 'proname16', 'prodcs16', '100', sysdate, '1');

commit;

-- 테스트를 위한 가짜 데이터(tbl_review) 추가
-- 리뷰번호, 리뷰작성자, 상품번호, 리뷰본론, 오늘날짜, 별점
insert into tbl_review values(seq_review.nextval, 229, 'aa', 'review', sysdate, '1'); 
insert into tbl_review values(seq_review.nextval, 229, 'aa', 'review', sysdate, '2'); 
insert into tbl_review values(seq_review.nextval, 229, 'aa', 'review', sysdate, '3'); 
insert into tbl_review values(seq_review.nextval, 229, 'aa', 'review', sysdate, '4'); 
insert into tbl_review values(seq_review.nextval, 229, 'aa', 'review', sysdate, '5'); 
insert into tbl_review values(seq_review.nextval, 229, 'aa', 'review', sysdate, '4'); 
insert into tbl_review values(seq_review.nextval, 229, 'aa', 'review', sysdate, '4'); 
insert into tbl_review values(seq_review.nextval, 229, 'aa', 'review', sysdate, '5'); 
insert into tbl_review values(seq_review.nextval, 229, 'aa', 'review', sysdate, '5'); 
insert into tbl_review values(seq_review.nextval, 229, 'aa', 'review', sysdate, '2'); 
insert into tbl_review values(seq_review.nextval, 229, 'aa', 'review', sysdate, '3'); 
insert into tbl_review values(seq_review.nextval, 229, 'aa', 'review', sysdate, '3'); 

-- 테스트를 위한 가짜 데이터(tbl_order) 추가
-- (무통장의 경우 계좌가 발급되어야 하므로 실제 페이지에서만 테스트 가능, 아래 코드는 신용카드인 경우만 해당)
insert into tbl_order values(seq_order.nextval, 229, 'aa', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 229, 'bb', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 229, 'user1', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 229, 'user2', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 229, 'user3', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 229, 'user4', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 234, 'aa', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 234, 'bb', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 234, 'user1', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 234, 'user2', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 236, 'user3', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 236, 'user4', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 217, 'user3', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 217, 'user4', 'card', 100, sysdate);
insert into tbl_order values(seq_order.nextval, 222, 'aa', 'card', 100, sysdate);

commit;

-- tbl_question 테이블에 가짜 데이터 추가
insert into tbl_question values(seq_question.nextval, '아이디와 비밀번호를 잊어버렸습니다.', 
'아이디와 비밀번호는 이메일 인증으로 직접 찾기가 가능합니다.

1.아이디 찾기
회원가입 시 입력하셨던 정보로만 확인이 가능합니다.
이메일 인증 : 이름과 이메일을 입력 후 회원정보에 등록된 메일로 전송된 아이디 확인

2.비밀번호 찾기
회원가입 시 입력하셨던 정보로만 확인이 가능합니다.
이메일 인증 : 이름과 이메일을 입력 후 회원정보에 등록된 메일로 전송된 아이디 확인

※ 이메일로 전송된 인증번호를 시간 내 입력해야 하며 스팸으로 분류되거나
수신(forreport0202@google.com)차단으로 인해 수신/확인되지 않을 경우 차단해제 후 다시 한 번 시도해주시기 바랍니다
');
insert into tbl_question values(seq_question.nextval, '이메일이 변경되어 비밀번호 찾기가 되지 않습니다.', 
'회원가입 당시 등록한 이메일을 더이상 사용하지 않거나
등록한 정보가 기억나지 않을 때는 비밀번호 찾기 기능을 이용하실 수 없습니다.

본인 확인에 필요한 필수정보아이디, 이름, 생년월일, 휴대폰번호, 이메일주소를 기재하여
(forreport0202@google.com)로 접수해 주시면 이메일로 임시비밀번호를 발송해 드립니다.

FOR REPORT에서는 정보통신망 이용촉진 및 정보보호 등의 관한 법률에 의거하여
최근 1년간 로그인기록이 없는 회원들에 한하여 메일 고지 후에 매달 7일 정보를 삭제하고 있습니다. 정보가 삭제되면 회원탈퇴와 동일하게 처리되므로 신규가입을 통해 서비스를 이용하셔야 합니다.
');
insert into tbl_question values(seq_question.nextval, '아이디를 여러 개 사용할 수 있나요?', 
'FOR REPORT에서는 1인 1개 아이디만 사용 하도록 운영하고 있습니다.

자료를 판매하여 수익금이 발생되면 수익금을 출금하게 되는데
1년동안 일정금액 이상 수익금을 출금하게 되면 세금신고를 하게 됩니다. 이런 경우 각 아이디별로 발생된 수익금의 총 합산된 금액으로 세금이 신고되므로 금액을 관리하기 힘들어질 뿐만 아니라 경우에 따라서는 세금이 추가 발생될 수도 있습니다.
');
insert into tbl_question values(seq_question.nextval, '서비스 이용 도중에 로그인창이 나옵니다.', 
'FOR REPORT에서는 로그인 이후30분동안 페이지 이동이 없으면 자동으로 로그아웃되도록 운영하고 있습니다.

회원님들의 안전한 개인정보보호를 위해 이와 같이 적용하고 있으니 서비스에 불편한 사항이 있더라도 양해해 주시기 바랍니다.

로그인창에서 REMEMBER ME를 체크 하시면 일주일동안 자동로그인이 됩니다.

※ 안전한 개인정보 보호를 위해 공공장소의 공용PC를 이용할 경우에는
반드시 로그아웃 버튼을 누르고 열려있는 인터넷창을 모두 닫아주시기 바랍니다.

웹브라우저(ex. Explorer, chrome 등 )에 회원님의 정보가 그대로 남아 있게 되어
다른 사람에게 개인정보가 노출될 수 있으니 주의해 주세요.

');
insert into tbl_question values(seq_question.nextval, '회원가입 후 회원정보를 변경하고 싶어요.', 
'회원님의 [마이페이지/로그인] -> [내 정보 수정]에서 언제든지 열람 또는 수정 할 수 있습니다.

연락처와 이메일 주소가 변경된 경우에도 반드시 변경된 정보로 수정을 해주셔야만 원활한 서비스 이용이 가능합니다. 이전 가입정보를 분실하여 서비스 이용에 제한을 받는 일이 없도록 최신정보로 업데이트해주시기 바랍니다.

');
insert into tbl_question values(seq_question.nextval, '회원가입 시 이메일주소가 이미 사용중이라고 나옵니다.', 
'회원님의 회원정보와 계좌정보는 비밀번호에 의해 보호되고 있습니다.
오직 사용자 본인만이 이러한 개인정보에 접속할 수 있도록 운영되고 있습니다.
비밀번호는 본인 외에 누구에게도 공유해서는 안됩니다.
FOR REPORT는 절대 전화나 이메일로 회원님의 비밀번호를 묻거나 하지 않습니다.
또한 직원에 의한 노출을 방지하기 위하여 회원님의 비밀번호를 암호화된 상태로 보관하고 있습니다.
서버에 접근하여 회원님의 비밀번호를 획득하였다 하더라도 암호화된 상태로 저장된 정보를 열어 볼 수 없습니다.
비밀번호를 분실하였을 때 회원님의 비밀번호를 처음 입력하신대로 보여드릴 수 없는 이유도 여기에 있습니다.

FOR REPORT 이용을 마칠 때에는 반드시 아이디 계정을 종료(Log out) 하고, 웹브라우져의 창을 닫아 주시기 바랍니다.
회원님이 다른 사람과 컴퓨터를 공유해서 사용하거나 PC방(인터넷카페), 도서관 같은 공공장소에서 이용하는 경우
다른 사람이 회원님의 개인정보 및 통신 내용을 함부로 볼 수 없도록 하기 위해서입니다.

FOR REPORT는 사용자 정보의 상실, 누출, 변경, 훼손 등을 방지하기 위하여 다음과 같은 기술적 대책을 마련하고 있습니다.

◈ 비밀번호 등을 이용한 보안장치
◈ 보안이 필요한 정보의 경우 암호알고리즘 등을 이용하여 네트워크상에 개인정보를 안전하게 전송 할 수 있는 보안장치
◈ 침입차단시스템(Firewall, IDS)등을 이용한 접근 통제장치
◈ 기타 안정성 확보를 위하여 필요한 기술적 장치

회원님이 FOR REPORT에 전송하거나, FOR REPORT로 제공되는 정보의 보안을 확실하게 보장할 수는 없습니다만, FOR REPORT는 회원님의 정보를 제공받으면 시스템에서 보안이 유지될 수 있도록 하기 위해 최선의 노력을 다할 것입니다.
');
insert into tbl_question values(seq_question.nextval, '본인인증이 뭔가요?', 
'FOR REPORT 가입 후 휴대폰 인증을 통해 본인인증을 할 수 있습니다.

정확한 가입정보 확인을 위하여 인증을 받고 있으며
본인인증회원에 한하여 FOR REPORT에서 진행되는 이벤트에 참여하실 수 있습니다.

- 동일한 휴대폰 번호로 최초 1회만 인증됩니다.
- 회원정보에 입력한 이름과 생년월일이 모두 다른 경우 변경이 불가능합니다.
- 본인명의의 휴대폰 번호가 없는 경우 인증이 불가능합니다.
');
insert into tbl_question values(seq_question.nextval, '탈퇴 시 수익금은 어떻게 되나요?', 
'잔액환불을 먼저 신청하지 않고 회원탈퇴를 진행하면 남아 있는 잔액은 모두 삭제되어 복구가 불가능합니다.

탈퇴 시 입금처리 하시고 확인 후 탈퇴를 부탁드립니다.
');
insert into tbl_question values(seq_question.nextval, '회원탈퇴 후에 재가입이 가능한가요?', 
'회원탈퇴가 완료되면 변칙사용 등을 방지하기 위해 탈퇴 후 3개월(자료를 판매한 경우는 6개월)동안 재가입이 제한되어 기존에 사용한 아이디와 이메일은 사용할 수 없습니다.

보관된 개인정보는 3개월(자료를 판매한 경우는 6개월)후에 완전히 삭제되며,
해당법규에 근거하여 상기의 목적이 아닌 다른 용도로 사용되지 않습니다.

만약 불가피한 사정으로 그 이전에 재가입 하셔야 하는 경우에는 기존 아이디와 생년월일,
휴대폰번호와 이메일주소를 기재하여 (forreport0202@google.com)로 접수해 주시면 관리자가 확인 후에 재가입 처리를 도와드립니다.

');
insert into tbl_question values(seq_question.nextval, '탈퇴한 회원의 개인정보는 언제까지 저장하고 있나요?', 
'회원탈퇴가 완료되면 변칙사용 등을 방지하기 위해 탈퇴 후 3개월(자료를 판매한 경우는 6개월)동안 재가입이 제한되어 해당 기간동안 개인정보가 별도로 보관됩니다.

보관된 개인정보는 3개월(자료를 판매한 경우는 6개월)후에 완전히 삭제되며,
해당법규에 근거하여 상기의 목적이 아닌 다른 용도로 사용되지 않습니다.
');
insert into tbl_question values(seq_question.nextval, '아이디와 비밀번호가 정확한데 로그인이 안돼요.', 
'정확한 아이디와 비밀번호를 입력했는데도 로그인이 안 되는 경우,
회원님의 웹브라우져 설정 때문일 수 있습니다. 우선 아래와 같이 조치를 취하시기 바랍니다.

[프록시 설정]
사용 인터넷 환경이 익스플로러인 경우로 상단메뉴의 [도구]→[인터넷옵션]→[연결]→[LAN설정]→[프록시서버] 부분에
프록시서버 사용에 체크(Check)되어있는지 확인 바랍니다.
체크되어 있다면체크를 해제(Uncheck)하시고 다시 로그인해주시기 바랍니다.

[SSL 설정]
ID와 비밀번호를 입력하고 로그인 했을 때"페이지를 표시할 수 없습니다. 검색할 페이지는 현재 사용할 수 없습니다.
웹 사이트에 기술적인 문제가 있거나 브라우저의 설정을 변경해야 합니다."라는 에러 페이지가 나오면 다음과 같이 옵션을 변경해주시기 바랍니다.
사용 인터넷 환경이 익스플로러인 경우로 상단메뉴의 [도구]→[인터넷옵션]→[고급]에서 보안 항목을 찾으신 후SSL 2.0과 SSL 3.0을 체크하시고 다시 로그인해주세요.

[쿠키설정]
로그인을 했는데도 첫페이지로 이동하는 경우에는 아래와 같이 설정하고, 인터넷 익스플로러를 모두 닫으신 후 새창으로 로그인해 주시기 바랍니다.

① 인터넷 익스플로러 상단 메뉴의 [도구]→[인터넷옵션]→[일반]→[임시인터넷 파일]→ 임시 인터넷파일, 쿠키, 기록
다운로드 기록, 양식 데이터 등을 삭제해주시기 바랍니다.
② 인터넷 익스플로러 상단 메뉴의 [도구]→[인터넷옵션]→[일반]→[임시인터넷 파일]→[설정]에서 [페이지를 열때마다]로 설정해주시기 바랍니다.
③ 인터넷 익스플로러 상단 메뉴의 [도구]→[인터넷옵션]→[보안]→[기본수준]→사용자 지정을 [보통]단계로 설정해주시기 바랍니다.
④ 인터넷 익스플로러 상단 메뉴의 [도구]→[인터넷옵션]→[개인정보]에서 [보통]단계로 설정해주시기 바랍니다.

안내드린데로 했는데도 지속적으로 로그인이 안되는 경우
(forreport0202@google.com)로 문의주시면 확인 후 안내드리겠습니다.
');
insert into tbl_question values(seq_question.nextval, '자료를 결제하는 방법을 알려주세요.', 
'FOR REPORT의 유료 자료를 이용하실 때는 장바구니에 원하시는 자료를 넣어주셔야합니다.
결제 시 원하시는 결제수단을 선택해 주세요. (무통장입금, 신용카드결제)

결제수단에 맞는 결제대행사 페이지가 열리며 순서에 따라 진행하면 결제가 완료됩니다.
');

-- tbl_notice 테이블에 가짜 데이터 추가
insert into tbl_notice values(seq_notice.nextval, 'FOR REPORT 오픈', 'FOR REPORT가 첫 오픈을 하였습니다.

FOR REPORT에 서비스에 서비스 불편이나 제안사항이 있으시면 
언제든지 (forreport0202@gmail.com) 제안/신고합니다 란에 적어주시면 저희가 조치하도록 하겠습니다. ', sysdate, sysdate);
insert into tbl_notice values(seq_notice.nextval, '네트워크 장애로 인한 서비스 점검', '안녕하세요? FOR REPORT 운영팀입니다.
2월2일 오전 3시30분부터 5시 30까지 해피캠퍼스 서버에 장애가 발생하여 점검을 합니다. 
신속한 복구가 이뤄지질 못한점 머리숙여 사과드립니다. 현재는 접속에 문제가 없습니다. 

접속되지 않는동안 피해를 입으신분들은 저희 해피캠퍼스로 연락주시면 조치하여 드리도록 하겠습니다.', sysdate, sysdate);