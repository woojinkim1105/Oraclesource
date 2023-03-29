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
    
    --ORA-00934: 그룹 함수는 허가되지 않습니다
--    SELECT
--    deptno,
--    job,
--    AVG(sal)
--FROM
--    emp
--where avg(sal) >= 2000
--GROUP BY
--    deptno,
--    job
--ORDER BY
--    deptno,
--    job;

--**SQL 순서 중요 1) from 구문 실행  2) where 실행   3) group by   4) having   5) select   6) order by
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
WHERE
    sal <= 3000
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;
    
    
    --실습) emp 테이블을 이용하여 부서번호(deptno), 평균급여(avg_sal),
    --최고급여(max_sal), 최저급여(min_sal),사원수(cnt)를 출력한다. 단, 평균
    --급여를 출력할 때 소수점을 제외하고 각 부서번호별로 출력하는 sql 문을 작성
SELECT
    deptno,
    floor(AVG(sal)) AS avg_sal,
    MAX(sal)        AS max_sal,
    MIN(sal)        AS min_sal,
    COUNT(*)        AS cnt
FROM
    emp
GROUP BY
    deptno;
    
    --실습2) 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수를 출력하는 
    -- sql 문 작성
SELECT
    job,
    COUNT(*)
FROM
    emp
GROUP BY
    job
HAVING
    COUNT(job) >= 3;
    
    --실습3) 사원들의 입사연도(HIRE_YEAR)를 기준으로 부서별로 몇 명이 입사했는지
    --출력하는 sql문 작성하시오
SELECT
    to_char(hiredate, 'YYYY') AS hire_year,
    deptno,
    COUNT(*)                  AS cnt
FROM
    emp
GROUP BY
    to_char(hiredate, 'YYYY'),
    deptno;
    
    
    -- 조인 : 여러 테이블을 하나의 테이블처럼 사용 *****
    --1) 내부조인( inner join)
    --  여러 개의 테이블에서 공통된 부분만 추출
    --  1. 등가조인 : 두 개의 열이 일치할 때 값 추출
    --  2. 비등가조인 : 범위에 해당할 때 값 추출
    --2) 외부조인(outer join) ****************면접 질문 
    --  1. left outer join
    --  2. right outer join
    --  3. full outer join ( 잘 안나오지만)
    
    -- dept : 4행 , emp : 12 행 ==> 4*12 = 48행
    -- 크로스 조인(나올 수 있는 모든 조합 추출)
SELECT
    *
FROM
    emp,
    dept
ORDER BY
    empno;
    --------------------------------------------------------
    --3월 22일
    -- ORA-00918: 열의 정의가 애매합니다 (column ambiguously defined), deptno 때문에
    -- inner join
SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
    e.deptno = d.deptno;
    -- from 절이 먼저!!
    
    --SQL-99 표준
    --join ~ on
SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
        e.sal <= 2500
    AND e.empno <= 9999;

SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND sal >= 3000;
    
    -- 급여가 2500 이하이고, 사원번호가 9999 이하인 사원 정보 조회
    -- emp, dept inner join
SELECT
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND sal <= 2500
    AND e.empno <= 9999;
    
    --emp와 salgrade 조인
    --emp 테이블의 sal이 salgrade 테이블의 losal과 hisal범위에 들어가는 형태로 조인
SELECT
    *
FROM
    emp      e,
    salgrade s
WHERE
    e.sal BETWEEN s.losal AND s.hisal;
    
    --self join : 자기 자신 테이블과 조인

SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr = e2.empno;
    
    --outer join
    
    --1) left outer join
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr = e2.empno (+);
    
     --SQL-99 표준
    --join ~ on
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1
    LEFT OUTER JOIN emp e2 ON e1.mgr = e2.empno;

    
    --2) right outer join
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr (+) = e2.empno;
    
     --SQL-99 표준
    --join ~ on
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1
    RIGHT OUTER JOIN emp e2 ON e1.mgr = e2.empno;
    
--SQL-99 표준
--join ~ on
--3) full outer join
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1
    FULL OUTER JOIN emp e2 ON e1.mgr = e2.empno;


    
--ORA-01468: outer-join된 테이블은 1개만 지정할 수 있습니다
--01468. 00000 -  "a predicate may reference only one outer-joined table"  
--    SELECT e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
--    FROM emp e1, emp e2
--    WHERE e1.mgr(+) = e2.empno(+);


-- 연결해야 할 테이블이 세 개일 때
--SELECT *
--FROM table1 t1, table2 t2, table3 t3
--WHERE t1.empno = t2.empno AND t2.deptno = t3.deptno;
--
--SELECT *
--FROM table1 t1 join table2 t2 on t1.empno = t2.empno join table3 t3 on t2.deptno = t3.deptno;

--실습1
--SELECT
--    e.empno,
--    e.ename,
--    d.deptno,
--    d.dname,
--    sal
--FROM
--    emp  e,
--    dept d
--WHERE
--    e.deptno = d.deptno and sal > 2000;
SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.sal
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.sal > 2000;

SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.sal
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
    e.sal > 2000;
    
    --실습2 : 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원수를 출력하는 SQL문 작성
SELECT
    d.deptno,
    d.dname,
    floor(AVG(sal)) AS avg_sal,
    MAX(sal)        AS max_sal,
    MIN(sal)        AS min_sal,
    COUNT(*)        AS cnt
FROM
    emp  e,
    dept d
WHERE
    e.deptno = d.deptno
GROUP BY
    d.deptno,
    d.dname;

SELECT
    d.deptno,
    d.dname,
    floor(AVG(sal)) AS avg_sal,
    MAX(sal)        AS max_sal,
    MIN(sal)        AS min_sal,
    COUNT(*)        AS cnt
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
GROUP BY
    d.deptno,
    d.dname;   

--실습3 : 모든 부서정보와 사원정보를 부서번호, 사원이름 순으로 정렬하여 출력하는 SQL문 작성
SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.job,
    e.sal
FROM
    dept d,
    emp  e
WHERE
    d.deptno = e.deptno (+);

SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.job,
    e.sal
FROM
    dept d
    LEFT OUTER JOIN emp  e ON d.deptno = e.deptno;

--join 
-- 자신의 담당 매니저의 고용일보다 빠른 입사자 찾기(self join - employees)
--hire_date, last_name, manager_id 조회
SELECT
    e1.hire_date,
    e1.last_name,
    e1.manager_id
FROM
    employees e1,
    employees e2
WHERE
        e1.manager_id = e2.employee_id
    AND e1.hire_date < e2.hire_date;


--도시 이름이 T로 시작하는 지역에 사는 사원들의 사번, last_name, 부서번호, 도시 조회
--employees, departments, locations inner join

SELECT
    e.employee_id,
    e.last_name,
    d.department_id,
    l.city
FROM
    employees   e,
    departments d,
    locations   l
WHERE
        e1.department_id = d.department_id
    AND d.location_id = l.location_id
    AND city LIKE 'T%';



-- 위치 id가 1700인 사원들의 사번, last_name, 부서번호, 급여 조회
--employees, departments inner join

SELECT
    e.employee_id,
    e.last_name,
    d.department_id,
    e.salary
FROM
    employees   e,
    departments d
WHERE
        e.department_id = d.department_id
    AND d.location_id = 1700;

--부서명, 위치id, 각 부서별 사원 총 수, 각 부서별 평균 연봉 조회
--평균 연봉은 소수점 2자리까지만
--employees, departments inner join

SELECT
    d.department_name,
    COUNT(e.employee_id),
    round(AVG(e.salary),
          2)
FROM
    employees   e,
    departments d
WHERE
    e.department_id = d.department_id
GROUP BY
    d.department_name,
    d.location_id;


--Executive 부서에 근무하는 사원들의 부서번호, last_name, job_id 조회
--employees, departments inner join

SELECT
    d.department_id,
    e.last_name,
    e.job_id
FROM
    employees   e,
    departments d
WHERE
        e.department_id = d.department_id
    AND e.department_name = 'Executive';


-- 각 사원별 소속부서에서 자신보다 늦게 고용되었으나 보다 많은 연봉을 받는 사원이 존재하는
-- 모든 사원들의 부서번호, 이름(first_name과 last_name 연결하기), salary, hire_date 조회
-- employees self join

SELECT DISTINCT
    e1.department_id,
    e1.first_name
    || '  '
    || e1.last_name AS name,
    e1.salary,
    e1.hire_date
FROM
    employees e1,
    employees e2
WHERE
        e1.department_id = e2.department_id
    AND e1.hire_date < e2.hire_date
    AND e1.salary < e2.salary;


-- 서브쿼리
-- sql 문을 실행하는 데 필요한 데이터를 추가로 조회하기 위해 sql 문 내부에서 사용하는 select문
-- 1) 단일행 서브쿼리  


--SELECT 조회할 열
--FROM 테이블명
--WHERE 조건식(SELECT 조회할 열 FROM 테이블 WHERE 조건식)


-- 단일행 서브쿼리 : 서브쿼리 결과로 하나의 행 반환
-- =, >, <, >=, <=, <>, ^=, != 연산자 허용

-- 존스의 급여보다 높은 급여를 받는 사원 조회
-- JONES 급여 알아내기 / 알아낸 JONES 급여를 가지고 조건식

SELECT
    sal
FROM
    emp
WHERE
    ename = 'JONES'; --2975

SELECT
    *
FROM
    emp
WHERE
    sal > 2975;

SELECT
    *
FROM
    emp
WHERE
    sal > (
        SELECT
            sal
        FROM
            emp
        WHERE
            ename = 'JONES'
    );
        
-- 사원이름이 ALLEN 인 사원의 추가수당보다 많은 추가수당을 받는 사원 조회
SELECT
    *
FROM
    emp
WHERE
    comm > (
        SELECT
            comm
        FROM
            emp
        WHERE
            ename = 'ALLEN'
    );
        
        -- 사원이름이 WARD 인 사원의 입사일보다 빨리 입사한 사원 조회
