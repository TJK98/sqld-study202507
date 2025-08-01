-- ROLLUP(A)  ->  A, 전체
    -- CUBE(A)  ->  A, 전체

    -- ROLLUP((A,B))   ->  A + B, 전체

    --  A, ROLLUP(B)   ->   A ,  A + B
    --  A, CUBE(B)   ->   A ,  A + B

    --  ROLLUP(A, B)
    -- ->  A + B, A, 전체

    --  CUBE(A, B)
    -- -> A + B, A, B, 전체

    --  GROUPING SETS((A, B))   -> A + B만 하고 끝
    --  GROUPING SETS(A)   -> A 만 하고 끝
    --  GROUPING SETS(B)   -> B 만 하고 끝
    --  GROUPING SETS(())   -> 전체통계만 내고 끝

    --  GROUPING SETS(A, B)   -> A, B
    --  GROUPING SETS((A, B),  A, ())   ->  ROLLUP과 같아짐
    --  GROUPING SETS((A, B),  A, B, ())   ->  CUBE와 같아짐
    --  GROUPING SETS((A, B),  A, B)   ->  CUBE랑 같게할건데 전체는 빼줘

    -- 순위 함수

    -- RANK              1 2 2 4 4 4 7
    -- DENSE_RANK        1 2 2 3 3 3 3 3 4
    -- ROW_NUMBER        1 2 3 4 5 6 7 8


--  전체 조회수 총합 집계
-- 사용자별 조회수 총합 집계
-- 사용자>피드타입별 조회수 총합 집계

-- user_id, post_type을 기준으로 계층적 집계를 수행합니다.
select user_id,
       post_type,
       sum(view_count) as total_views
  from posts
 group by rollup(user_id,
                 post_type)
 order by user_id,
          post_type;

select null,
       null,
       sum(view_count) as total_views
  from posts;

select user_id,
       null,
       sum(view_count) as total_views
  from posts
 group by user_id;

select user_id,
       post_type,
       sum(view_count) as total_views
  from posts
 group by user_id,
          post_type;

select user_id,
       post_type,
       sum(view_count) as total_views,
       grouping(user_id) as g_user, -- user_id가 집계되었으면 1
       grouping(post_type) as g_type -- post_type이 집계되었으면 1
  from posts
 group by rollup(user_id,
                 post_type)
 order by user_id,
          post_type;

select case
          when grouping(user_id) = 1 then
             '전체 합계'
          else
             to_char(user_id)
       end as "사용자",
       case
          when grouping(post_type) = 1 then
             '사용자 소계'
          else
             post_type
       end as "게시물 종류",
       sum(view_count) as "총 조회수"
  from posts
 group by rollup(user_id,
                 post_type)
 order by user_id,
          post_type;

select case
          when grouping(user_id) = 1 then
             '전체'
          else
             to_char(user_id)
       end as "사용자",
       case
          when grouping(post_type) = 1 then
             '소계'
          else
             post_type
       end as "게시물 종류",
       sum(view_count) as "총 조회수",
       grouping(user_id) as g_user,
       grouping(post_type) as g_type
  from posts
 group by cube(user_id,
               post_type);
