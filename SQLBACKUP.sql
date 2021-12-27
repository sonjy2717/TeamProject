----------------------------------------------------------------------------
------------------------------2차 팀프로젝트--------------------------------
create user justcoding identified by 1234;
grant connect, resource to justcoding;

--1. 기존 테이블 삭제
drop table board;
drop table member;

--2. 보드 테이블 생성
create table board (
    idx number primary key, --인덱스
    id varchar2(10) not null,  --아이디(외래키)
    title varchar2(200) not null, --제목
    content varchar2(2000) not null, --내용
    postdate date default sysdate not null, --작성일
    ofile varchar2(200), --원본 파일
    sfile varchar2(30), --저장된 파일
    visitcount number(10), --조회수
    tname varchar2(10) --테이블 구별
);

--3. 멤버 테이블 생성
create table member (
    name varchar2(30) not null, --이름
    id varchar2(10) primary key, --아이디(외래키)
    pass varchar2(10) not null, --패스워드
    num varchar2(20), --전화번호
    phone_num varchar2(20) not null, --휴대전화
    email varchar2(50) not null, --이메일
    postcode number(10) not null, --우편번호
    basicadd varchar2(100) not null, --기본 주소
    detailadd varchar2(100) not null --상세 주소
);

--※ member테이블 날짜 컬럼 추가
alter table member add regidate date default sysdate not null;


--시퀀스 생성
create sequence seq_board_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

--4. 제약조건 설정(외래키)
ALTER TABLE board
   ADD constraint board_mem_fk --제약조건의 이름
   FOREIGN KEY (id)
   REFERENCES member (id);

--5. 더미 데이터 입력
insert into member values ('테스트1', 'test1', '1111', '02-1111-1111', 
    '010-1111-1111', 'test1@naver.com', 61085, '금천구', '가산동');
insert into member values ('테스트2', 'test2', '2222', '02-2222-2222', 
    '010-2222-2222', 'test2@gmail.com', 57382, '관악구', '봉천동');
insert into member values ('테스트3', 'test3', '3333', '02-3333-3333', 
    '010-3333-3333', 'test3@naver.com', 24584, '금천구', '독산동');
insert into member values ('테스트4', 'test4', '4444', '02-4444-4444', 
    '010-4444-4444', 'test4@naver.com', 21353, '금천구', '가산동');
--6. 더미 데이터 입력
insert into board (idx, id, title, content, postdate, visitcount, tname)
    values (seq_board_num.nextval, 'test1', '자유게시판', '내용1입니다', sysdate, 0, '자유');
insert into board (idx, id, title, content, postdate, visitcount, tname)
    values (seq_board_num.nextval, 'test1', '직원게시판', '내용1입니다', sysdate, 0, '직원');
insert into board (idx, id, title, content, postdate, visitcount, tname)
    values (seq_board_num.nextval, 'test1', '자료게시판', '내용1입니다', sysdate, 0, '자료');
insert into board (idx, id, title, content, postdate, visitcount, tname)
    values (seq_board_num.nextval, 'test1', '자료게시판', '내용1입니다', sysdate, 0, '자료');
insert into board (idx, id, title, content, postdate, visitcount, tname)
    values (seq_board_num.nextval, 'test1', '자료게시판', '내용1입니다', sysdate, 0, '자료');
insert into board (idx, id, title, content, postdate, visitcount, tname)
    values (seq_board_num.nextval, 'test1', '자료게시판', '내용1입니다', sysdate, 0, '자료');
insert into board (idx, id, title, content, postdate, visitcount)
    values (seq_board_num.nextval, 'test4', '제목4입니다', '내용4입니다', sysdate, 0);

--rownum확인 방법
select rownum from member;
select rownum from board;

--컬럼 추가 방법
alter table board add 컬럼명 number;
alter table board drop column 컬럼명;

select id, title, content, postdate, visitcount, sfile, ofile from board where tname='자료';

      ---------여기까지가 회의때 작성했던 기본 테이블 입니당---------
      
      
      
-------------------블루 클리닝, 체험학습 신청서 테이블----------------------
-- 테이블 삭제시 사용
drop table blue_cleaning;
-- 블루클리닝 견적의뢰 테이블 생성
create table blue_cleaning (
    id varchar2(10) primary key,  --아이디
    name varchar2(100) not null, --고객명/회사명
    bc_postcode number(10) not null, --우편번호
    bc_basicadd varchar2(100) not null, --기본 주소
    bc_detailadd varchar2(100) not null, --상세 주소
    phone_num varchar2(30) not null, --연락처
    email varchar2(50) not null, --이메일
    bc_type varchar2(200) not null, --청소종류
    bc_space number not null, --평수
    bc_date varchar2(10) not null, --청소 희망날짜
    regi_type varchar2(20) not null, --접수종류 구분
    note varchar2(200) --기타 특이사항
);
--제약조건 설정(외래키)
ALTER TABLE blue_cleaning
   ADD constraint bc_mem_fk --제약조건의 이름
   FOREIGN KEY (id)
   REFERENCES member (id);

