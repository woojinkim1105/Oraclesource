-- scott

-- emp(employee) 테이블 구성 보기
-- 필드명(열이름)      제약조건       데이터타입
-- EMPNO(사원번호)          NOT NULL     NUMBER(4)
-- ENAME(사원명),JOB(직책), MGR(직속상관 번호), HIREDATE(입사일), SAL(급여),COMM(수당),DEPTNO(부서번호)
-- NUMBER : 소수점 자릿수를 포함해서 지정 가능
-- NUMBER(4) : 4자리 숫자까지 허용,   NUMBER(8,2) : 전체 자릿수는 8자리이고 소수점 2자리를 포함한다
-- VARCHAR2 : 가변형 문자열 저장
-- VARCHAR2(10) : 10byte 문자까지 저장 가능
-- DATE : 날짜 데이터

DESC emp;

-- DEPTNO(부서번호), DNAME(부서명), LOC(부서위치)
DESC dept;

-- GRADE(급여등급), LOSAL(최소 급여액), HISAL(최대 급여액)
DESC salgrade;

-- select : 데이터 조회
-- 조회 방식 : 셀렉션(행 단위로 조회), 프로젝션(열 단위로 조회), 조인(두 개 이상의 테이블을 사용하여 조회)
-- SELECT 열이름1, 열이름2 ......( 조회할 열이 전체라면 * 로 처리)
-- FROM 테이블명;

-- 1. EMP 테이블의 전체 열을 조회
SELECT
    *
FROM
    emp;

-- 2. EMP 테이블에서 사원번호, 이름, 급여 열을 조회
SELECT
    empno,
    ename,
    sal
FROM
    emp;

-- 3. DEPT 테이블 전체 조회
SELECT
    *
FROM
    dept;
-- 4. DEPT 테이블 안에 부서번호, 지역만 조회
SELECT
    deptno,
    loc
FROM
    dept;
    
-- 5. EMP 테이블 안에 부서번호 조회
SELECT
    deptno
FROM
    emp;

-- 6. EMP 테이블 안에 부서번호 조회(단, 중복된 부서 번호는 제거)
-- DISTINCT : 중복제거
SELECT DISTINCT
    job,
    deptno
FROM
    emp;

-- 열이 여러 개인 경우( 묶어서 중복이냐 아니냐를 판단)
SELECT DISTINCT
    job
FROM
    emp;
    
-- 7. 연산
-- 별칭 : 필드에 별칭을 임의로 부여 (as 별칭, 혹은 한 칸 띄고 별칭, 별칭에 공백이 있다면 ""로 묶어주기) 
-- 사원들의 1년 연봉 구하기 ( SAL * 12 + COMM )
SELECT
    empno,
    ename,
    sal * 12 + comm AS annsal
FROM
    emp;

SELECT
    empno,
    ename           사원명,
    job             "직 책",
    sal * 12 + comm annsal
FROM
    emp;
    
    
    
    -- 산술 연산자 : +, -, *, /, mod(나머지 - 표준은 아님(오라클에서만 제공))
    -- 비교 연산자 : >, >=, <, <=
    -- 등가비교연산자 : =, !=, <>, ^= (!=, <>, ^= : A값과 B값이 다를 경우 true, 같으면 false)
    -- 논리부정연산자 : NOT
    --  IN 연산자
    -- BETWEEN A AND B 연산자
    -- LIKE연산자와 와일드 카드(-, %)
    -- IS NULL 연산자
    -- 집합연산자 : UNION(합집합-중복제거), UNION ALL(합집합-중복포함), MINUS(차집합), INTERSECT(교집합) 
    -- 연산자 우선순위
    -- 1) 산술연산자 *, /
--    2) 산술연산자 +, -
--    3) 비교연산자
--    4) IS NULL, IS NOT NULL, LIKE, IN
--    5) BETWEEN A AND B
--    6) NOT
--    7) AND
--    8) OR
--    우선순위를 줘야 한다면 소괄호 사용 추천
    
    
    
    
    
    
    
    -- EMP 테이블에서 급여 열에 12를 곱한 값이 36000 인 행 조회
SELECT
    *
