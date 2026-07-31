-- 서브쿼리 A
SELECT BA.ASSOMBR_NO
		               , MAX(BA.CRYM) AS LST_PMT_MT
		               , MONTHS_BETWEEN(TO_CHAR(SYSDATE,'YYYYMM')||'01', MAX(BA.CRYM)||'01') AS NO_PAMNT_MT
		            FROM TAMS07.TB_TAAH_MMPYMNT BA
		               , TAMS07.TB_TAAH_PYMNT BB
		           WHERE BA.PYMNT_SEQ = BB.PYMNT_SEQ
		             AND BB.DL_YN = 'N'
                     and ba.PYMNT_DIVCD = '02'
		        GROUP BY BA.ASSOMBR_NO
;

-- 서브쿼리 A (2573461건, 15초)
SELECT COUNT(*)
		            FROM TAMS07.TB_TAAH_MMPYMNT BA
		               , TAMS07.TB_TAAH_PYMNT BB
		           WHERE BA.PYMNT_SEQ = BB.PYMNT_SEQ
		             AND BB.DL_YN = 'N'
                     and ba.PYMNT_DIVCD = '02'
;

-- 6071190건
SELECT COUNT(*) FROM TAMS07.TB_TAAH_MMPYMNT;

-- 4001317건
SELECT COUNT(*) FROM TAMS07.TB_TAAH_PYMNT;

-- 조합원 1인당 월납부내역은 1000건 이하, 평균 250건
SELECT ASSOMBR_NO, COUNT(*) CNT
FROM TAMS07.TB_TAAH_MMPYMNT
GROUP BY ASSOMBR_NO
ORDER BY CNT DESC
;

SELECT AVG(CNT) FROM (

    SELECT ASSOMBR_NO, COUNT(*) CNT
    FROM TAMS07.TB_TAAH_MMPYMNT
    GROUP BY ASSOMBR_NO
    ORDER BY CNT DESC
)
;



-- 개선안
				SELECT BA.ASSOMBR_NO,
					   MAX(BA.CRYM) AS LST_PMT_MT,
					   MONTHS_BETWEEN(
						   TO_CHAR(SYSDATE,'YYYYMM') || '01',
						   MAX(BA.CRYM) || '01'
					   ) AS NO_PAMNT_MT
				FROM TB_TAAH_MMPYMNT BA,
					 TB_TAAH_PYMNT BB
				WHERE BA.PYMNT_SEQ = BB.PYMNT_SEQ
				  AND BB.DL_YN = 'N'
				  AND BA.PYMNT_DIVCD = '02'
		
				  /* 현재 페이지에 표시될 조합원만 납부내역 집계 */
				  AND BA.ASSOMBR_NO IN (
					  SELECT ASSOMBR_NO
					  FROM (
						  SELECT ROWNUM AS PRNUM,
								 ASSOMBR_NO
						  FROM (
							  SELECT C2.ASSOMBR_NO
							  FROM TB_TAAM_ASSOMBR C2
							  WHERE 1 = 1
								AND C2.WLFR_APY_YM IS NOT NULL
							  ORDER BY C2.ASSOMBR_NO
						  )
						  WHERE ROWNUM <= (? * ?)
					  )
					  WHERE PRNUM >= ((? - 1) * ? + 1)
				  )
		
				GROUP BY BA.ASSOMBR_NO