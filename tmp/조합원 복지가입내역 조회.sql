-- 원본 쿼리(16초)
        SELECT C.ASSOMBR_NO
             , C.ASSOMBR_NM
             , B.WO_CARNO
             , C.BIRD
             , C.WLFR_JN_YN
             , DECODE(C.WLFR_JN_YN, 'Y', (NVL(A.NO_PAMNT_MT, C.NO_PAMNT_MT) - NVL(D.RM_MT,0))||'개월','') AS NO_PAMNT_MT
             , D.RM_MT
             , C.WLFR_APY_YM
             , DECODE(C.WLFR_JN_YN, 'Y', NVL(A.LST_PMT_MT,''), '') AS LST_PMT_MT
          FROM ( SELECT BA.ASSOMBR_NO
		               , MAX(BA.CRYM) AS LST_PMT_MT
		               , MONTHS_BETWEEN(TO_CHAR(SYSDATE,'YYYYMM')||'01', MAX(BA.CRYM)||'01') AS NO_PAMNT_MT
		            FROM TAMS07.TB_TAAH_MMPYMNT BA
		               , TAMS07.TB_TAAH_PYMNT BB
		           WHERE BA.PYMNT_SEQ = BB.PYMNT_SEQ
		             AND BB.DL_YN = 'N'
                     and ba.PYMNT_DIVCD = '02'
		        GROUP BY BA.ASSOMBR_NO
               ) A
             ,  (
             	  /* 2018.11.30 이상훈, 차넘버를 max로 가져오다니..누구야?
			      SELECT MAX(WO_CARNO) WO_CARNO,  ASSOMBR_NO
			      FROM TAMS07.TB_TAAI_TAXI
			      GROUP BY  ASSOMBR_NO
			       */
				  SELECT WO_CARNO, ASSOMBR_NO
 				  FROM TAMS07.TB_TAAI_TAXI
 				  WHERE (SNO, ASSOMBR_NO) in (SELECT MAX(SNO) as SNO,ASSOMBR_NO FROM TAMS07.TB_TAAI_TAXI GROUP BY ASSOMBR_NO)
			      ) B
             , (SELECT ASSOMBR_NO
                     , ASSOMBR_NM
                     , BIRD
                     , WLFR_JN_YN
                     , WLFR_APY_YM
                     , BDT
                     , MONTHS_BETWEEN(TO_CHAR(SYSDATE,'YYYYMM')||'01', ADD_MONTHS(WLFR_APY_YM||'01',-1)) AS NO_PAMNT_MT
                  FROM TAMS07.TB_TAAM_ASSOMBR  /*행정_조합원기본*/
               ) C
             , (SELECT A.ASSOMBR_NO
                     , SUM(MONTHS_BETWEEN(LEAST(RM_EDT||'01',TSMT||'01'),GREATEST(RM_SDT||'01',LST_PMT_MT||'01'))+1) AS RM_MT
                  FROM ( SELECT ASSOMBR_NO
                              , MAX(CRYM) AS LST_PMT_MT
                           FROM TAMS07.TB_TAAH_MMPYMNT
                          WHERE PYMNT_DIVCD = '02'
                          GROUP BY ASSOMBR_NO
                        ) A
                     , ( SELECT ASSOMBR_NO
                              , SNO
                              , B.SDT
                              , B.EDT
                              , TO_CHAR(ADD_MONTHS(B.SDT,1),'YYYYMM') AS RM_SDT              /* 미납기간에서 제외할 시작월*/
                              , TO_CHAR(ADD_MONTHS(NVL(B.EDT, '0'), -1),'YYYYMM') AS RM_EDT  /* 미납기간에서 제외할 종료월*/
                              , TO_CHAR(SYSDATE,'YYYYMM') AS TSMT                            /* 현재월*/
                           FROM TAMS07.TB_TAAH_ASSOMBRGOVR B /* 행정_조합원행정처분내역*/
                          WHERE B.GOVR_MSR_CD = '03'
                            AND SUBSTR(B.SDT,1,6) != SUBSTR(B.EDT,1,6)
                       ) B
                 WHERE A.ASSOMBR_NO = B.ASSOMBR_NO
                   AND LST_PMT_MT <= TSMT               
                   AND (        RM_SDT > LST_PMT_MT
                        OR (    RM_EDT > LST_PMT_MT
                  AND RM_EDT < TO_CHAR(SYSDATE,'YYYYMM')))
                 GROUP BY A.ASSOMBR_NO
               ) D /*납부기간내 휴지로 인한 조합비 면제기간*/
         WHERE C.ASSOMBR_NO = A.ASSOMBR_NO (+)
           AND C.ASSOMBR_NO = B.ASSOMBR_NO (+)
           AND C.ASSOMBR_NO = D.ASSOMBR_NO (+)
        ORDER BY C.ASSOMBR_NO