FROM
    emp
WHERE
    sal * 12 = 36000;
    
    -- ename 이 F 이후의 문자로 시작하는 사원 조회
    -- '문자 표현시 ' ' 만 사용
SELECT
    *
FROM
    emp
WHERE
    ename >= 'F';

SELECT
    *
FROM
    emp
WHERE
    ename <= 'FORZ';
    
    -- JOB이 MANAGER, SALESMAN, CLERK 사원 조회
SELECT
    *
FROM
    emp
WHERE
    job = 'MANAGER'
    OR job = 'SALESMAN'
    OR job = 'CLERK';
    
    -- sal 이 3000이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal != 3000;
    
    -- JOB이 MANAGER, SALESMAN, CLERK 사원 조회
SELECT
    *
FROM
    emp
WHERE
    job IN ( 'MANAGER', 'SALESMAN', 'CLERK' );
    
    -- JOB이 MANAGER, SALESMAN, CLERK 이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
        job != 'MANAGER'
    AND job <> 'SALESMAN'
    AND job^= 'CLERK';
    
    -- JOB이 MANAGER, SALESMAN, CLERK 이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    job NOT IN ( 'MANAGER', 'SALESMAN', 'CLERK' );
    
    -- 20, 50 번 부서에서 근무하는 모든 사원들의 LAST_NAME, 부서번호를 오름차순으로 조회
SELECT
    last_name,
    department_id
FROM
    emp
WHERE
    department_id IN ( 20, 50 )
ORDER BY
    last_name,
    department_id;

    -- 커미션을 받는 모든 사원들의 LAST_NAME, 연봉, 커미션 조회(연봉의 내림차순, 커미션 내림차순)
SELECT
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct > 0
ORDER BY
    salary DESC,
    commission_pct DESC;
    
    -- 연봉이 2500, 3500, 7000이 아니며 직업이 SA-REP 나 ST-CLERK 인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    salary NOT IN ( 2500, 3500, 7000 )
    AND job IN ( 'SA_REP', 'ST_CLERK' );
    
    -- 2008/02/20 ~ 2008/05/01 사이에 고용된 사원들의 last_name, 사번, 고용일자 조회
    -- 고용일자 내림차순 정렬
    -- 날짜 표현시 홑따옴표 안에 표현 - OR / 사용가능

SELECT
    last_name,
    employee_id,
    hire_date
FROM
    employees
WHERE
        hire_date >= '2008-02-20'
    AND hire_date <= '2008-05-01';
    
    -- 2004년도에 고용된 사원들의 last_name, hire_date 조회
    -- 고용일자 오름차순 정렬
    
    
    
    
    
    
    -- 집합연산자
    -- union(중복제거), union all(중복제거 안함) : 합집합

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION ALL
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
    
    -- MINUS(차집합)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
    
      -- INTERSECT(교집합)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
INTERSECT
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
    
    -- EMP 테이블에서 사원이름이 S로 끝나는 사원 데이터 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%S';
    -- EMP 테이블에서 30번 부서에 근무하는 사원 중에서 직책이 SALESMAN인 사원의
    -- 사원번호, 이름, 급여 조회(SAL 내림차순)
SELECT
    empno,
    ename,
    sal
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN'
ORDER BY
    sal DESC;
    
    -- EMP 테이블을 사용하여 20,30번 부서에 근무하고 있는 사원 중 급여가 2000초과인 사원 조회
    -- 사원번호, 이름, 급여, 부서번호 조회
    -- 집합연산자를 사용하는 방식과 사용하지 않는 방식 두가지를 사용한다
   
   -- 사용하지 않는 경우
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno IN ( 20, 30 )
    AND sal > 2000; 
    
    --
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    sal > 2000
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 20
    AND sal > 2000
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 30
    AND sal > 2000;
    
    -- 사원 이름에 E가 포함되어 있는 30번 부서 사원 중 급여가 1000~2000 사이가 아닌 사원의 이름
    -- 사원번호, 급여, 부서번호를 조회하기
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    ename LIKE '%E%'
    AND deptno = 30
    AND sal BETWEEN 1000 AND 2000;
    
    -- 추가 수당이 존재하지 않으며, 상급자가 있고 직책이 MANAGER, CLERK 인 사원 중에서 사원 이름의
    -- 두 번째 글자가 L이 아닌 사원의 정보 조회
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL
    AND mgr IS NOT NULL
    AND job IN ( 'MANAGER', 'CLERK' )
    AND ename NOT LIKE '_L%';     
    
    
    -- 오라클 함수
    -- 오라클에서 기본으로 제공하는 내장 함수와 사용자가 필요에 의해 직접 정의한 사용자 정의 함수
    
    --1. 문자열 함수
    --1) UPPER, LOWER, INITCAP
    -- UPPER : 모두 대문자, LOWER : 모두 소문자, INITCAP : 첫 글자만 대문자
    -- LIKE '%ORACLE

