SELECT ENAME 
FROM EMP
WHERE DEPTNO = 10
;

SELECT ENAME 
FROM EMP 
WHERE DEPTNO = 10
AND JOB = 'ANALYST'
;

SELECT *
FROM EMP
WHERE SAL > 2500
ORDER BY SAL 
;

SELECT *
FROM EMP
WHERE SAL ^= 5000
;

SELECT *
FROM EMP
WHERE ENAME LIKE 'M%'
;

SELECT *
FROM EMP
WHERE COMM IS NULL
;

SELECT *
FROM EMP
WHERE DEPTNO = 10
UNION 
SELECT *
FROM EMP
WHERE DEPTNO = 20
;

SELECT *
FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT *
FROM EMP
WHERE DEPTNO = 10
;

SELECT *
FROM v$sqlfn_metadata
;

SELECT '010-1234-5678' AS BEFORE
       ,REPLACE('010-1234-5678','-',' ') AS REPLACE_1
       ,REPLACE('010-1234-5678','-','') AS REPLACE_2
FROM DUAL
;

SELECT SYSDATE 
      ,SYSDATE -1 AS YESTERDAY
FROM DUAL
;

SELECT SYSDATE 
      ,NEXT_DAY(SYSDATE,'월')
FROM DUAL
;

SELECT SYSDATE 
      ,LAST_DAY(SYSDATE)
FROM DUAL
;

SELECT EMPNO
      ,ENAME 
      ,EMPNO +'500'
FROM EMP
WHERE ENAME ='SCOTT'
;

SELECT SYSDATE 
      ,TO_CHAR(SYSDATE,'MM') AS MM
      ,TO_CHAR(SYSDATE,'MON') AS MON 
      ,TO_CHAR(SYSDATE,'MONTH') AS MONTH
      ,TO_CHAR(SYSDATE,'DD') AS DD 
      ,TO_CHAR(SYSDATE,'DY') AS DY 
      ,TO_CHAR(SYSDATE,'DAY') AS DAY 
FROM DUAL
;

SELECT TO_NUMBER('3,300','999,999') - TO_NUMBER('1,100','999,999')
FROM DUAL
;

SELECT TO_DATE(SYSDATE,'YYYY-MM-DD') AS TODATE1
	  ,TO_DATE('20230317','YYYY-MM-DD') AS TODATE2
FROM DUAL
;

SELECT COUNT(COMM)
FROM EMP
;

SELECT EMPNO 
      ,ENAME 
      ,SAL
      ,COMM 
      ,NVL(COMM,0) AS COMM2
FROM EMP;

SELECT EMPNO 
      ,ENAME 
      ,SAL
      ,COMM 
      ,NVL2(COMM,'O','X') AS COMM2
FROM EMP
;

SELECT EMPNO 
      ,ENAME 
      ,SAL
      ,COMM 
      ,DECODE(JOB,
              'MANAGER', SAL*0.2,
              'SALESMAN', SAL*0.3,
              'ANALYST', SAL*0.05,
              SAL*0.1) AS BONUS
FROM EMP
;
	  