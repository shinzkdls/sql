CREATE TABLE DEPT_TEMP AS
SELECT *
FROM DEPT
;

SELECT *
FROM DEPT_TEMP
;

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES(50, 'DATABASE', 'SEOUL')
;

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES(60, 'WEB', NULL)
;

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES(70, 'WEB', NULL)
;

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES(80, 'MOBILE', '')
;

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES(90, 'INCHEON')
;


CREATE TABLE EMP_TEMP AS
SELECT *
FROM EMP
WHERE 1=0
;

SELECT *
FROM EMP_TEMP
;

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(9999, '홍길동', 'PRESIDENT', NULL, '2001/01/01', 6000, 500, 10)
;

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(2111, '이순신', 'MANAGER', 9999, '2001/07/01', 4000, NULL, 20)
;

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(3111, '심청이', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30)
;

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT EMPNO
      ,ENAME
      ,JOB
      ,MGR
      ,HIREDATE
      ,SAL
      ,COMM
      ,DEPTNO
FROM EMP E
INNER JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE S.GRADE = 1
;

SELECT *
FROM EMP_TEMP
;


CREATE TABLE DEPT_TEMP2 AS
SELECT *
FROM DEPT
;

SELECT *
FROM DEPT_TEMP2
;

UPDATE DEPT_TEMP2 SET LOC='SEOUL'
;

ROLLBACK;

UPDATE DEPT_TEMP2 
SET DNAME = 'DATABASE'
   ,LOC='SEOUL'
WHERE DEPTNO = 40 -- WHERE절이 반드시 필요!
;

UPDATE DEPT_TEMP2 
SET (DNAME, LOC) = (SELECT DNAME, LOC
					FROM DEPT
					WHERE DEPTNO = 40)
WHERE DEPTNO = 40
;

COMMIT; -- 변경사항 확정 / 롤백 불가


--DELETE 구문으로 테이블에서 값 제거
--보통의 경우, DELETE보다는 UPDATE구문으로 상태 값을 변경

DROP TABLE EMP_TEMP2;

CREATE TABLE EMP_TEMP2 AS
SELECT *
FROM EMP
;

DELETE
FROM EMP_TEMP2
WHERE JOB='MANAGER'
;

SELECT *
FROM EMP_TEMP2
;

DELETE
FROM EMP_TEMP2
WHERE EMPNO IN (SELECT EMPNO
                FROM EMP_TEMP2 A
                INNER JOIN SALGRADE S
                ON A.SAL BETWEEN S.LOSAL AND S.HISAL
                AND S.GRADE=3
                AND DEPTNO=30)
;

SELECT EMPNO
FROM EMP_TEMP2 A
INNER JOIN SALGRADE S
ON A.SAL BETWEEN S.LOSAL AND S.HISAL
AND S.GRADE=3
AND DEPTNO=30
;


/*
 * CREATE문을 정의 : 기존에 없는 테이블 구조를 생성
 * 데이터는 없고, 테이블의 컬럼과 데이터타입, 제약 조건 구조를 생성
 */

CREATE TABLE EMP_NEW(
	EMPNO	NUMBER(4),
	ENMAE	VARCHAR2(10),
	JOB		VARCHAR2(9),
	MGR		NUMBER(4),
	HIREDATE DATE,
	SAL 	NUMBER(7,2),
	COMM 	NUMBER(7,2),
	DEPTNO 	NUMBER(2)
);

SELECT *
FROM EMP
WHERE ROWNUM <= 5
;

SELECT *
FROM EMP_NEW
;

ALTER TABLE EMP_NEW
ADD HP VARCHAR2(20)
;

ALTER TABLE EMP_NEW
RENAME COLUMN HP TO TEL_NO
;

ALTER TABLE EMP_NEW
MODIFY EMPNO NUMBER(5)
;

ALTER TABLE EMP_NEW
DROP COLUMN TEL_NO
;

SELECT *
FROM EMP_NEW
;

-----------------SEQUENCE 생성------------------
CREATE SEQUENCE SEQ_DEPTSEQ
	INCREMENT BY 1
	START WITH 1
	MAXVALUE 999
	MINVALUE 1
	NOCYCLE NOCACHE
;

INSERT INTO DEPT_TEMP2 (DEPTNO, DNAME, LOC)
VALUES(SEQ_DEPTSEQ.NEXTVAL, 'DATABASE', 'SEOUL');

INSERT INTO DEPT_TEMP2 (DEPTNO, DNAME, LOC)
VALUES(SEQ_DEPTSEQ.NEXTVAL, 'WEB', 'BUSAN');

INSERT INTO DEPT_TEMP2 (DEPTNO, DNAME, LOC)
VALUES(SEQ_DEPTSEQ.NEXTVAL, 'MOBILE', 'ILSAN');

SELECT *
FROM DEPT_TEMP2;

COMMIT;