SELECT
    ename,
    upper(ename),
    lower(ename),
    initcap(ename)
FROM
    emp;

SELECT
    *
FROM
    emp
WHERE
    upper(ename) = 'FORD';
    
    --2) LENGTH : 문자열 길이
SELECT
    ename,
    length(ename)
FROM
    emp;
    
    -- 사원 이름의 길이가 5 이상인 사원 조회
SELECT
    ename,
    length(ename)
FROM
    emp
WHERE
    length(ename) >= 5;

--한글일 때
--dual : sys가 소유하는 테이블(임시 연산이나 함수의 결과값을 확인하는 용도)
-- length, lengthb(문자가 사용하는 바이트 수)
--영어 : 문자1 => 1byte, 한글 : 문자 1 => 3 byte
SELECT
    length('한글'),
    lengthb('한글'),
    lengthb('ab')
FROM
    dual;
    
    -- 3) SUBSTR(문자열데이터, 시작위치, 추출길이) : 추출길이 생략 가능 // java string와 유사
    -- 문자열 일부 추출

SELECT
    job,
    substr(job, 1, 2),
    substr(job, 3, 2),
    substr(job, 5),
    substr(job, - 3)
FROM
    emp;
    
    -- ENAME, 세 번째 글자부터 출력
SELECT
    ename,
    substr(ename, 3)
FROM
    emp;
    
    --3) INSTR : 문자열 데이터 안에서 특정 문자 위치 찾기
    -- INSTR(대상문자열, 위치를 찾으려는 문자열, 대상문자열에서 찾기를 시작할 위치(선택), 시작위치에서 찾으려는 글자가 몇 번째인지 지정(선택)
    
    --HELLO, ORACLE! 문자열에서 L 문자열 찾기
SELECT
    instr('HELLO, ORACLE!', 'L')       AS instr_1,
    instr('HELLO, ORACLE!', 'L', 5)    AS instr_2,
    instr('HELLO, ORACLE!', 'L', 2, 2) AS instr_3
FROM
    dual;
    
    --4) replace : 특정 문자를 다른 문자로 변경
    -- replace(문자열 데이터, 찾는 문자, 변경 문자)
    
    --010-1234-5678  -를 빈 문자열로 변경 /  -를 없애기
SELECT
    '010-1234-5678'                            AS 변경전,
    replace('이것이 Oracle 이다', '이것이', 'This is') AS replace_1
FROM
    dual;
    
    --5) concat : 두 문자열 데이터 합치기
SELECT
    concat(empno, ename)
FROM
    emp;
    
    -- || : 문자열 연산자
SELECT
    empno || ename,
    empno
    || ':'
    || ename
FROM
    emp;
    
    --6) TRIM, LTRIM, RTRIM : 공백 포함 특정 문자 제거
    -- '   ORACLE' = 'ORACLE'  ==> 공백있어서 FALSE

SELECT
    '                  이것이                       ',
    TRIM('                  이것이                       ')
FROM
    dual;
    
    
--    2. 숫자함수
--    1) ROUND, TRUNC, CEIL, FLOOR, MOD

-- round : 반올림
-- round(숫자, 반올림 위치(선택))
SELECT
    round(1234.5678)      AS round,                 --소수 첫 째 자리 반올림
    round(1234.5678, 0)   AS round0,
    round(1234.5678, 1)   AS round1,
    round(1234.5678, 2)   AS round2,
    round(1234.5678, - 1) AS round_minus1       --일의 자리에서 반올림
