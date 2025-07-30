-- 라이언이 작성한 모든 게시물 조회
select *
  from posts
 where user_id = 1;

select user_id
  from users
 where username = 'ryan';

-- 서브 쿼리로 라이언이 작성한 모든 게시물 조회
select *
  from posts
 where user_id = ( -- 비연관 서브 쿼리 : 밖에 있는 쿼리와 안에 있는 쿼리가 서로 연관되지 않음
   select user_id
     from users
    where username = 'ryan' -- 한줄만 나오는 것들은 단일행 서브 쿼리라고 한다.
);

select *
  from posts
 where user_id = (
   select user_id
     from users
    where username = 'ryan'
       or username = 'choonsik' -- = 으로 비교를 하는데 여러 행이 나오면 오류가 발생한다.
);

-- 우리 피드 데이터에서 평균 조회수보다 높은 조회수를 가진 게시물 조회
-- 평균 조회수 구하기
select avg(view_count)
  from posts;

select *
  from posts
 where view_count > (
   select avg(view_count)
     from posts
);

-- 카카오그룹에 있는 사용자의 모든 아이디를 조회
select user_id
  from users
 where manager_id = 1;

 -- 카카오그룹에 있는 사용자들이 작성한 모든 피드 조회
select *
  from posts
 where user_id in ( 2,
                    3,
                    5,
                    7 );

-- 다중행 서브 쿼리로 카카오그룹에 있는 사용자들이 작성한 모든 피드 조회
select *
  from posts
 where user_id in (
   select user_id
     from users
    where manager_id = 1
);

-- ANY는 서브 쿼리에서 반환된 값 중 하나라도 만족하면 true
select *
  from posts
 where view_count > any (
   select avg(view_count)
     from posts
    group by user_id
);

-- ALL은 서브 쿼리에서 반환된 값 모두를 만족해야 true
select *
  from posts
 where view_count > all (
   select avg(view_count)
     from posts
    group by user_id
);

-- =, <>, <, >, <=, >=, != 와 같이 단일행 연산자는 단일행 서브 쿼리에만 가능하다.
-- IN, ANY, ALL, SOME와 같은 다중행 연산자는 다중행 서브 쿼리에만 가능하다.

select *
  from posts;

select *
  from hashtags;

select tag_id
  from hashtags
 where tag_name = '#포켓몬';

select *
  from post_tags
 where tag_id = 1003;

select *
  from posts
 where post_id in ( 54,
                    55,
                    56 );

select *
  from posts
 where post_id in (
   select post_id
     from post_tags
    where tag_id = (
      select tag_id
        from hashtags
       where tag_name = '#포켓몬'
   )
);

select p.*,
       u.username
  from posts p
  left join users u -- 유저 정보가 없는 익명 게시물도 조회하기 위해 left join 사용
on p.user_id = u.user_id
 where post_id in (
   select post_id
     from post_tags
    where tag_id = (
      select tag_id
        from hashtags
       where tag_name = '#포켓몬'
   )
);

-- 피카츄가 올린 피드에 좋아요을 누른 사람들의 이름을 조회
select *
  from likes;

-- 피카츄 유저 아이디 찾기
select user_id
  from users
 where username = 'pikachu';

-- 피카츄가 올린 피드의 post_id를 조회
select post_id
  from posts
 where user_id = (
   select user_id
     from users
    where username = 'pikachu'
);

-- 피카츄가 올린 피드에 좋아요 누른 내용들을 필터링
select username
  from likes l
  join users u
on l.user_id = u.user_id
 where post_id in (
   select post_id
     from posts
    where user_id = (
      select user_id
        from users
       where username = 'pikachu'
   )
);

-- 다중 칼럼 서브 쿼리
-- 2개의 칼럼을 반환하는 서브 쿼리면 2개의 칼럼을 비교해야 한다.
select *
  from posts
 where ( user_id,
         post_id ) in (
   select user_id,
          post_id
     from likes
    where user_id = (
      select user_id
        from users
       where username = 'pikachu'
   )
);