SELECT
    *
FROM
    emp
WHERE
    hiredate > (
        SELECT
            hiredate
        FROM
            emp
        WHERE
            ename = 'WARD'
    );
        
-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원정보 및
-- 부서정보 조회
-- 사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT
    e.empno,
    e.ename,
    e.job,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
        e.deptno = 20
    AND e.sal > (
        SELECT
            AVG(sal)
        FROM
            emp
    );


-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 작거나 같은 급여를 받는 사원정보 및
-- 부서정보 조회
SELECT
    e.empno,
    e.ename,
    e.job,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
        e.deptno = 20
    AND e.sal <= (
        SELECT
            AVG(sal)
        FROM
            emp
    );


-- 다중행 서브쿼리 : 서브쿼리 결과로 여러 개의 행 반환
-- IN, ANY(SOME), ALL, EXISTS 연산자 허용(단일행 서브쿼리에 쓰는 연산자 사용 불가)

-- 각 부서별 최고 급여와 동일한 급여를 받는 사원정보 조회

-- 각 부서별 최고 급여
SELECT
    deptno,
    MAX(sal)
FROM
    emp
GROUP BY
    deptno;

--ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
--SELECT * FROM emp WHERE sal = (SELECT MAX(sal) FROM emp GROUP BY deptno);

--IN : 메인쿼리 결과가 서브쿼리 결과 중 하나라도 일치하면 TRUE
SELECT
    *
FROM
    emp
WHERE
    sal IN (
        SELECT
            MAX(sal)
        FROM
            emp
        GROUP BY
            deptno
    );

--30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 조회

-- ANY(SOME) : 메인쿼리 결과가 서브쿼리 결과가 하나 이상이면 TRUE
SELECT
    *
FROM
    emp
WHERE
    sal < ANY (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

SELECT
    *
FROM
    emp
WHERE
    sal < SOME (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

-- 위 결과는 단일행 쿼리로 작성이 가능한 상황임
SELECT
    *
FROM
    emp
WHERE
    sal < (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            deptno = 30
    );

--30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 조회

-- 단일행 서브쿼리
SELECT
    *
FROM
    emp
WHERE
    sal > (
        SELECT
            MIN(sal)
        FROM
            emp
        WHERE
            deptno = 30
    );
-- 다중행 서브쿼리
SELECT
    *
FROM
    emp
WHERE
    sal > ANY (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

-- ALL : 서브쿼리 모든 결과가 조건식에 맞아 떨어져야만 메인쿼리 조건식이 TRUE
SELECT
    *
FROM
    emp
WHERE
    sal < ALL (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

-- EXISTS : 서브쿼리에 결과 값이 하나 이상 존재하면 조건식이 모두 TRUE, 존재하지 않으면 FALSE
SELECT
    *
FROM
    emp
WHERE
    EXISTS (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 10
    );

SELECT
    *
FROM
    emp
WHERE
    EXISTS (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 50
    );

--실습 1)
SELECT
    e.job,
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.job = (
        SELECT
            job
        FROM
            emp
        WHERE
            ename = 'ALLEN'
    );

--실습 2)
SELECT
    *
FROM
    emp
WHERE
    ( deptno, sal ) IN (
        SELECT
            deptno, MAX(sal)
        FROM
            emp
        GROUP BY
            deptno
    );

-- FROM 절에 사용하는 서브쿼리(인라인 뷰)
-- FROM 절에 직접 테이블을 명시해서 사용하기에는 테이블 내 데이터 규모가 클 때, 불필요한 열이 많을 때
SELECT
    e10.empno,
    e10.ename,
    e10.deptno,
    d.dname,
    d.loc
FROM
    (
        SELECT
            *
        FROM
            emp
        WHERE
            deptno = 10
    ) e10,
    (
        SELECT
            *
        FROM
            dept
    ) d
WHERE
    e10.deptno = d.deptno;
        
        
-- SELECT 절에 사용하는 서브쿼리(스칼라 서브쿼리)
-- SELECT 절에 사용하는 서브쿼리는 반드시 하나의 결과만 반환해야 함
SELECT
    empno,
    ename,
    job,
    sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS salgrade,
    deptno,
    (
        SELECT
            dname
        FROM
            dept
        WHERE
            e.deptno = dept.deptno
    ) AS dname
FROM
    emp e;

--실습1) NOT IN
SELECT
    e.empno,
    e.ename,
    e.job,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.job NOT IN (
        SELECT
            job
        FROM
            emp
        WHERE
            deptno = 30
    )
    AND e.deptno = 10;


--실습2) 
SELECT
    e.empno,
    e.ename,
    e.sal
FROM
    emp      e,
    salgrade s