FROM
    dual;
    
    --trunc : 특정 위치에서 버리는 함수
SELECT
    trunc(1234.5678)      AS trunc,                 --소수 첫 째 자리 반올림
    trunc(1234.5678, 0)   AS trunc0,
    trunc(1234.5678, 1)   AS trunc1,
    trunc(1234.5678, 2)   AS trunc2,
    trunc(1234.5678, - 1) AS trunc_minus1       --일의 자리에서 반올림
FROM
    dual;
    
    --ceil(숫자), floor(숫자) : 입력된 숫자와 가까운 큰 정수, 작은 정수

SELECT
    ceil(3.14),
    floor(3.14),
    ceil(- 3.14),
    floor(- 3.14)
FROM
    dual;
    
    --mod(숫자, 나눌 수) : 나머지 값
--    SELECT mod(15,6),
--    mod (10,2), mod(,)
    
    --날짜 함수
    --날짜 데이터 + 숫자 : 날짜 데이터보다 숫자만큼 일 수 이후의 날짜
    --날짜 데이터 - 날짜 데이터 : 두 날짜 데이터 간의 일 수 차이
    --날짜 데이터 +날짜 데이터 : 연산불가
    
    --1) sysdate 함수 : 오라클 데이터베이스 서버가 설치된 OS의 현재날짜와 시간을 가져옴
SELECT
    sysdate,
    sysdate - 1 AS yesterday,
    sysdate + 1 AS tomorrow
FROM
    dual;
    
    --2) add_months(날짜, 더할 개월 수) : 몇 개월 이후 날짜 구하기
SELECT
    sysdate,
    add_months(sysdate, 3)
FROM
    dual;
    
    -- 입사 50주년이 되는 날짜 구하기
    --empno, ename, hiredate, 입사 50주년 날짜 조회
SELECT
    empno,
    ename,
    hiredate,
    add_months(hiredate, 600)
FROM
    emp;
    
    
    --3) MONTHS-BETWEEN : 두 날짜 데이터 간의 날짜 차이를 개월 수로 계산하여 출력
    --입사 45년 미만인 사원 데이터 조회
     --empno, ename, hiredate
SELECT
    empno,
    ename,
    hiredate
FROM
    emp
WHERE
    months_between(sysdate, hiredate) < 540;
    
    
    --현재 날짜와 6개월 후 날짜가 출력
SELECT
    sysdate,
    add_months(sysdate, 6)
FROM
    dual;

SELECT
    empno,
    ename,
    hiredate,
    sysdate,
    months_between(hiredate, sysdate)        AS manths1,
    months_between(sysdate, hiredate)        AS manths2,
    trunc(months_between(sysdate, hiredate)) AS manths3
