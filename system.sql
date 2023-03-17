# 대소문자 구별하지 않음( 단, 비밀번호는 구별함)
# CREATE : 생성  /  ALTER  :  수정  /  DROP  :  삭제  /  DELETE  :  삭제

# 오라클 버전이 변경되면서 사용자 생성 시 C## 문자를 넣어서 만들도록 변경됨
# JAVADB => C##JAVADB 이런 방식을 C## 사용하지 않겠음
AFTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

# user 생성은 sys, system 만 가능
# user 생성 ( 공간 할당 )
# CREATE USER 사용자이름  IDENTIFIED BY 비밀번호
CREATE USER JAVADB IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

# GRANT : 권한부여 ( 사용자 생성만 해서는 아무것도 할 수 없음)
GRANT CONNECT, RESOURCE TO JAVADB;


CREATE USER SCOTT IDENTIFIED BY TIGER
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

GRANT CONNECT, RESOURCE TO SCOTT;