WHERE
    e.sal BETWEEN s.losal AND s.hisal
    AND e.sal > (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;

SELECT
    e.empno,
    e.ename,
    e.sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS grade
FROM
    emp e
WHERE
    e.sal > (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;
    
     --다중행 함수 사용시
SELECT
    e.empno,
    e.ename,
    e.sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS grade
FROM
    emp e
WHERE
    e.sal > ALL (
        SELECT
            sal
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;

---------------------------------------------------
-- 3월 23일

--DML(data manipulation language) : 데이터 추가(insert), 수정(update), 삭제(delete)하는 데이터 조작어
--COMMIT : DML 작업을 데이터베이스에 최종 반영
--ROLLBACK : DML 작업을 취소
-- select + DML ==> 자주 사용하는 sql임

--연습용 테이블 생성
-- 기존 테이블 복사
CREATE TABLE dept_temp
    AS
        SELECT
            *
        FROM
            dept;

DROP TABLE dept_temp;

--insert into 테이블 이름(열이름1, 열이름2......)
--values (데이터1, 데이터2...........);


--dept_temp 새로운 부서 추가하기
INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    50,
    'DATABASE',
    'SEOUL'
);

--열 이름 제거할 때
INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    60,
    'NETWORK',
    'BUSAN'
);

--INSERT 시 오류
--이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다
--INSERT INTO dept_temp(deptno, dname, loc)
--VALUES(600,'NETWORK','BUSAN');

--값의 수가 충분하지 않습니다
INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    70,
    'DATABASE'
);

--NULL 삽입
INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    80,
    'WEB',
    NULL
);

INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    90,
    'MOBILE',
    ' '
);

--NULL 삽입할 컬럼명 지정하지 않았음
--삽입시 전체 컬럼을 삽입하지 않는다면 필드명 필수
INSERT INTO dept_temp (
    deptno,
    loc
) VALUES (
    91,
    'INCHEON'
);

SELECT
    *
FROM
    dept_temp;

--emp_temp 생성 (emp 테이블 복사 - 데이터는 복사를 하지 않을 때)
--구조만 복사( WHERE 1 <> 1 : false 만 뜨기 때문에 데이터가 복사 안 됨)
CREATE TABLE emp_temp
    AS
        SELECT
            *
        FROM
            emp
        WHERE
            1 <> 1;

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    9999,
    '홍길동',
    'PRESIDENT',
    NULL,
    '2001/01/01',
    5000,
    1000,
    10
);

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    1111,
    '성춘향',
    'MANAGER',
    9999,
    '2002-01-05',
    4000,
    NULL,
    20
);

--날짜 입력 시 년/월/일 순서 => 일/월/년 삽입
--INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
--VALUES(2222, '이순신', 'MANAGER', 9999, '07/01/2001', 4000, NULL, 20);

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    2222,
    '이순신',
    'MANAGER',
    9999,
    TO_DATE('07/01/2001', 'DD/MM/YYYY'),
    4000,
    NULL,
    20
);

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    3333,
    '심봉사',
    'MANAGER',
    9999,
    sysdate,
    4000,
    NULL,
    30
);

--서브쿼리로 INSERT 구현
--emp, salgrade 테이블을 조인 후 급여 등급이 1인 사원만 emp_temp 에 추가

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
)
    SELECT
        e.empno,
        e.ename,
        e.job,
        e.mgr,
        e.hiredate,
        e.sal,
        e.comm,
        e.deptno
    FROM
        emp      e,
        salgrade s
    WHERE
        e.sal BETWEEN s.losal AND s.hisal
        AND s.grade = 1;

SELECT
    *
FROM
    emp_temp;

COMMIT;

-- UPDATE : 테이블에 있는 데이터 수정

--UPDATE 테이블명
--SET 변경할 열이름 = 데이터, 변경할 열이름 = 데이터......
--WHERE 변경을 위한 대상 행을 선별하기 위한 조건

SELECT
    *
FROM
    dept_temp;

-- dept_temp loc 열의 모든 값을 seoul 로 변경
UPDATE dept_temp
SET
    loc = 'SEOUL';

ROLLBACK;

--데이터 일부분 수정 : where 사용
--dept_temp 부서번호가 40번인 loc열의 값을 seoul 로 변경
UPDATE dept_temp
SET
    loc = 'SEOUL'
WHERE
    deptno = 40;

-- emp_temp 사원들 중에서 급여가 2500 이하인 사원만 추가수당을 50으로 수정
UPDATE emp_temp
SET
    comm = 50
WHERE
    sal <= 2500;

-- 서브쿼리를 사용하여 데이터 수정
-- dept 테이블의 40번 부서의 dname, loc를 dept_temp 40번 부서의 dname, loc로 업데이트

UPDATE dept_temp
SET
    ( dname,
      loc ) = (
        SELECT
            dname,
            loc
        FROM
            dept
        WHERE
            deptno = 40
    )
WHERE
    deptno = 40;

COMMIT;

-- DELETE : 테이블에 있는 데이터 삭제
--DELETE 테이블명
--FROM (선택)
--WHERE 삭제 데이터를 선별하기 위한 조건식

CREATE TABLE emp_temp2
    AS
        SELECT
            *
        FROM
            emp;

