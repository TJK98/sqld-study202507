-- *은 모든 컬럼을 의미한다.
-- 테이블의 모든 컬럼을 조회할 때 사용
-- USERS 테이블의 모든 컬럼과 모든 데이터를 조회한다.
-- 실무에서는 *을 사용하지 않는 것이 좋다. 다 필요하더라도 명시적으로 열을 지정하는 것이 좋다.
select *
  from users;

-- USERS 테이블에서 사용자이름과 이메일만 보고싶음
-- FROM 먼저 해석하는 게 중요
select username,
       email
  from users;

-- 순서가 바껴도 상관없음. 열의 순서만 달라진다. 결과의 값은 동일
select email,
       username
  from users;

-- POSTS 테이블에서 게시물의 타입의 정보를 보고 싶음.
-- SELECT 뒤에는 ALL이 숨겨져 있다. (ALL은 생략 가능, 중복을 포함하여 조회)
select all post_type
  from posts;

-- DISTINCT : 중복값을 제거하고 조회
-- 안 쓰면 ALL로 중복값을 포함하여 조회
select distinct post_type
  from posts;

-- 열 별칭 정하기
select username as "사용자 이름",
       email as "이메일"
  from users;

-- AS는 생략 가능
select username "사용자 이름",
       email "이메일"
  from users;

-- 띄어 쓰기가 없으면 따옴표 생략 가능
select username "사용자 이름", -- 띄어쓰기 있어서 따옴표 필요
       email 이메일 -- 띄어쓰기 없어서 따옴표 생략 가능
  from users;

-- 사용자이름에 추가 문자열을 연결해서 조회
-- '' : 문자열 (String), "" : 별칭 (Alias)
select username || '님, 환영합니다!' as "환영인사말" -- 파이프 연산자 ||, ORACLE에서만 가능한 연산자, ''는 문자열
  from users;

select follower_id
       || '님이 ' -- follewer_id와 문자열을 연결
       || following_id
       || '님을 팔로우합니다.' -- following_id와 문자열을 연결
  from follows;

-- 사용자의 이름과 가입일을 조합
select username
       || ' (가입일: ' -- registration_date와 문자열을 연결
       || registration_date
       || ')' as "사용자 정보"
  from users;
