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
 where (user_id, post_id) in (
   select user_id, post_id
     from likes
    where user_id = (
      select user_id
        from users
       where username = 'pikachu'
   )
);
