use goot6;
commit;

-- 회원 테이블 생성
CREATE TABLE `member` (
  `userid` varchar(10) NOT NULL,
  `password` varchar(45) NOT NULL,
  `name` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `userimg` varchar(100) DEFAULT NULL,
  `isadmin` varchar(2) DEFAULT 'N',
  `registerDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 회원 가입

insert into member(userid, password, name, email, userimg)
 values('dooly', sha1(md5('1234')), '둘리', 'dooly@dooly.com', 'images/dooly.png');


-- 전체 회원 보기
select * from member;

-- 패스워드 암호화
select sha1(md5('1234'));

update member set password=(select sha1(md5('1234'))) where userid='aaa';

-- 로그인 처리
select * from member where userid='dooly' and password = sha1(md5('1234'));

-- 멤버 포인트 테이블 생성
create table memberpoint
(
userid varchar(10),
dowhen datetime default current_timestamp, 
howmuch int,
why varchar(20),
constraint memberpoint_userid_fk foreign key(userid) references member(userid)
);

-- 회원 가입시 100포인트 지급
insert into memberpoint(userid, howmuch, why) values(?, 100, '회원가입');

-- 멤버 포인트 테이블 출력
select * from memberpoint;

-- 회원 정보는 세션에 있고, 멤버 포인트를 가져오는 쿼리
select * from memberpoint where userid='aaa' order by dowhen desc;

-- 회원 정보 수정 페이지에서 기존 비밀번호가 같은지 비교
select * from member where userid='' and password = sha1(md5(''));

-- 비밀번호 이력 보관하기 위한 table
create table pwd_hist
(
userid varchar(10),
oldpwd varchar(45) not null,
changedate datetime default current_timestamp,
foreign key (userid) references member(userid));

-- 비밀번호 이력 조회
select * from pwd_hist;

insert into pwd_hist(userid, oldpwd) values('aaa', '1234');

-- 회원 정보 수정
-- [1] 이미지가 업로드 되었을때(이미지까지 수정)
update member set password=sha1(md5(?)), name=?, email=?, userimg=? where userid=?

-- [2] 이미지 업로드 되지 않았을 때 (이미지를 빼고 수정)
update member set password=sha1(md5(?)), name=?, email=? where userid=?

-- 로그인한 회원 정보를 얻어오는 
select * from member where userid=?;

-- 게시판 테이블 생성
CREATE TABLE `board` (
  `no` int NOT NULL AUTO_INCREMENT,  -- 글번호
  `title` varchar(20) NOT NULL,  -- 글 제목
  `writer` varchar(10) NOT NULL,  -- 글쓴이
  `postdate` datetime DEFAULT CURRENT_TIMESTAMP, -- 작성일
  `readcount` int DEFAULT '0',  -- 조회수
  `likecount` int DEFAULT '0',  -- 좋아요 수
  `pwd` varchar(45) DEFAULT NULL,  -- 글 수정/삭제를 위한 비밀번호
  `content` varchar(500) DEFAULT NULL,  -- 글 내용
  `image` varchar(45) DEFAULT NULL, -- 게시물 이미지
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 게시판에 글 저장 
insert into board(title, writer, pwd, content, image) 
values('아싸~ 일빠!', 'aaa', '1234', '냉 무~', 'images/dooly.png');

-- 게시판 조회
select * from board order by no desc;

-- 상세 글 조회
select * from board where no = ?;

-- 조회수 증가 쿼리
update board set readcount = ? where no = ?;

-- 조회수 처리를 위한 테이블 생성
CREATE TABLE `readcountprocess` (
  `ipaddress` varchar(30) NOT NULL,
  `readno` int DEFAULT NULL,
  `readtime` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from readcountprocess;

insert into readcountprocess(ipaddress, readno) values('211.197.18.247', 1);

alter table readcountprocess
add constraint foreign key(readno) references board(no);

-- 상세글 조회시 조회수 부정 증가 방지를 위한 insert
insert into readcountprocess(ipaddress, readno) values(?, ?);


update readcountprocess set readtime='2021-08-22 16:13:08';

-- 상세글 조회시 조회한지 하루가 지났는지 여부 확인 하기 위해 시간 얻어옴
select max(readtime) from readcountprocess where ipaddress = '211.197.18.247' and readno = 1;

select * from readcountprocess where ipaddress = '211.197.18.247' and readno = 2;

-- 조회 기록 update
update readcountprocess 
set readtime=current_timestamp() where ipaddress = '211.197.18.247' and readno = 1; 

-- 좋아요 처리를 위한 테이블
CREATE TABLE `likehistory` (
  `userid` varchar(10) NOT NULL,
  `no` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from likehistory;

-- 좋아요 버튼 클릭시
insert into likehistory values('aaa', 8);

-- 좋아요 수 업데이트
update board set likecount = likecount + 1 where no = 8;

-- 좋아요를 눌렀던 글인지 여부 가져오기
select * from likehistory where userid='aaa' and no = 8;

-- 안 좋아요 버튼 클릭시 히스토리 삭제
delete from likehistory where userid=? and no=?;

-- 마이페이지에서 내가 좋아요 한 글 조회
select * from board where no in
(select no from likehistory where userid='aaa');


-- 마이페이지에서 내가 작성 한 글 조회
select * from board where writer = 'aaa';


-- 몇 번 글에 대해 좋아요 한 사람 리스트 뽑기
select userid from likehistory where no = 11;

-- 최신 게시물 5개 가져오기
select * from board order by postdate desc limit 5;

-- 잉끼글 게시물 5개 가져오기
select * from board order by likecount desc limit 5;


-- 최신 이미지 5장 가져오기(index.jsp 페이지에서 슬라이드)
select image from board where image <> '' order by postdate desc limit 5;


-------------------------------------------------------------------------------------------------
-- 게시판 답글 처리
--------------------------------------------------------------------------------------------------
alter table board
add ref int default 0; -- 참조 번호(replyBoard부모글)

alter table board
add step int default 0; -- 답변 깊이(레벨)

alter table board
add reforder int default 0; -- 답변을 보여주는 정렬을 위한 컬럼


-- 답글 저장하는 저장 프로시저
CREATE DEFINER=`root`@`localhost` PROCEDURE `replyBoard`(
	in in_title varchar(50),
    in in_writer varchar(10),
    in in_content varchar(2000),
    in in_ref int,
    in in_step int,
    in in_reforder int,
    out output int -- 아웃 매개변수
)
BEGIN
-- 아래의 쿼리문을 수행하다 예외가 발생하면 output = -1 대입
declare continue handler for sqlexception set output = -1;
start transaction; -- 트랜잭션 처리 시작
	update board set reforder = reforder + 1 where ref = in_ref and reforder > in_reforder;
    
	insert into board(title, writer, content, ref, step, reforder)
     values(in_title, in_writer, in_content, in_ref, in_step + 1, in_reforder + 1);
     
if output = -1 then
	rollback;
else 
	commit;
end if;
END



-- 글 작성시 ref까지 함께 저장 (ref 얻어오기)
select max(no)+1 as nextref from board;


-- 글 작성 쿼리문 수정
insert into board(title, writer, pwd, content, image, ref) values(?, ?, ?, ?, ?, ?);

-- 게시판을 전체 목록을 불러올때
SELECT * FROM goot6.board order by ref desc, reforder asc;

---------------------------------------------------------------------------
-- 페이징 쿼리문
---------------------------------------------------------------------------
-- 쿼리스트링에서 현재 페이지를 얻어온다 (단, 현재 페이지가 없다면 1 페이지로 처리 한다)

-- 한 페이지 당 보여줄 글의 갯수 3
-- 전체 페이지 수 : 전체 글의 갯수 / 페이지당 보여줄 글의 갯수(나누어 떨어지지 않았다면 + 1)
-- 전체 글 갯수 : 22 / 3 = 7 이지만, 나누어 떨어지지 않았으므로 
-- 전체 페이지 수 : 7 + 1 = 8

-- x번 째 페이지에서 출력시작할 번호 : (현재페이지번호 - 1) * 한 페이지당 보여줄 글의 갯수
-- 1 페이지 : 1 - 1 * 3 = 0
-- 2 페이지 : 2 - 1 * 3 = 3
-- 3 페이지 : 3 - 1 * 3 = 6
-- 8 페이지 : 8 - 1 * 3 = 21
select count(*) as cnt from board; -- 전체 글 수 24

select * from board order by ref desc, reforder asc limit 시작글번호, 페이지당 보여줄 글의 갯수;

-- 페이징 블록 : 2
-- 1페이징 블록 : 1 ~ 2page
-- 2페이징 블록 : 3 ~ 4page
-- 3페이징 블록 : 5 ~ 6page
-- 4페이징 블록 : 7 ~ 8page

-- 전체 페이징블록 수 = 전체페이지수 / 페이징 블록 (나누어 떨어지지 않으면 + 1)
-- * 현재 페이징 블록 = 현재페이지번호 / 페이징블록 (올림)
-- 현재 페이지 블록 : 4페이지 라면, 4 / 2 = 2
-- * 현재 페이징 블록의 시작페이지번호 = ((현재 페이징 블록 - 1) * 페이징블록) + 1
-- (2 - 1) * 2 + 1 = 3
-- * 현재 페이징 블록의 끝 페이지 번호 = (현재 페이징 블록시작페이지 번호 + 페이징블록) - 1
-- (3 + 2) -1 : 4


---------------------------------------------------------------------------------------------
-- 게시판 검색
--------------------------------------------------------------------------------------------
-- 제목으로 검색
select * from goot6.board where title like '%백신%' order by ref desc, reforder asc limit 3, 3;

-- 작성자로 검색
select * from goot6.board where writer like '%aaa%' order by ref desc, reforder asc limit 0, 3;

-- 내용으로 검색
select * from goot6.board where content like '%백신%' order by ref desc, reforder asc limit 0, 3;

select * from goot6.board 
where title like concat(concat('%', '백신'), '%') order by ref desc, reforder asc limit 3, 3;

select * from goot6.board 
where ? like concat(concat('%', ?), '%') order by ref desc, reforder asc limit ?, ?;

select count(*) from goot6.board where title like '%백신%';