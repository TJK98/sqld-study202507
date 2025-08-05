-- 트랜잭션 실습

-- 안전을 위해 테이블 복사 CRAS
create table user_copy
   as
      select *
        from users;

-- 여기서 데이터를 지워도 원본 데이터인 users 테이블은 영향을 받지 않는다.
select *
  from user_copy;

delete from user_copy;

-- COMMIT을 사용하여 변경사항을 확정한다.
-- ROLLBACK을 사용해도 COMMIT을 했으면 되돌릴 수 없다.
COMMIT;

-- 실수로 데이터를 지웠을 때 ROLLBACK을 사용하여 이전 상태로 되돌린다.
rollback;

select *
  from user_copy;

-- 실수 방지를 위해 중간에 COMMIT을 사용을 하지 않고 다 끝난 뒤 COMMIT을 사용한다.
