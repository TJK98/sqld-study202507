-- USERS 테이블에서 username을 다양한 형태로 변환해봅시다.
select username,
       upper(username) as "대문자로 변환",
       lower(username) as "소문자로 변환",
       initcap(username) as "첫 글자만 대문자"
  from users
 where user_id in ( 1,
                    9,
                    21 ); -- 라이언, 헬로키티, 피카츄만 예시로 볼게요!

-- USER_PROFILES 테이블에서 자기소개의 길이와 특정 단어의 위치를 찾아봅시다.
select user_id,
       bio,
       length(bio) as "자기소개 길이",
       instr(
          bio,
          '고양이'
       ) as "'고양이'의 위치"
  from user_profiles
 where user_id in ( 2,
                    8 ); -- 춘식이와 네오의 프로필을 예시로 볼게요!


-- COMMENTS 테이블에서 댓글 미리보기를 만들어봅시다.
-- comment_text.substring(0, 10)
select comment_text as "원본 댓글",
       substr(
          comment_text,
          1,
          10
       )
       || '...' as "댓글 미리보기",
       concat(
          user_id,
          '번 사용자의 댓글'
       ) as "작성자 정보",
       user_id || '번 사용자의 댓글' as "작성자 정보 (|| 연산자)"
  from comments
 where comment_id = 20001; -- "춘식이 너무 귀여워요! >_<" 댓글을 예시로 볼게요!



select lpad(
   u.user_id,
   5,
   '0'
) as "5자리 사용자 ID",
       rpad(
          u.username,
          15,
          '*'
       ) as "오른쪽 채우기",
       replace(
          p.content,
          '#일상',
          '#데일리'
       ) as "해시태그 교체",
       p.content as "원본 게시글"
  from users u,
       posts p
 where u.user_id = p.user_id
   and p.content like '%일상%';


-- 가상의 인기 점수를 만들고, user_id를 이용해 짝/홀수를 구분해봅시다.
select user_id,
    -- 가상의 인기 점수 (3.141592)
       round(
          3.141592,
          4
       ) as "인기점수 (반올림)",
       trunc(
          3.141592,
          4
       ) as "인기점수 (버림)",
       ceil(3.14) as "인기점수 (올림)",
       floor(3.14) as "인기점수 (내림)",
       mod(
          user_id,
          2
       ) as "짝홀 구분 (0이면 짝수, 1이면 홀수)"
  from users
 where user_id between 1 and 5; -- 1~5번 사용자만 예시로 볼게요!


-- 1번 게시물이 등록된 시점을 기준으로 날짜 연산을 해봅시다.
-- SYSDATE는 현재 시스템의 날짜와 시간을 반환하는 함수입니다.
select creation_date as "게시물 등록 시각",
       creation_date + 1 as "24시간 뒤 (하루 뒤)",
       creation_date + ( 1 / 24 ) as "1시간 뒤",
       sysdate - creation_date as "등록 후 흐른 시간 (일 단위)"
  from posts
 where post_id = 1;

  -- TO_CHAR 함수로 날짜를 예쁜 문자로 바꿔봅시다.
select username,
       registration_date,
       to_char(
          registration_date,
          'YYYY"년" MM"월" DD"일" MI"분"'
       ) as "가입일 (상세)",
       to_char(
          registration_date,
          'YYYY-MM-DD (DY)'
       ) as "가입일 (요일포함)"
  from users
 where user_id = 1; -- 1번 사용자 '라이언'을 예시로 볼게요!

-- TO_DATE 함수로 문자열을 날짜로 바꿔서 WHERE절에 사용해봅시다.
select *
  from posts
 where creation_date > to_date('2024-05-20','YYYY-MM-DD');

-- 춘식이(bio 있음)와 케로피(bio 없음)의 프로필을 예시로 NULL 함수를 써봅시다.

select u.username,
       p.bio,
       nvl(
          p.bio,
          '자기소개가 없습니다.'
       ) as "NVL 처리",
       nvl2(
          p.bio,
          '✅ 프로필 있음',
          '❌ 프로필 없음'
       ) as "NVL2 처리"
  from users u,
       user_profiles p
 where u.user_id = p.user_id (+)
   and u.user_id in ( 2,
                      14 );


select nullif(
   '손흥민',
   '손흥민'
) as "NULLIF 예시",
       nullif(
          '손흥민',
          '박지성'
       ) as "NULLIF 예시 (같은 값)"
  from dual;

select coalesce(
   null,
   null,
   50,
   100,
   999,
   1000
) a,
       coalesce(
          900,
          null,
          null,
          100
       ) b,
       coalesce(
          null,
          888,
          50,
          null
       ) c
  from dual;

-- 가입 연도에 따라 등급을 나누고, 게시물 종류를 한글로 바꿔봅시다.
select username,
       registration_date,
       case
          when to_char(
             registration_date,
             'YYYY'
          ) >= '2023' then
             '🌱 새싹 유저'
          when to_char(
             registration_date,
             'YYYY'
          ) >= '2021' then
             '🌳 기존 유저'
          else
             '💎 고인물 유저'
       end as "유저 등급",
       p.post_type,
       case p.post_type
          when 'photo' then
             '사진'
          when 'video' then
             '영상'
          else
             '기타'
       end as "게시물 종류"
  from users u,
       posts p
 where u.user_id = p.user_id;
