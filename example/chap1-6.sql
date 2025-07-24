select username,
       registration_date
  from users
 order by registration_date desc; -- 아무것도 안 쓰면 asc(오름차순)입니다.

-- creation_date를 기준으로 내림차순 정렬합니다.
select post_id,
       user_id,
       content,
       creation_date
  from posts
 order by creation_date desc;

-- 1차: post_type 오름차순, 2차: creation_date 내림차순으로 정렬
select post_id,
       post_type,
       creation_date
  from posts
 order by post_type,      -- 1차 정렬 기준 (ASC는 생략 가능)
          creation_date; -- 2차 정렬 기준

select username as uname,
       registration_date
  from users
 order by uname desc; -- 별칭을 사용하여 정렬할 수도 있다.

select username as uname, -- 1
       registration_date  -- 2
  from users
 order by uname desc,
          2 asc; -- 별칭과 컬럼 번호를 혼합하여 정렬할 수도 있다.

-- 5강에서 배운 GROUP BY를 활용해 사용자별 게시물 수를 구하고,
-- 그 결과(별명: post_count)를 기준으로 내림차순 정렬합니다.
select user_id,
       count(*) as post_count
  from posts
 group by user_id
 --order by count(*) desc; -- 집계 함수로도 정렬이 가능하다.
 order by post_count desc, -- 별칭으로 정렬이 가능하다.
          user_id; -- 사용자별 게시물 수를 기준으로 내림차순 정렬하고, 같은 게시물 수를 가진 사용자끼리는 USER_ID 오름차순으로 정렬합니다.

-- user_id가 1이면 1순위, 나머지는 2순위로 정렬 우선순위를 부여하고,
-- 같은 순위 내에서는 creation_date를 기준으로 내림차순 정렬합니다.
select post_id,
       user_id,
       content,
       creation_date
  from posts
 order by
   case
      when user_id = 21 then
         1
          -- user_id가 21이면 1순위
      else
         2
          -- 나머지는 2순위
   end, -- 1차 정렬 기준: CASE 표현식
   creation_date desc; -- 2차 정렬 기준: creation_date 내림차순