-- 인라인 뷰 서브쿼리 (FROM 절에 서브쿼리 사용)
-- 사용자별 피드 작성 개수
-- 테이블이 들어갈 수 있는 곳은 모두 서브쿼리를 사용할 수 있다.
select pc.user_id,
       u.username,
       pc.post_count
  from (
   select user_id,
          count(*) as post_count
     from posts
    group by user_id
) pc
  join users u
on pc.user_id = u.user_id;

select pc.user_id,
       u.username,
       pc.post_count
  from users u
  join (
   select user_id,
          count(*) as post_count
     from posts
    group by user_id
) pc
on pc.user_id = u.user_id;

select user_id,
       count(*) as total_likes
  from likes
 group by user_id
 order by user_id;

select a.user_id,
       a.total_likes
  from (
   select user_id,
          count(*) as total_likes
     from likes
    group by user_id
) a,
       users u
 where a.user_id = u.user_id;

-- 스칼라 서브쿼리 (SELECT 절에 서브쿼리 사용)
-- 유저 정보(USERS)를 조회 + 상세 bio 정보(USER_PROFILE)도 같이 조회
select *
  from users;
select *
  from user_profile;

-- 스칼라 서브쿼리 == 연관 서브쿼리
-- 연관 서브쿠리 : 서브쿼리가 한 번 실행되고 끝나는 게 아닌 바깥 쪽 메인 쿼리 한 행을 실행할 때마다 서브쿼리가 반복 실행된다.
select u.user_id,
       u.username,
       ( -- 스칼라 서브쿼리
          select bio
            from user_profiles up
           where up.user_id = u.user_id
       ) as bio
  from users u;

-- 피드 별로 피드의 id와 피드의 내용과 각 피드가 받은 좋아요 수를 한 번에 조회
select post_id,
       content
  from posts;

select post_id,
       count(*) as like_count
  from likes
 group by post_id
 order by post_id;

select post_id,
       count(*) as reply_count
  from comments
 group by post_id
 order by post_id;


select p.post_id,
       p.content,
       nvl(
          lc.like_count,
          0
       ) as like_count,
       nvl(
          rc.reply_count,
          0
       ) as reply_count
  from posts p
  left outer join (
   select post_id,
          count(*) as like_count
     from likes
    group by post_id
) lc
on p.post_id = lc.post_id
  left outer join (
   select post_id,
          count(*) as reply_count
     from comments
    group by post_id
) rc
on rc.post_id = p.post_id
 order by p.post_id;

-- 스칼라 조인
select p.post_id,
       p.content,
       (
          select count(*)
            from likes l
           where l.post_id = p.post_id
       ) as "좋아요 수",
       (
          select count(*)
            from comments c
           where c.post_id = p.post_id
       ) as "댓글 수"
  from posts p;


-- 게시물을 한 번이라도 작성한 적이 있는 모든 사용자의 이름을 알려주는 쿼리
select distinct p.user_id,
                u.username
  from posts p
  join users u
on p.user_id = u.user_id
 order by p.user_id;

-- EXISTS 서브쿼리
-- EXISTS 서브쿼리는 서브쿼리의 결과가 존재하는지 여부를 확인하는 데 사용된다.
-- EXISTS 서브쿼리는 서브쿼리의 결과가 존재하면 true를 반환하고, 결과가 없으면 false를 반환한다.
select u.user_id,
       u.username
  from users u
 where exists (
   select 1 -- 1은 아무 값이나 상관없다. EXISTS 서브쿼리는 결과가 존재하는지만 확인한다.
     from posts p
    where p.user_id = u.user_id
);

-- NOT EXISTS 서브쿼리
-- NOT EXISTS 서브쿼리는 서브쿼리의 결과가 존재하지 않는지 여부를 확인하는 데 사용된다.
-- NOT EXISTS 서브쿼리는 서브쿼리의 결과가 없으면 true를 반환하고, 결과가 있으면 false를 반환한다.
select u.user_id,
       u.username
  from users u
 where not exists (
   select 'a' -- 'a'는 아무 값이나 상관없다. EXISTS 서브쿼리는 결과가 존재하는지만 확인한다.
     from posts p
    where p.user_id = u.user_id
)
 order by u.user_id;
