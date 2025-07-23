-- USERS 테이블의 모든 컬럼과 모든 데이터를 조회한다.
select *
  from users;

-- USERS테이블에서 사용자이름과 이메일만 보고싶음
select username,
       email
  from users;

select email,
       username
  from users;

-- POSTS 테이블에서 게시물의 타입의 정보를 보고 싶음
select all post_type
  from posts;

-- DISTINCT : 중복값을 제거하고 조회
select distinct post_type
  from posts;

-- 열 별칭 정하기
select username as "사용자 이름",
       email as "이메일"
  from users;

-- AS 는 생략 가능
select username "사용자 이름",
       email "이메일"
  from users;

-- 띄어 쓰기가 없으면 따옴표 생략 가능
select username "사용자 이름",
       email 이메일
  from users;

-- 사용자이름에 추가 문자열을 연결해서 조회
-- '' : String, "" : Alias
select username || '님, 환영합니다!' as "환영인사말"
  from users;

select follower_id
       || '님이 '
       || following_id
       || '님을 팔로우합니다.'
  from follows;

-- 사용자의 이름과 가입일을 조합
select username
       || ' (가입일: '
       || registration_date
       || ')' as "사용자 정보"
  from users;