/*
 * 제약 조건(CONSTRAINT) WLWJD
 * 
 * 테이블을 생성할 때, 테이블 컬럼별 제약 조건을 설정 
 * 
 * 자주 사용되는 중요한 제약 조건 유형
 * NOT NULL
 * UNIQUE
 * PK
 * FK
 */


CREATE TABLE LOGIN(
	LOG_ID	 VARCHAR2(20)	NOT NULL
   ,LOG_PWD  VARCHAR2(20)	NOT NULL
   ,TEL 	 VARCHAR2(20) 
);

INSERT INTO LOGIN (LOG_ID, LOG_PWD)
VALUES('TEST01', '1234')

SELECT *
FROM LOGIN
;

ALTER TABLE LOGIN
MODIFY(TEL NOT NULL)
;

UPDATE LOGIN 
SET TEL = '010-1234-5678'
WHERE LOG_ID ='TEST01'
;


SELECT OWNER
      ,CONSTRAINT_NAME
      ,CONSTRAINT_TYPE
      ,TABLE_NAME
FROM DBA_CONSTRAINTS 
WHERE TABLE_NAME LIKE 'LOGIN'
;


COMMIT;

ALTER TABLE LOGIN 
MODIFY (TEL CONSTRAINT TEL_NN NOT NULL)
;

--FROM USER_CONSTRAINTS 에서 가져온 정보로
ALTER TABLE LOGIN 
DROP CONSTRAINT SYS_C007040 -- 제악조건 이름이 없어 주어진 코드 사용
;


/*
 * UNIQUE 키워드 사용
 */

CREATE TABLE LOG_UNIQUE(
	LOG_ID	 VARCHAR2(20)	UNIQUE
   ,LOG_PWD  VARCHAR2(20)	NOT NULL
   ,TEL 	 VARCHAR2(20)
)
;

INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
VALUES('TEST01', 'PWD123', '010-0000-0000')
;

INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
VALUES('TEST02', 'PWD456', '010-0000-0000')
;

INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
VALUES('TEST03', 'PWD789', '010-0000-0000')\
;

SELECT *
FROM LOG_UNIQUE
;

SELECT OWNER
      ,CONSTRAINT_NAME
      ,CONSTRAINT_TYPE
      ,TABLE_NAME
FROM DBA_CONSTRAINTS 
WHERE TABLE_NAME LIKE 'LOG_UNIQUE'
;

/*
 * PK 주키 : 테이블을 설명하는 가장 중요한 키
 * 
 * NOT NULL + UNIQUE + INDEX
 */
 CREATE TABLE LOG_PK(
    LOG_ID	 VARCHAR2(20)	PRIMARY KEY
   ,LOG_PWD  VARCHAR2(20)	NOT NULL
   ,TEL 	 VARCHAR2(20)
 )
 ;

INSERT INTO LOG_PK (LOG_ID, LOG_PWD, TEL)
VALUES('TEST01', 'PWD123', '010-1234-5678')
;

INSERT INTO LOG_PK (LOG_ID, LOG_PWD, TEL)
VALUES('TEST02', 'PWD123', '010-2345-6789')
;

SELECT *
FROM LOG_PK
;


/*
 * FOREIGN KEY 제약 조건 확인
 */
SELECT *
FROM EMP_TEMP
;

INSERT INTO EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(3333,'GHOST','SURPRISE',9999,SYSDATE,1200,NULL,40)
;


/*
 * INDEX 빠른 검색을 위한 색인
 * 
 * 장점 : 순식간에 원하는 값을 탖아 준다
 * 단점 : 입력과 출력이 잦은 경우, 인덱스가 설정된 테이블의 속도가 저하된다
 */

CREATE INDEX IDX_EMP_JOB
ON EMP(JOB)
;

SELECT *
FROM DBA_IND_COLUMNS 
WHERE TABLE_NAME IN ('EMP','DEPT')
;

/*
 * VIEW: 테이블을 편리하게 사용하기 위한 목적으로 생성하는 가상 테이블
 */
CREATE VIEW VW_EMP AS
SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
;

SELECT *
FROM VW_EMP
;

COMMIT;

SELECT *
FROM DBA_VIEWS
WHERE VIEW_NAME='VW_EMP'
;




SELECT ROWNUM, E.*
FROM EMP E
ORDER BY SAL DESC
;

SELECT ROWNUM, E.*
FROM (SELECT *
	  FROM EMP
	  ORDER BY SAL DESC) E
;


SELECT ROWNUM, E.*
FROM (SELECT *
	  FROM EMP
	  ORDER BY SAL DESC) E
WHERE ROWNUM <= 5
;


/*
 * 오라클 DBMS에서 관리하는 관리 테이블 리스트 출력
 */
SELECT *
FROM DICT
WHERE TABLE_NAME LIKE 'USER_CON%'
;

SELECT *
FROM DBA_TABLES
WHERE TABLE_NAME = 'EMP'
;

SELECT *
FROM DBA_USERS
WHERE USERNAME = 'TEST'
;