;
        
        
-- 튜닝 쿼리(0.5초)        
		SELECT C.ASSOMBR_NO,
				   C.ASSOMBR_NM,
				   B.WO_CARNO,
				   C.BIRD,
				   C.WLFR_JN_YN,
				   DECODE(
					   C.WLFR_JN_YN,
					   'Y',
					   (
						   NVL(A.NO_PAMNT_MT, C.NO_PAMNT_MT)
						   - NVL(D.RM_MT, 0)
					   ) || '개월',
					   ''
				   ) AS NO_PAMNT_MT,
				   D.RM_MT,
				   C.WLFR_APY_YM,
				   DECODE(
					   C.WLFR_JN_YN,
					   'Y',
					   NVL(A.LST_PMT_MT, ''),
					   ''
				   ) AS LST_PMT_MT
			FROM (
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
			) A,
			(
				SELECT WO_CARNO,
					   ASSOMBR_NO
				FROM TB_TAAI_TAXI
				WHERE (SNO, ASSOMBR_NO) IN (
					SELECT MAX(SNO) AS SNO,
						   ASSOMBR_NO
					FROM TB_TAAI_TAXI
					GROUP BY ASSOMBR_NO
				)
			) B,
			(
				SELECT ASSOMBR_NO,
					   ASSOMBR_NM,
					   BIRD,
					   WLFR_JN_YN,
					   WLFR_APY_YM,
					   BDT,
					   MONTHS_BETWEEN(
						   TO_CHAR(SYSDATE,'YYYYMM') || '01',
						   ADD_MONTHS(WLFR_APY_YM || '01', -1)
					   ) AS NO_PAMNT_MT
				FROM TB_TAAM_ASSOMBR
				WHERE
					WLFR_APY_YM IS NOT NULL
			) C,
			(
				SELECT A.ASSOMBR_NO,
					   SUM(
						   MONTHS_BETWEEN(
							   LEAST(RM_EDT || '01', TSMT || '01'),
							   GREATEST(RM_SDT || '01', LST_PMT_MT || '01')
						   ) + 1
					   ) AS RM_MT
				FROM (
					SELECT ASSOMBR_NO,
						   MAX(CRYM) AS LST_PMT_MT
					FROM TB_TAAH_MMPYMNT
					WHERE PYMNT_DIVCD = '02'
					GROUP BY ASSOMBR_NO
				) A,
				(
					SELECT ASSOMBR_NO,
						   SNO,
						   B.SDT,
						   B.EDT,
						   TO_CHAR(ADD_MONTHS(B.SDT, 1), 'YYYYMM') AS RM_SDT,
						   TO_CHAR(ADD_MONTHS(NVL(B.EDT, '0'), -1), 'YYYYMM') AS RM_EDT,
						   TO_CHAR(SYSDATE, 'YYYYMM') AS TSMT
					FROM TB_TAAH_ASSOMBRGOVR B
					WHERE B.GOVR_MSR_CD = '03'
					  AND SUBSTR(B.SDT, 1, 6) != SUBSTR(B.EDT, 1, 6)
				) B
				WHERE A.ASSOMBR_NO = B.ASSOMBR_NO
				  AND LST_PMT_MT <= TSMT
				  AND (
						RM_SDT > LST_PMT_MT
						OR (
							RM_EDT > LST_PMT_MT
							AND RM_EDT < TO_CHAR(SYSDATE, 'YYYYMM')
						)
					  )
				GROUP BY A.ASSOMBR_NO
			) D
			WHERE C.ASSOMBR_NO = A.ASSOMBR_NO (+)
			  AND C.ASSOMBR_NO = B.ASSOMBR_NO (+)
			  AND C.ASSOMBR_NO = D.ASSOMBR_NO (+)
			ORDER BY C.ASSOMBR_NO