-- job이 MANAGER 인 사원 삭제

DELETE FROM emp_temp2
WHERE
    job = 'MANAGER';

SELECT
    *
FROM
    emp_temp2;

--job이 SALESMAN인 사원 삭제
DELETE FROM emp_temp2
WHERE
    job = 'SALESMAN';

--전체 데이터 삭제
DELETE emp_temp2;

ROLLBACK;

-- 서브쿼리를 사용하여 삭제
-- 급여 등급이 3등급이고, 30번 부서의 사원 삭제

DELETE FROM emp_temp2
WHERE
    empno IN (
        SELECT
            e.empno
        FROM
            emp_temp2 e, salgrade  s
        WHERE
            e.sal BETWEEN s.losal AND s.hisal
            AND e.deptno = 30
    );

SELECT
    *
FROM
    emp_temp2;

--실습1) 

CREATE TABLE exam_emp
    AS
        SELECT
            *
        FROM
            emp;

CREATE TABLE exam_dept
    AS
        SELECT
            *
        FROM
            emp;

CREATE TABLE exam_emp
    AS
        SELECT
            *
        FROM
            emp;

DROP TABLE exam_emp;

INSERT INTO exam_emp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    7201,
    'TEST_USER1',
    'MANAGER',
    7788,
    '2016-01-02',
    4500,
    'NULL',
    50
);

SELECT
    *
FROM
    exam_emp;

-- 실습3)
UPDATE exam_emp
SET
    deptno = 70
WHERE
    sal > (
        SELECT
            AVG(sal)
        FROM
            exam_emp
        WHERE
            deptno = 50
    );

--실습4)
UPDATE exam_emp
SET
    sal = sal * 1.1,
    deptno = 80
WHERE
    hiredate > (
        SELECT
            MIN(hiredate)
        FROM
            exam_emp
        WHERE
            deptno = 60
    );

--실습5)
DELETE FROM exam_emp
WHERE
    empno IN (
        SELECT
            empno
        FROM
            exam_emp, salgrade
        WHERE
            sal BETWEEN losal AND hisal
            AND grade = 5
    );
                        
                        
-- 트랜잭션 (transaction) : 최소 수행 단위
-- 트랜잭션 제어하는 구문 TCL(transaction control language) : commit, rollback

CREATE TABLE dept_tcl
    AS
        SELECT
            *
        FROM
            dept;

INSERT INTO dept_tcl VALUES (
    50,
    'DATABASE',
    'SEOUL'
);

UPDATE dept_tcl
SET
    loc = 'BUSAN'
WHERE
    deptno = 40;

DELETE FROM dept_tcl
WHERE
    dname = 'RESERACH';

SELECT
    *
FROM
    dept_tcl;

-- 트랜잭션 취소
ROLLBACK;

-- 트랜잭션 최종 반영
COMMIT;

-- 세션 : 어떤 활동을 위한 시간이나 기간
-- 데이터베이스 세션 : 데이터베이스 접속을 시작으로 관련작업 수행한 후 접속 종료
-- LOCK : 

DELETE FROM dept_tcl
WHERE
    deptno = 50;

UPDATE dept_tcl
SET
    loc = 'SEOUL'
WHERE
    deptno = 30;

SELECT
    *
FROM
    dept_temp;


--------------------------------------------------------------
--3월 27일

--DDL : 데이터 정의어(데이터베이스 객체 생성, 수정, 삭제)
-- 1. 테이블 생성
--CREATE TABLE 테이블명(
--    열이름1 자료형,
--    열이름2 자료형,
--    열이름3 자료형,
--    열이름4 자료형
--);

-- 테이블 생성 / 열이름 지정 규칙
-- 1) 테이블 이름은 문자로 시작
-- 2) 테이블 이름은 30BYTE 이하
-- 3) 같은 사용자 소유의 테이블 이름은 중복될 수 없음
-- 4) 테이블 명에 사용할 수 있는 특수문자는 $, #, _ 가능
-- 5) SQL 키워드(SELECT, FROM ....)는 테이블명에 사용할 수 없음

-- 자료형
-- 1. 문자
-- VARCHAR2(길이) : 가변 길이 문자열 데이터 저장(최대 4000BYTE) 
-- CHAR(길이) : 고정 길이 문자열 데이터 저장
-- NVARCHAR2(길이) : 가변 길이(unicode) 데이터 저장
-- name varchar2(10) : 영어는 10자, 한글은 3자까지 입력
-- name nvarchar2(10) : 영어 10자, 한글 10자

-- 2. 숫자
-- NUMBER(전체자릿수, 소수점이하자릿수)

-- 3. 날짜
-- DATE : 날짜, 시간 저장
-- TIMESTAMP 

-- 4. 기타
-- BLOB : 이진 데이터 저장
-- CLOB : 대용량 텍스트 데이터 저장
-- JSON : JSON 데이터 저장