FROM
    emp;
    
    
    
    --4) next_day(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
--    last_day(날짜) : 특정 날짜가 속한 달의 마지막 날짜를 출력
SELECT
    sysdate,
    next_day(sysdate, '금요일'),
    last_day(sysdate)
FROM
    dual;

-- 날짜의 반올림, 버림 : ROUND, TRUNC
--CC : 네 자리 연도의 끝 두자리를 기준으로 사용
--      2023 년인 경우 2050이하 이므로 2001년으로 처리
SELECT
    sysdate,
    round(sysdate, 'CC')   AS format_cc,
    round(sysdate, 'YYYY') AS format_yyyy,
    round(sysdate, 'DDD')  AS format_ddd,
    round(sysdate, 'HH')   AS format_hh
FROM
    dual;
    
    
    
    --형변환 함수 : 자료형을 형 변환
    -- NUMBER, VARCHAR2, DATE

SELECT
    empno,
    ename,
    empno + '500'
FROM
    emp
WHERE
    ename = 'FORD';
    
--    ORA-01722: 수치가 부적합합니다
--    SELECT
--    empno,
--    ename,
--    'abcd' + empno
--FROM
--    emp
--WHERE
--    ename = 'FORD';

-- TO_CHAR() : 숫자 또는 날짜 데이터를 문자 데이터로 변환
-- TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

SELECT
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간
FROM
    dual;

-- MON, MONTH : 월 이름
-- DDD : 365일 중에서 며칠
SELECT
    sysdate,
    to_char(sysdate, 'YYYY/MM/DD')    AS 현재날짜,
    to_char(sysdate, 'YYYY')          AS 현재연도,
    to_char(sysdate, 'MM')            AS 현재월,
    to_char(sysdate, 'MON')           AS 현재월1,
    to_char(sysdate, 'DD')            AS 현재일자,
    to_char(sysdate, 'DDD')           AS 현재일자2,
    to_char(sysdate, 'HH12:MI:SS AM') AS 현재날짜시간
FROM
    dual;
    
    -- sal 필드에   , 나 통화표시를 하고 싶다면??
    -- L( Locale) 지역 화폐 단위 기호 붙여줌
SELECT
    sal,
    to_char(sal, '$999,999') AS sal_$,
    to_char(sal, 'L999,999') AS sal_l
FROM
    emp;
    
    
    
    
    
    
    --to_number(문자열데이터, 인식될 숫자형태)
--자동형변환
SELECT
    1300 - '1500',
    '1300' + 1500
FROM
    dual;
    
    --자동형변환 안되는 상황 ( , 가 들어가서)
SELECT
    TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM
    dual;
    
    
    --to_date( 문자열데이터, '인식될 날짜 형태')
SELECT
    TO_DATE('2018-07-14', 'YYYY-MM-DD') AS todate1,
    TO_DATE('20230320', 'YYYY-MM-DD')   AS todate2
FROM
    dual;
    
--    ORA-01722: 수치가 부적합합니다
--    select '2023-03-21' - '2023-02-01'
--    from dual;

SELECT
    TO_DATE('2023-03-21') - TO_DATE('2023-02-01')
FROM
    dual;
    
    
    -- 널처리 함수
    -- NULL + 300 => NULL   (연산이 안됨)
    
    --NVL(데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    sal,
    comm,
    sal + comm,
    nvl(comm, 0),
    sal + nvl(comm, 0)
FROM
    emp;
    
    --NVL2(데이터, 널이 아닐 경우 반환할 데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    comm,
    nvl2(comm, '0', 'X'),
    nvl2(comm, sal * 12 + comm, sal * 12) AS annsal
FROM
    emp;
    
    -- DECODE 함수 / CASE 문
    
    -- DECODE( 검사 대상이 될 데이터,
    --               조건1, 조건1이 일치할 때 실행할 구문
    --               조건2, 조건2이 일치할 때 실행할 구문)
    
    -- emp 테이블에 직책이 MANAGER 인 사람은 급여의 10% 인상,
    -- SALESMAN 인 사람은 5%, ANALYST 인 사람은 그대로, 나머지는 3% 인상된 급여 출력
SELECT
    empno,
    ename,
    job,
    sal,
    decode(job, 'MANAGER', sal * 1.1, 'SALESMAN', sal * 1.05,
           'ANALYST', sal, sal * 1.03) AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE job
        WHEN 'MANAGER'  THEN
            sal * 1.1
        WHEN 'SALESMAN' THEN
            sal * 1.05
        WHEN 'ANALYST'  THEN
            sal
        ELSE
            sal * 1.03
    END AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE
        WHEN comm IS NULL THEN
            '해당사항 없음'
        WHEN comm = 0 THEN
            '수당없음'
        WHEN comm > 0 THEN
            '수당 : ' || comm
    END AS comm_text
FROM
    emp;
    

--     실습1)   emp 테이블에서 사원들의 월평균 근무일수는 21.5일이다.
--        하루 근무시간을 8시간으로 보았을 때 사원들의
--        하루급여 (DAY_PAY)와 시급(TIME_PAY)를 계산하여
--        결과를 출력한다. 단, 하루 급여는 소수점 셋째 자리에서
--        버리고, 시급은 두 번째 소수점에서 반올림하시오.

SELECT
    empno,
    ename                    sal,
    trunc(sal / 21.5, 2)     AS day_pay,
    round(sal / 21.5 / 8, 1) AS time_pay
FROM
    emp;
        
        
        
--       실습2) emp 테이블에서 사원들은 입사일(HIREDATE)을 기준으로
--        3개월이 지난 후 첫 월요일에 정직원이 된다. 사원들이
--        정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 아래와
--        같이 출력하시오. 단, 추가수당(COMM)이 없는 사원의 추가수당은 N/A로 출력하시오

SELECT
    empno,
    nvl(to_char(comm),
        'N/A') -- comm이 현재 숫자이기 때문에 to_char(comm)
FROM
    emp;

SELECT
    empno,
    ename,
    hiredate,
    next_day(add_months(hiredate, 3),
             '월요일') AS r_job,
    nvl(to_char(comm),
        'N/A')      AS comm
FROM
    emp;
    
--    실습3) emp테이블의 모든 사원을 대상으로 
--    직속 상관의 사원번호(MGR)를 다음과 같은 조건을 기준으로
--    변환해서 CHG_MGR 열에 출력하시오.
SELECT
    empno,
    ename,
    mgr,
    decode(substr(to_char(mgr),
                  1,
                  2),
           NULL,
           '0000',
           '75',
           '5555',
           '76',
           '6666',
           '77',
           '7777',
           '78',
           '8888',
           substr(to_char(mgr),
                  1)) AS chg_mgr
