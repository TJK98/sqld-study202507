-- 사용자이름이 'ryan'인 사용자의 모든 주문을 조회하는 쿼리
select *
  from users
 where username = 'ryan';

-- 유저의 아이디가 1번인 사용자가 올린 비디오 게시물
select *
  from posts
 where user_id = 1
   and post_type = 'video';

-- 유저아이디가 1번인 유저의 모든 피드게시물 또는 모든 유저의 비디오 게시물
select *
  from posts
 where user_id = 1
    or post_type = 'video';

select *
  from posts
 where user_id <> 1;

-- 가입일이 2022년도인 사용자를 찾기
select *
  from users
 where registration_date >= to_date('2022-01-01','YYYY-MM-DD')
   and registration_date <= to_date('2022-12-31','YYYY-MM-DD');

-- BETWEEN A AND B
-- A와 B 사이의 값을 조회 (이상 이하 개념)
select *
  from users
 where registration_date between to_date('2022-01-01','YYYY-MM-DD') and to_date('2022-12-31','YYYY-MM-DD');

-- 가입일이 2022년도가 아닌 사용자를 찾기
-- NOT BETWEEN A AND B
-- A와 B 사이의 값을 제외한 나머지 값을 조회 (이상 이하 개념)
select *
  from users
 where registration_date not between to_date('2022-01-01','YYYY-MM-DD') and to_date('2022-12-31','YYYY-MM-DD');


-- 유저 아이디가 1 또는 9 또는 21인 사용자 정보 조회
select *
  from users
 where user_id = 1
    or user_id = 9
    or user_id = 21;

-- IN : 특정 값의 집합에 포함되는지 확인
select *
  from users
 where user_id in ( 1,
                    9,
                    21 );

-- NOT IN : 특정 값의 집합에 포함되지 않는지 확인
select *
  from users
 where user_id not in ( 1,
                        9,
                        21 );

-- LIKE : 특정 패턴과 일치하는 값을 조회
-- % : 0개 이상의 문자
-- _ : 1개의 문자
-- USERNAME이 'p'으로 시작하는 사용자 조회
select *
  from users
 where username like 'p%';

select *
  from users
 where username like '%chu';

select *
  from users
 where username like 'r_an' -- ryan, roan, rian
 ;

-- 해시태그에서 일상이 들어간 해시태그 전체조회
select *
  from hashtags
 where tag_name like '%일상%';

-- manager_id가 null인 사용자 조회
select *
  from users
 where manager_id is null;

-- IS NULL의 반대는 NOT IS NULL이 아니라 IS NOT NULL
select *
  from users
 where manager_id is not null;