CREATE TABLE emp_ddl (
    empno    NUMBER(4),    --사번을 총 4자리 지정
    ename    VARCHAR2(10),     -- 사원명을 총 10byte 로 지정
    job      VARCHAR2(9),      -- 직무 총 9byte 지정
    mgr      NUMBER(4),        -- 매니저 번호
    hiredate DATE,            -- 날짜/ 시간 저장
    sal      NUMBER(7, 2),         -- 급여를 전체 자릿수 7자리 지정(소수점 2자리까지 허용)
    comm     NUMBER(7, 2),    -- 추가수당
    deptno   NUMBER(2)    -- 부서번호
);

desc emp_ddl;

-- 2. 테이블 수정 : ALTER
-- 1) 열 추가 : ADD 
ALTER TABLE emp_temp2 ADD hp VARCHAR2(20);

-- 2) 열 이름 변경 : RENAME
ALTER TABLE emp_temp2 RENAME COLUMN hp TO tel;

-- 3) 열 자료형 변경 : MODIFY 
ALTER TABLE emp_temp2 MODIFY
    empno NUMBER(5);

-- 4) 특정 열을 삭제 : DROP
ALTER TABLE emp_temp2 DROP COLUMN tel;


-- 3. 테이블 삭제 : DROP
DROP TABLE emp_rename;


-- 테이블 명 변경
RENAME emp_temp2 TO emp_rename;

-- 테이블 데이터 전체 삭제
DELETE FROM emp_rename;

SELECT
    *
FROM
    emp_rename;

ROLLBACK;

TRUNCATE TABLE emp_rename;

-- "SCOTT"."MEMBER"."NATION" 열에 대한 값이 너무 큼(실제: 12, 최대값: 4)
INSERT INTO member VALUES (
    'hong1234',
    '홍길동',
    '서울시 구로구 개봉동',
    '대한민국',
    'hong123@naver.com',
    25,
    NULL
);

-- 데이터 베이스 객체
-- 테이블, 인덱스, 뷰, 데이터 사전, 시퀀스, 시노님, 프로시저, 함수, 패키지, 트리거
-- 생성 : create, 수정 : alter, 삭제 : drop

-- 인덱스 : 더 빠른 검색을 도와줌
-- 인덱스 : 사용자가 직접 특정 테이블 열에 지정 가능
--              기본키(혹은 unique key) 를 생성하면 인덱스로 지정


-- CREATE INDEX 인덱스이름 ON 테이블명(인덱스로 사용할 열이름)

--emp 테이블의 sal 열을 인덱스로 지정
CREATE INDEX idx_emp_sal ON
    emp (
        sal
    );

-- select : 검색방식
-- FULL Scan
-- Index Scan 

SELECT
    *
FROM
    emp
WHERE
    empno = 7900;


-- 인덱스 삭제
DROP INDEX idx_emp_sal;


-- View : 가상 테이블
-- 편리성 : SELECT 문의 복잡도를 완화하기 위해
-- 보안성 : 테이블의 특정 열을 노출하고 싶지 않을 때

-- CREATE[OR REPLACE]   [FORCE | NOFORCE]  VIEW 뷰이름(열이름1,열이름2....)
-- AS (저장할 SELECT 구문)
-- [WITH CHECK OPTION]
-- [WITH READ ONLY]

--SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO =20 뷰로 생성
CREATE VIEW vm_emp20 AS
    (
        SELECT
            empno,
            ename,
            job,
            deptno
        FROM
            emp
        WHERE
            deptno = 20
    );


-- 서브쿼리를 사용
SELECT
    *
FROM
    (
        SELECT
            empno,
            ename,
            job,
            deptno
        FROM
            emp
        WHERE
            deptno = 20
    );

-- 뷰 사용
SELECT
    *
FROM
    vm_emp20;

-- 뷰 삭제
DROP VIEW vm_emp20;

CREATE VIEW vm_emp_read AS
    SELECT
        empno,
        ename,
        job
    FROM
        emp
WITH READ ONLY;

-- VIEW 에 INSERT 작업?
INSERT INTO vm_emp20 VALUES (
    8888,
    'KIM',
    'SALES',
    20
);
-- 원본 변경이 일어남
SELECT
    *
FROM
    emp;

-- 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
INSERT INTO vm_emp_read VALUES (
    9999,
    'KIM',
    'SALES'
);

-- 인라인 뷰 : 일회성으로 만들어서 사용하는 뷰
-- rownum 

SELECT
    ROWNUM,
    e.*
FROM
    emp e;

-- 급여 높은 상위 3인 조회
SELECT
    ROWNUM,
    e.*
FROM
    (
        SELECT
            *
        FROM
            emp e
        ORDER BY
            sal DESC
    ) e
WHERE
    ROWNUM <= 3;


-- 시퀀스 : 규칙에 따라 순번 생성
-- CREATE SEQUENCE 시퀀스이름;

