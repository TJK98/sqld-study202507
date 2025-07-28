-- 합집합 연산
select user_id
  from likes;

select user_id
  from comments;

select user_id as "Likes user id" --위쪽 별칭으로 설정된다. 열의 수가 맞아야 한다. 같은 데이터 타입 유형이여야 한다.
  from likes
union all -- 단순한 합집합 연산, 중복 여부나 순서에 상관없이 모든 행을 반환
select user_id as "comments user id"
  from comments;

select user_id
  from likes
 -- order by user_id -- 오름차순 정렬
union -- 깔끔하고 순수한 목록 반환, 오름차 정렬, 중복 제거, 합집합
select user_id
  from comments
 order by user_id; -- 오름차순 정렬, 마지막에 한 번만 정렬해야 된다.

-- INTERSECT 연산 (교집합)
-- '좋아요'를 누른 사용자의 ID 목록 (중복 제거됨)
select user_id
  from likes
intersect
-- '댓글'을 작성한 사용자의 ID 목록 (중복 제거됨)
select user_id
  from comments;

-- MINUS 연산 (차집합)
-- '좋아요'를 누른 사용자의 ID 목록
select user_id
  from likes
minus
-- '댓글'을 작성한 사용자의 ID 목록
select user_id
  from comments;
