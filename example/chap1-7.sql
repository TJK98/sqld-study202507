drop table employees;
drop table departments;

-- 1. 부서 테이블 (DEPARTMENTS) 생성
create table departments (
   id   number primary key,
   name varchar2(50) not null
);

-- 2. 사원 테이블 (EMPLOYEES) 생성
create table employees (
   id      number primary key,
   name    varchar2(50) not null,
   dept_id number -- DEPARTMENTS 테이블의 id를 참조할 연결고리
);


-- 3. 각 테이블에 예시 데이터 삽입
-- 부서 테이블에는 3개의 부서를 넣어봅시다.
insert into departments (
   id,
   name
) values ( 10,
           '기획팀' );
insert into departments (
   id,
   name
) values ( 20,
           '개발팀' );
insert into departments (
   id,
   name
) values ( 30,
           '디자인팀' );


-- 사원 테이블에는 4명의 사원을 넣어봅시다.
insert into employees (
   id,
   name,
   dept_id
) values ( 101,
           '김철수',
           10 );  -- 기획팀
insert into employees (
   id,
   name,
   dept_id
) values ( 102,
           '박영희',
           20 );  -- 기획팀
insert into employees (
   id,
   name,
   dept_id
) values ( 103,
           '이지은',
           20 );  -- 기획팀
insert into employees (
   id,
   name,
   dept_id
) values ( 104,
           '최민준',
           30 );  -- 기획팀

-- 단순 테이블 조회
select *
  from employees;

select *
  from departments;

-- oracle JOIN 문법
-- JOIN은 두 테이블을 가로로 합치는 문법
-- x * y 형태로, x는 EMPLOYEES 테이블의 행 수, y는 DEPARTMENTS 테이블의 행 수가 됩니다.
select e.id,
       e.name,
       d.id,
       d.name
  from employees e,
       departments d
 where e.dept_id = d.id; -- Inner JOIN, EMPLOYEES 테이블의 dept_id와 DEPARTMENTS 테이블의 id가 같은 행만 조회합니다.

-- 표준 JOIN
select e.id,
       e.name,
       d.id,
       d.name
  from employees e
  join departments d
on e.dept_id = d.id;


-- 피드 조회 (피드 번호, 회원 이름, 회원 이메일, 피드 내용)
select p.post_id,
       u.username,
       u.email,
       p.content
  from posts p
 inner join users u
on p.user_id = u.user_id;


-- 해시 태그 테이블 조회
select *
  from hashtags;
select *
  from post_tags;

-- 1001번 해시태그가 붙은 게시물을 조회
select pt.post_id,
       p.content,
       h.tag_name
  from post_tags pt,
       hashtags h,
       posts p
 where pt.tag_id = h.tag_id
   and pt.post_id = p.post_id
   and h.tag_name like '%일상%'
 order by pt.post_id;

 -- 일상 해시태그가 붙은 게시물의 ID, 내용, 해시 태그 이름을 조회
 -- 표준 JOIN
select pt.post_id,
       p.content,
       h.tag_name
  from post_tags pt
 inner join hashtags h
on pt.tag_id = h.tag_id
 inner join posts p
on pt.post_id = p.post_id
 where pt.tag_id = h.tag_id
   and pt.post_id = p.post_id
   and h.tag_name like '%일상%'
 order by pt.post_id;

-- 댓글 테이블 조회
select *
  from comments;
select *
  from posts;

-- 댓글과 게시물의 피드의 내용을 함께 조회

-- 오라클 조인, 표준 조인 (데이터 베이스에 따른 분류)
-- 내부 조인, 외부 조인 (데이터 베이스와 관계없이 분류)

-- 오라클 조인
select p.post_id,
       p.content,
       p.view_count,
       to_char(
          p.creation_date,
          'YYYY-MM-DD HH24:MI:SS'
       ) as created_at,
       c.comment_text
  from posts p,
       comments c
 where p.post_id = c.post_id;

-- 표준 조인
select p.post_id,
       p.content,
       p.view_count,
       to_char(
          p.creation_date,
          'YYYY-MM-DD HH24:MI:SS'
       ) as created_at,
       c.comment_text
  from posts p
 inner join comments c
on p.post_id = c.post_id;

select p.user_id,
       u.username,
       p.post_id,
       p.content,
       p.view_count,
       to_char(
          p.creation_date,
          'YYYY-MM-DD'
       ) as created_at,
       c.user_id,
       u2.username as commenter,
       c.comment_text
  from posts p
 inner join comments c
on p.post_id = c.post_id
 inner join users u
on p.user_id = u.user_id
 inner join users u2
on c.user_id = u2.user_id;

-- OUTER JOIN
select *
  from users;          -- 필수정보
select *
  from user_profiles;  -- 선택정보

-- INNER JOIN의 문제점: 값이 매칭되는 경우만 조회되므로
-- 상세프로필을 안적은 회원은 나타나지 않음.
select u.user_id,
       u.username,
       u.email,
       up.full_name,
       up.bio
  from users u
 inner join user_profiles up
on u.user_id = up.user_id;


-- 우선 회원정보는 모두 조회하고 단, 상세프로필이 있으면 걔네만 같이조회해라
select *
  from users u
  left outer join user_profiles up
on u.user_id = up.user_id
 order by u.user_id;

-- 오라클 외부 조인: LEFT -> 오른쪽 조건에 (+), RIGHT -> 왼쪽 조건에 (+)
select *
  from users u,
       user_profiles up
 where u.user_id = up.user_id (+)
 order by u.user_id;
