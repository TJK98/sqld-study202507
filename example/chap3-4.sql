create user marketer identified by marketing123;

grant
   create session
to marketer;

grant connect to marketer;

-- 1단계: PDB로 세션 변경
alter session set container = xepdb1;

-- 2단계: 현재 컨테이너 확인
select sys_context(
   'USERENV',
   'CON_NAME'
)
  from dual;

-- 3단계: 사용자 생성
create user haha identified by 1234;

-- 4단계: 권한 부여
grant
   create session
to haha;
grant connect to haha;  -- 추가 권한

CONNECT HAHA/1234@localhost:1521/XEPDB1;