--CREATE SEQUENCE 시퀀스명
--[INCREMENT BY 숫자]     기본값 1
--[START WITH 숫자]         기본값 1
--[MAXVALUE 숫자 | NOMAXVALUE ]
--[MINVALUE 숫자 | NOMINVALUE ]
--[CYCLE | NOCYCLE]  CYCLE 인 경우 MAXVALUE 에 값이 다다르면 시작값부터 다시 시작
--[CACHE 숫자 | NOCACHE ] 시퀀스가 생성할 번호를 미리 메모리에 할당해 놓음(기본 CACHE 20)

CREATE TABLE dept_sequence
    AS
        SELECT
            *
        FROM
            dept
        WHERE
            1 <> 1;

CREATE SEQUENCE seq_dept_sequence INCREMENT BY 10 START WITH 10 MAXVALUE 90 MINVALUE 0 NOCYCLE CACHE 2;

--시퀀스 사용 : 시퀀스이름.CURRFAL(마지막으로 생성된 시퀀스 조회), 시퀀스이름.NEXTVAL(시퀀스 생성)

--부서번호 입력시 시퀀스 사용
INSERT INTO dept_sequence (
    deptno,
    dname,
    loc
) VALUES (
    seq_dept_sequence.NEXTVAL,
    'DATABASE',
    'SEOUL'
);

SELECT
    *
FROM
    dept_sequence;

--시퀀스 삭제
DROP SEQUENCE seq_dept_sequence;

CREATE SEQUENCE seq_dept_sequence INCREMENT BY 3 START WITH 10 MAXVALUE 99 MINVALUE 0 CYCLE CACHE 2;

--SELECT * FROM seq_dept_sequence INCREMENT BY 3 START WITH 10 MAXVALUE 99
--MINVALUE 0
--CYCLE CACHE 2;


-- synonym(동의어) : 테이블, 뷰, 시퀀스 등 객체 이름 대신 사용할 수 있는 다른 이름을 부여하는 객체

-- EMP 테이블의 별칭을 E로 지정
CREATE SYNONYM e FOR emp;

-- PUBLIC : 동의어를 데이터베이스 내 모든 사용자가 사용할 수 있도록 설정
-- CREATE [PUBLIC] SYNONYM E FOR EMP;

SELECT
    *
FROM
    emp;

SELECT
    *
FROM
    e;

DROP SYNONYM e;

--실습1

CREATE TABLE empidx
    AS
        SELECT
            *
        FROM
            emp;

CREATE INDEX idx_empidx_empno ON
    empidx (
        empno
    );

SELECT
    *
FROM
    user_indexes;

-- 실습2)
CREATE VIEW empidx_over15k AS
    (
        SELECT
            empno,
            ename,
            job,
            deptno,
            sal,
            comm
        FROM
            empidx
        WHERE
            sal > 1500
    );

-- 실습3)
CREATE TABLE deptseq
    AS
        SELECT
            *
        FROM
            dept;

CREATE SEQUENCE seq_dept_sequence START WITH 1 INCREMENT BY 1 MAXVALUE 99 MINVALUE 1 NOCYCLE NOCACHE;

--데이터 사전 뷰를 통해 시퀀스 확인
SELECT
    *
FROM
    user_sequences;


-- 제약조건 : 테이블의 특정 열에 지정
--                  NULL 허용 / 불허용, 유일한 값, 조건식을 만족하는 데이터만 입력 가능...
--                  데이터 무결성(데이터 정확성, 일관성 보장) 유지 ==> DML 작업 시 지켜야 함
--                  영역 무결성, 개체 무결성, 참조 무결성
--                  테이블 생성 시 제약조건 지정, OR 생성 후에 ALTER 를 통해 추가, 변경 가능

-- 1) NOT NULL : 빈 값 허용 불가
-- 사용자로부터 입력값이 필수로 입력되어야 할 때 
CREATE TABLE table_notnull (
    login_id  VARCHAR2(20) NOT NULL,
    login_pwd VARCHAR2(20) NOT NULL,
    tel       VARCHAR2(20)
);

INSERT INTO table_notnull (
    login_id,
    login_pwd
) VALUES (
    'hong123',
    'hong123'
);

SELECT
    *
FROM
    table_notnull;

--ORA-01400: NULL을 ("SCOTT"."TABLE_NOTNULL"."LOGIN_PWD") 안에 삽입할 수 없습니다
INSERT INTO table_notnull (
    login_id,
    login_pwd,
    tel
) VALUES (
    'hong123',
    null,
    '010-1234-1234'
);

--전체 제약조건 조회
SELECT * FROM  user_constraints;

--제약조건 + 제약조건 명 지정
CREATE TABLE table_notnull2 (
login_id VARCHAR2(20) CONSTRAINT TBLNN2_LOGIN_NN NOT NULL,
login_pwd VARCHAR2(20) CONSTRAINT TBLNN2_LOGPWD_NN NOT NULL,
tel VARCHAR2(20) 
);

-- 생성한 테이블에 제약조건 추가
--ORA-02296: (SCOTT.) 사용으로 설정 불가 - 널 값이 발견되었습니다
-- 이미 삽입된 데이터도 체크 대상이 되기 됨
ALTER TABLE TABLE_NOTNULL MODIFY(TEL NOT NULL);
ALTER TABLE TABLE_NOTNULL2 MODIFY(TEL CONSTRAINT TBLNN2_TEL_NN NOT NULL);

