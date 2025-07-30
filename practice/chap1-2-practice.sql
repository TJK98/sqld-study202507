-- 문제 1
select *
  from hashtags;

-- 문제 2
select content,
       creation_date
  from posts;

-- 문제 3
select distinct user_id
  from likes;

-- 문제 4
select full_name as "전체 이름",
       bio 자기소개
  from user_profiles;

-- 문제 5
select '['
       || user_id
       || ']님이 ['
       || comment_text
       || '] 라고 댓글을 남겼습니다.' as "댓글 알림"
  from comments;
