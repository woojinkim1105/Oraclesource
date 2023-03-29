-- javadb

-- userTBL 테이블 생성
-- no(번호- 숫자(4)), username(이름-한글(4)), birthYear(년도-숫자(4)), addr(주소-문자(한글,숫자)), mobile(010-1234-1234)
-- no pk 제약조건 지정(제약조건명 pk_userTBL)

create table userTBL(
    no number(4) CONSTRAINT pk_userTBL PRIMARY KEY,
    username NVARCHAR2(10) not null,    --varchar2(20)
    birthYear number(4) not null,               
    addr nvarchar2(50) not null,                 --varchar2(20)
    mobile nvarchar2(12));                       --varchar2(20)


-- 시퀀스 생성
-- user_seq 생성(기본)

create sequence user_seq;


-- insert 
-- no : user_seq 값 넣기
INSERT INTO userTBL(no, username, birthYear, addr, mobile)
VALUES(user_seq.NEXTVAL, '홍길동', 2010, '서울시 종로구 123', '010-1234-5678');

-- paytype : pay_no(숫자-1), info(문자-card, cash)
-- paytype_seq 생성

CREATE TABLE paytype(
    pay_no number(1) PRIMARY KEY,
    info varchar2(10) not null);

CREATE SEQUENCE paytype_seq;

INSERT INTO paytype values(paytype_seq.NEXTVAL, 'card');
INSERT INTO paytype values(paytype_seq.NEXTVAL, 'cash');

SELECT * FROM paytype; -- 1: card, 2: cash

--shop
--suser : user_id(숫자-4) , name(문자-한글), pay_no(숫자 -1 : paytype 테이블에 있는 pay_no 참조해서 사용)
CREATE TABLE suser(
    user_id number(4) PRIMARY KEY,
    name varchar2(20) not null,
    pay_no number(1) not null references paytype(pay_no));

-- product
-- product_id(숫자-8), pname(문자), price(숫자), content(문자)
CREATE TABLE product(
    product_id number(8) PRIMARY KEY,
    pname varchar2(30) not null,
    price number(8) NOT NULL,
    content varchar2(50));
    
CREATE SEQUENCE product_seq;

-- sorder
--order_id(숫자-8), user_id(user 테이블의 user_id 참조), product_id(product 테이블의 product_id 참조)
--order_seq 생성

CREATE TABLE sorder(
    order_id number(8) PRIMARY KEY,
    user_id number(4) NOT NULL REFERENCES suser(user_id),
    product_id number(8) NOT NULL REFERENCES product(product_id)
);

ALTER TABLE sorder ADD order_date DATE; --구매날짜

CREATE SEQUENCE order_seq;

INSERT INTO sorder VALUES(order_seq.nextval, 물건을 구매한id, 상품id, sysdate);



--user_id, name, pay_no, info 조회
-- suser와 paytype join 
























ㄴ