UPDATE TABLE_NOTNULL
SET TEL = '010-1234-5678'
WHERE LOGIN_ID = 'hong123';

-- 제약조건 명 변경
ALTER TABLE TABLE_NOTNULL2 RENAME CONSTRAINT TBLNN3_TEL_NN TO TBLNN3_TEL_NN

-- 제약조건 명 삭제
ALTER TABLE TABLE_NOTNULL2 DROP CONSTRAINT TBLNN3_TEL_NN;

--2) UNIQUE : 중복되지 않는 값 (null 삽입 가능)
--                  아이디, 전화번호


CREATE TABLE table_unique (
    login_id     VARCHAR2(20) UNIQUE,
    login_pwd  VARCHAR2(20) NOT NULL,
    tel            VARCHAR2(20)
);

INSERT INTO table_unique (
    login_id,
    login_pwd,
    tel
) VALUES (
    'hong123',
    'hong123',
    '010-1234-1234'
);

-- login_id 가 중복된 상황일 때 : unique 위배
-- 무결성 제약 조건(SCOTT.SYS_C008334)에 위배됩니다
INSERT INTO table_unique (
    login_id,
    login_pwd,
    tel
) VALUES (
    null,
    'hong123',
    '010-1234-1234'
);

SELECT * FROM table_unique;

-- 테이블 생성 제약조건 지정, 변경, 삭제 not null 형태와 동일함


-- 3) PRIMARY KEY(PK) : UNIQUE + NOT NULL
CREATE TABLE table_primary (
    login_id     VARCHAR2(20) PRIMARY KEY,
    login_pwd  VARCHAR2(20) NOT NULL,
    tel            VARCHAR2(20)
);

-- PRIMARY KEY ==> INDEX 자동 생성 됨
INSERT INTO table_primary (
    login_id,
    login_pwd,
    tel
) VALUES (
    'hong123',
    'hong123',
    '010-1234-1234'
);

-- 4) 외래키 : Foreign key(FK) : 다른 테이블 간 관계를 정의하는데 사용
--                특정 테이블에서 primary key 제약조건을 지정한 열을 다른 테이블의 특정 열에서 참조

-- 사원 추가 시 부서 번호 입력을 해야 함 => dept 테이블의 deptno 만 삽입

-- 부모 테이블
CRAETE TABLE DEPT_FK(
    DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);


-- 자식 테이블
-- REFERENCES 참조할테이블명 (참조할 열) : 외래키 지정
CREATE TABLE EMP_FK(
    EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO));

INSERT INTO IMP_FK VALUES(1000, 'TEST', 'SALES', 10);

--외래키 제약 조건
-- 부모 테이블 데이터가 데이터 먼저 입력
INSERT INTO DEPT_FK VALUES(10, 'DATABASE', 'SEOUL');

-- 삭제 시 
-- 자식 테이블 데이터 먼저 삭제
-- 부모 테이블 데이터 삭제
DELETE FROM DEPT_FK WHERE DEPTNO=10;

-- 외래 키 제약조건 옵션
-- ON DELETE CASCADE : 부모가 삭제되면 부모를 참조하는 자식 레코드도 같이 삭제
-- ON DELETE SET NULL : 부모가 삭제되면 부모를 참조하는 자식 레코드의 값을 null 변경

CRAETE TABLE DEPT_FK2(
    DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);


CREATE TABLE EMP_FK2(
    EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK2(DEPTNO) ON DELETE CASCADE);

INSERT INTO DEPT_FK2 VALUES(10, 'DATABASE', 'SEOUL');
INSERT INTO EMP_FK2 VALUES(1000, 'TEST', 'SALES', 10);

DELETE FROM DEPT_FK2 WHERE DEPTNO= 10;

--5) CHECK : 열에 지정할 수 있는 값의 범위 또는 패턴 지정
-- 비밀번호는 3자리보다 커야한다

CRAETE TABLE table_CHECK (
    login_id VARCHAR2(20) PRIMARY KEY,
    login_pwd VARCHAR2(20) CHECK (LENGTH(LOGIN_PWD) > 3),
    tel VARCHAR2(20)
);

INSERT INTO TABLE_CHECK VALUES('TEST','123','010-1234-5678');
INSERT INTO TABLE_CHECK VALUES('TEST','1234','010-1234-5678');

-- 6) DEFAULT : 기본값 지정
CRAETE TABLE table_default (
    login_id      VARCHAR2(20) PRIMARY KEY,
    login_pwd   VARCHAR2(20) DEFAULT '1234',
    tel             VARCHAR2(20)
);

INSERT INTO TABLE_DAFAULT VALUES('TEST',NULL,'010-1234-5678');
INSERT INTO TABLE_DAFAULT(login_id, tel) VALUES('TEST1', '010-1234-5678');

SELECT * FROM TABLE_DEFAULT;
commit;