FROM
    emp;

SELECT
    empno,
    ename,
    mgr,
    CASE
        WHEN mgr IS NULL THEN
            '0000'
        WHEN substr(to_char(mgr),
                    1,
                    2) = '75' THEN
            '5555'
        WHEN substr(to_char(mgr),
                    1,
                    2) = '76' THEN
            '6666'
        WHEN substr(to_char(mgr),
                    1,
                    2) = '77' THEN
            '7777'
        WHEN substr(to_char(mgr),
                    1,
                    2) = '78' THEN
            '8888'
        ELSE
            to_char(mgr)
    END AS chg_mgr
FROM
    emp;
--case   내가 한 코드 = 망함
--    when ename is null then '0000'
--    when mgr/100 =75 then '5555'
--    when mgr/100 =76 then '6666'
--    when mgr/100 =77 then '7777'
--    when mgr/100 =78 then '8888'
--    else mgr
--    end as CHG_MGR
--    from emp;

-- 다중행 함수 : sum, count, max, min, avg

--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
SELECT
    SUM(sal)
FROM
    emp;

-- distinct 중복제거
SELECT
    SUM(DISTINCT sal),
    SUM(ALL sal),
    SUM(sal)
FROM
    emp;

--sum() : null 은 제외하고 합계 구해줌
SELECT
    SUM(comm)
FROM
    emp;

SELECT
    COUNT(comm)
FROM
    emp;

--행의 개수가 몇개냐
SELECT
    COUNT(*)
FROM
    emp
WHERE
    deptno = 30;

SELECT
    MAX(sal)
FROM
    emp;
    
    -- 부서번호가 20인 사원의 입사일 중 제일 최근 입사일
SELECT
    MAX(hiredate)
FROM
    emp
WHERE
    deptno = 20;

      -- 부서번호가 20인 사원의 입사일 중 제일 오래된 입사일
SELECT
    MIN(hiredate)
FROM
    emp
WHERE
    deptno = 20;

SELECT
    AVG(sal)
FROM
    emp;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 30;


--group by : 결과 값을 원하는 열로 묶어 출력

-- 부서별 sal 평균 구하기
SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 10;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 20;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 30;

SELECT
    AVG(sal),
    deptno
FROM
    emp
GROUP BY
    deptno;

--부서별 추가수당 평균 구하기
SELECT
    AVG(comm),
    deptno
FROM
    emp
GROUP BY
    deptno;

--ORA-00979: GROUP BY 표현식이 아닙니다
--select avg(comm), deptno, ename
--from emp
--group by deptno;



--group by + having : group by 절에 조건을 줄 때
--HAVING : 그룹화된 대상을 출력 제할 걸 때

-- 각 부서의 직책별 평균 급여 구하기( 단, 평균 급여가 2000 이상인 그룹만 출력)
-- deptno, job, 평균

SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;