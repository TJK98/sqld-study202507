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
