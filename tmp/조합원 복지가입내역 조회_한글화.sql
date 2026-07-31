-- 한글화
SELECT C.조합원번호
     , C.조합원명
     , B.차량번호
     , D.조합비 면제기간
     , DECODE(C.복지가입여부, 'Y', NVL(A.최종납부월,''), '') AS 최종납부월
  FROM ( SELECT BA.조합원번호
              , MAX(BA.기준년월) AS 최종납부월
           FROM 월납부내역 BA
              , 납부내역 BB
          WHERE BA.납부일련번호 = BB.납부일련번호
            AND BB.삭제여부 = 'N'
            AND BA.납부구분코드 = '02'
          GROUP BY BA.조합원번호
       ) A
     , ( SELECT 차량번호, 조합원번호
           FROM 택시이력
          WHERE (순번, 조합원번호) in (SELECT MAX(순번) as 순번
                                            , 조합원번호 
                                         FROM 택시이력 
                                        GROUP BY 조합원번호)
       ) B
     , (SELECT 조합원번호
             , 조합원명
             , 복지가입여부
          FROM 조합원기본
       ) C
     , (SELECT A.조합원번호
             , SUM(MONTHS_BETWEEN(LEAST(미납기간에서 제외할 종료월||'01',현재월||'01'),GREATEST(미납기간에서 제외할 시작월||'01',최종납부월||'01'))+1) AS 조합비 면제기간
          FROM ( SELECT 조합원번호
                      , MAX(기준년월) AS 최종납부월
                   FROM 월납부내역
                  WHERE 납부구분코드 = '02'
                  GROUP BY 조합원번호
               ) A
             , ( SELECT 조합원번호
                      , 순번
                      , 시작일자
                      , 종료일자
                      , TO_CHAR(ADD_MONTHS(시작일자,1),'YYYYMM') AS 미납기간에서 제외할 시작월
                      , TO_CHAR(ADD_MONTHS(NVL(종료일자, '0'), -1),'YYYYMM') AS 미납기간에서 제외할 종료월
                      , TO_CHAR(SYSDATE,'YYYYMM') AS 현재월
                   FROM 조합원행정처분내역
                  WHERE 행정처리코드 = '03'
                    AND SUBSTR(시작일자,1,6) != SUBSTR(종료일자,1,6)
               ) B
         WHERE A.조합원번호 = B.조합원번호
           AND 최종납부월 <= 현재월               
           AND (   미납기간에서 제외할 시작월 > 최종납부월
               OR (    미납기간에서 제외할 종료월 > 최종납부월
                   AND 미납기간에서 제외할 종료월 < TO_CHAR(SYSDATE,'YYYYMM'))
               )
         GROUP BY A.조합원번호
       ) D
 WHERE C.조합원번호 = A.조합원번호 (+)
   AND C.조합원번호 = B.조합원번호 (+)
   AND C.조합원번호 = D.조합원번호 (+)
 ORDER BY C.조합원번호