select user_id,
       username,
       manager_id
  from users;

select level,
       lpad(
          ' ',
          (level - 1) * 4
       )
       || username as "사용자 (조직도)", -- LEVEL에 따라 들여쓰기
       user_id,
       manager_id
  from users
  -- start with 절은 계층 구조의 시작점을 지정
start with
  -- user_id = 1 -- 1번 사용자 ('오박사')를 시작점으로 설정
   manager_id is null -- 1. 시작점: 매니저가 없는 최상위 관리자 ('오박사'). 펼쳐지는 시작점이 레벨 1이 된다.
-- CONNECT BY : 계층 구조를 표현할 때 사용
connect by
   prior user_id = manager_id; -- 2. 연결 규칙: 나의 user_id가 다른 사람의 manager_id와 같다면, 그 사람은 나의 부하직원이다.

-- PRIOR가 자식 쪽에 붙으면 순방향 전개, 같은 값이 없으면 자식
-- PRIOR가 부모 쪽에 붙으면 역방향 전개, 같은 값이 있으면 부모
select user_id,
       manager_id
  from users
 order by user_id;

select comment_id,
  -- COMMENT_TEXT,
       parent_comment_id
  from comments;

select lpad(
   '└> ',
   (level - 1) * 4
)
       || comment_text as "댓글 내용",
       level,
       comment_id,
       parent_comment_id
  from comments
start with
   parent_comment_id is null
connect by
   prior comment_id = parent_comment_id;
