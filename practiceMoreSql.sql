--Uniary query
SELECT T1.f1, T1.2.f2
FROM t1 AS T1, t1 AS T1.2
WHERE T1.Dep = T1.3.Ind

--two table query
SELECT t1f1, t2f2
FROM t1, t2
WHERE t1.MUL = t2.PRI;

--OR using Inner JOIN - USING(MUL/PRI)

SELECT t1f1, t2f2
FROM t1, t2
WHERE t1 JOIN t2 USING(MULI/PRI)

--OR using JOIN - ON conventional notation
SELECT t1f1, t2f2
FROM t1, t2
WHERE t1 JOIN t2
ON t1.MUL, t2.PRI

--MULTI-Table query
SELECT t1f1, t2f2, t3f3, t4f4,t5f5
FROM t1,t2,t3,t4,t5
WHERE t3 JOIN t1 USING(MUL/PRI)
         JOIN t2 ON t3.MUL = t2.PRI --USE ON if the key connecting both table is ambigious(found in another table or if the keys have different names in oth tables)
	 JOIN t4 USING(MUL/PRI)
	 JOIN t5 ON t3.MUL = t45.PRI
