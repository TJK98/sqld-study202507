-- 1. POSTS 테이블에 숫자 타입의 view_count 컬럼을 추가합니다.
alter table posts add (
   view_count number
);

-- 2. 모든 게시물에 100 ~ 50000 사이의 임의의 조회수 데이터를 넣어줍니다.
update posts
   set
   view_count = trunc(dbms_random.value(
      100,
      50000
   ));

-- 3. 변경사항을 최종 저장합니다.
commit;

select *
  from posts;

select count(*)
  from users;

select username
  from users;

select count(username)
  from users;

-- 모든 집계함수는 NULL 값을 무시합니다.
select count(manager_id)
  from users;

-- POSTS 테이블에서 view_count의 최솟값과 최댓값을 찾습니다.
select min(view_count) as "최저 조회수",
       max(view_count) as "최고 조회수"
  from posts;

-- 모든 게시물의 view_count를 합산합니다.
select sum(view_count) as "총 조회수"
  from posts;

select view_count
  from posts;

update posts
   set
   view_count = null
 where post_id = 2;

select sum(view_count)
  from posts
 where post_id between 1 and 3;

select avg(view_count) as "평균 조회수",
       sum(view_count) as "총 조회수",
       count(view_count) as "게시물 수"
  from posts
 where post_id between 1 and 3;

select count(*) as "총 댓글수"
  from comments;

-- 유저별로 피드를 몇개씩 썼는지 알고 싶다.
select *
  from posts;

select user_id,
       count(*) as "유저별 피드 수"
  from posts
 group by user_id -- USER_ID가 같은 게시물끼리 묶는다.
 order by user_id;

select user_id,
       post_type,
       content
  from posts
 order by user_id,
          post_type;

select user_id,
       post_type,
       count(*) as "유저의 종류별 피드 수"
  from posts
 group by user_id,
          post_type -- USER_ID와 POST_TYPE이 같은 게시물끼리 묶는다.
 order by user_id;

select user_id,
       count(*) as post_count
  from posts
 group by user_id
having count(*) >= 10 -- 게시물을 10개 이상 쓴 사용자만 조회
;

-- POSTS 테이블에서 장문(20글자이상)의 피드를 쓴 게시물들의 개수를 보고 싶다.
-- 유저별로 보고싶음
select user_id,
       count(*) as "장문 게시물 수"
  from posts
 where length(content) >= 30
 group by user_id
having count(*) >= 5 -- 장문 게시물을 쓴 사용자만 조회
; -- LENGTH 함수로 글자 수를 계산합니다.


select post_id,
       count(*) as like_count
  from likes
 where creation_date >= to_date('2024-01-01','YYYY-MM-DD') -- 1. 개별 '좋아요' 데이터를 먼저 필터링
 group by post_id -- 2. 게시물 ID 별로 그룹화
having count(*) >= 20; -- 3. 그룹별 '좋아요' 수가 20개 이상인 그룹만 필터링