--더미 데이터
insert into blue_cleaning
    values ('test1', '회사명1', 11111, '기본주소1', '상세주소1', '010-1111-1111', 'test1@naver.com',
            '청소종류1', 111, '2022-01-01', '예약신청', '기타 특이사항1');
insert into blue_cleaning
    values ('test2', '회사명2', 22222, '기본주소2', '상세주소2', '010-2222-2222', 'test2@naver.com',
            '청소종류2', 222, '2022-02-02', '견적문의', '기타 특이사항2');


-- 테이블 삭제시 사용
drop table field_trip;
-- 체험학습 신청 테이블 생성
create table field_trip (
    id varchar2(10) primary key,  --아이디
    name varchar2(100) not null, --고객명/회사명
    phone_num varchar2(30) not null, --연락처
    email varchar2(50) not null, --이메일
    ft_cake number not null,--케익체험 인원수
    ft_cookie number not null,--쿠키체험 인원수
    ft_date varchar2(10) not null, --체험 희망날짜
    regi_type number not null, --접수종류 구분
    note varchar2(200) --기타 특이사항
);
--제약조건 설정(외래키)
ALTER TABLE field_trip
   ADD constraint ft_mem_fk --제약조건의 이름
   FOREIGN KEY (id)
   REFERENCES member (id);
   
--더미 데이터
insert into field_trip
    values ('test1', '회사명1', '010-1111-1111', 'test1@naver.com',
            1, 1, '2022-01-01', 1, '기타 특이사항1');
insert into field_trip
    values ('test2', '회사명2', '010-2222-2222', 'test2@naver.com',
            2, 2, '2022-02-02', 2, '기타 특이사항2');

--------------------쇼핑몰 구현 테이블----------------------

--상품관리 테이블
drop table management;
drop table orderform;

--장바구니 테이블
create table management (
    idx varchar2(10) primary key, --일련번호
    name varchar2(30) not null, --상품명
    price number(10) not null, --가격
    point number(10) not null, --적립금
    count number(5) --수량
);

--더미 데이터
insert into management (idx, name, price, point) values ('C01', '의자', 38000, 380);
insert into management (idx, name, price, point) values ('D01', '책상', 99000, 990);
insert into management (idx, name, price, point) values ('C02', '의자2', 38000, 380);
insert into management (idx, name, price, point) values ('D02', '책상2', 99000, 990);
insert into management (idx, name, price, point) values ('C03', '의자3', 38000, 380);
insert into management (idx, name, price, point) values ('D03', '책상3', 99000, 990);
insert into management (idx, name, price, point) values ('C04', '의자4', 38000, 380);
insert into management (idx, name, price, point) values ('D04', '책상4', 99000, 990);

--상품주문서 테이블
create table orderform (
    idx varchar2(10) primary key, --상품 일련번호
    name varchar2(30) not null, --주문자 성명
    location varchar2(30) not null, --배송지 정보
    phone_num varchar2(20) not null, -- 핸드폰
    email varchar2(50) not null, --이메일
    message varchar2(50), --배송메세지
    payment number(5) not null --결제방법
);

--더미 데이터
insert into orderform 
    values ('C01', '손준영', '금천구', '010-2700-1733', 'sonjy2717@naver.com', '배송메세지', 1);
insert into orderform 
    values ('D01', '이지현', '관악구', '010-9597-6450', 'jihyun@naver.com', '배송메세지', 2);
   
commit;

ALTER TABLE orderform
   ADD constraint order_manage_fk
   FOREIGN KEY (idx)
   REFERENCES management (idx);

select rownum from management;
SELECT * FROM (SELECT Tb.*, ROWNUM rNum FROM (SELECT * FROM management ORDER BY idx DESC)Tb) WHERE rNum BETWEEN 4 AND 6;
SELECT * FROM ( SELECT Tb.*, ROWNUM rNum FROM ( SELECT * FROM management ORDER BY idx DESC ) Tb);
select to_char(price, '999,999,999') from management;

SELECT * FROM 
    (SELECT Tb.*, ROWNUM rNum FROM 
        (SELECT idx, name, to_char(price, '999,999,999'), 
        to_char(point, '999,999,999'), count FROM management ORDER BY idx DESC)Tb) 
WHERE rNum BETWEEN 4 AND 6;

SELECT idx, name, to_char(price, '999,999,999'), to_char(point, '999,999,999'), count FROM management WHERE idx='D04';
----------------------------------------------------------------------------

commit;