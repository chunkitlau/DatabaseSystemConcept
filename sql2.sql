-- 1

CREATE TABLE tbCell(
	"CITY"          varchar(255),
    "SECTOR_ID"     varchar(50),
    "SECTOR_NAME"   varchar(255),
    "ENODEBID"      int,
    "ENODEB_NAME"   varchar(255),
    "EARFCN"        int,
    "PCI"           int,
    "PSS"           int,
    "SSS"           int,
    "TAC"           int,
    "VENDOR"        varchar(255),
    "LONGITUDE"     float,
    "LATITUDE"      float,
    "STYLE"         varchar(255),
    "AZIMUTH"       float,
    "HEIGHT"        float,
    "ELECTTILT"     float,
    "MECHTILT"      float,
    "TOTLETILT"     float
);
drop table tbcell;



-- 5
SELECT * FROM tbcellkpi
WHERE "RCC连接成功率" > 0.95
UNION ALL
SELECT * FROM tbcellkpi
WHERE "E-RAB建立成功总次数" > 0.99;


-- 6
(select "ENODEBID", "ENODEB_NAME"
FROM tbcell)
EXCEPT ALL(
    SELECT "ENODEBID", "ENODEB_NAME"
    FROM tbcell AS T
    WHERE EXISTS(
        SELECT * FROM tbcell AS S
        WHERE T."LATITUDE" < S."LATITUDE")
);

SELECT *
FROM tbcell
WHERE "LATITUDE" = (SELECT max("LATITUDE") AS mxL from tbcell);


-- 11 (1)
SELECT max(S.sm), min(S.sm), avg(S.sm)
FROM (
     SELECT T."Sector_ID" as id, sum("Traffic") as sm
     FROM tbcell_traffic as T join tbcell as C on T."Sector_ID" = C."SECTOR_ID"
     WHERE (extract(YEAR FROM "Date") = 2020)
        AND (extract(Month FROM "Date") = 5)
        AND ("LONGITUDE" BETWEEN 112 AND 113)
        AND ("LATITUDE" BETWEEN  33 AND 34)
        AND ("Hour" BETWEEN 9 AND 11 OR "Hour" BETWEEN 19 AND 21)
    GROUP BY id
) as S;

-- 11 (2)
WITH S AS (
    SELECT T."Sector_ID" as id,C."SECTOR_NAME", C."LONGITUDE", C."LATITUDE", sum("Traffic") as sm
     FROM tbcell_traffic as T join tbcell as C on T."Sector_ID" = C."SECTOR_ID"
     WHERE (extract(YEAR FROM "Date") = 2020)
        AND (extract(Month FROM "Date") = 5)
        AND ("LONGITUDE" BETWEEN 112 AND 113)
        AND ("LATITUDE" BETWEEN  33 AND 34)
        AND ("Hour" BETWEEN 9 AND 11 OR "Hour" BETWEEN 19 AND 21)
    GROUP BY id, C."SECTOR_NAME", C."LONGITUDE", C."LATITUDE"
)
SELECT * FROM S
WHERE sm = (SELECT MAX(sm) FROM S);

-- 12

SELECT A."SECTOR_ID", A."SECTOR_NAME", count("N_SECTOR_ID") as cnt
FROM tbcell AS A join tbadjcell AS B on A."SECTOR_ID"=B."S_SECTOR_ID"
join tboptcell AS C on B."S_SECTOR_ID" = C."SECTOR_ID"
GROUP BY A."SECTOR_ID", A."SECTOR_NAME"
ORDER BY cnt DESC;


-- 13

WITH S AS(
 SELECT T2."Sector_ID", SUM(T2."Traffic") AS sm
 FROM tbcell AS T1 join tbcell_traffic AS T2 on T1."SECTOR_ID" = T2."Sector_ID"
 WHERE EXISTS (
   SELECT * FROM tbcell
   WHERE T1."SECTOR_ID" = tbcell."SECTOR_ID" AND tbcell."EARFCN"=38400
 )
 GROUP BY T2."Sector_ID", T2."Traffic"
)
SELECT * FROM S
WHERE sm > (SELECT AVG(sm) FROM S)
ORDER BY sm;



-- 20

WITH S AS(
    SELECT T1.小区名称 AS name, sum("RCC连接成功率")/3 as av
    FROM tbcellkpi AS T1
    WHERE T1.起始时间 = '07/17/2020 00:00:00' OR T1.起始时间 = '07/18/2020 00:00:00' OR T1.起始时间 = '07/19/2020 00:00:00'
    GROUP BY T1.小区名称
)
SELECT tbcell."SECTOR_ID", S.av
FROM tbcell join S on S.name = tbcell."SECTOR_NAME"
WHERE av > 0.992;

-- 21
WITH S AS(
    select T1."S_SECTOR_ID" as id, count(T1."N_SECTOR_ID") as cnt
    from tbadjcell as T1
    GROUP BY T1."S_SECTOR_ID"
)
SELECT id, cnt
from S
WHERE cnt = (select max(cnt) from S);

-- 22

create table tbMROData(
    "TimeStamp"	    varchar(30),
    "ServingSector" varchar(50),
    "InterferingSector"	varchar(50),
    "LteScRSRP" float,
    "LteNcRSRP" float,
    "LteNcEarfcn"   int,
    "LteNcPci"  smallint
)

select max(S.cnt) < 2
from (
    select count(*) as cnt
    from tbmrodata
    group by "TimeStamp", "ServingSector", "InterferingSector"
) as S;

-- 23

create table tbPCIAssignment (
    "ASSIGN_ID" smallint,
    "EARFCN"    int,
    "SECTOR_ID" varchar(50),
    "SECTOR_NAME"   varchar(200),
    "ENODEB_ID" int,
    "PCI"   int,
    "PSS"   int,
    "SSS"   int,
    "LONGITUDE"	float,
    "LATITUDE"	float,
    "STYLE" varchar(50),
    "OPT_DATETIM"   varchar(50)
);
drop table tbPCIAssignment;

select max(S.cnt) < 2
from (
    select count(distinct "PCI") as cnt
    from tbpciassignment
    group by "ENODEB_ID"
) as S;


-- 24

insert into tbadjcell values ('124673-0','124683-1',38400, 38950);


-- 25

create table SecAdjCell(
    "S_SECTOR_ID"   varchar(50),
    "N_SECTOR_ID"   varchar(50)
);
drop table SecAdjCell;

select count(*)
from tbadjcell;

with S as (
    select "S_SECTOR_ID", "N_SECTOR_ID", T1."EARFCN", T2."EARFCN"
    from secadjcell as T0 join tbcell as T1 on T1."SECTOR_ID"=T0."S_SECTOR_ID" join tbcell as T2 on T2."SECTOR_ID" = T0."N_SECTOR_ID"
    where T0."S_SECTOR_ID" = '124673-0'
)
insert into tbadjcell(
    select * from S
    except
    select *
    from tbadjcell
);

-- 26

create table tbHandover(
    "SSECTOR_ID"    varchar(50),
    "NSECTOR_ID"    varchar(50),
    "HOATT"         int
);
drop table tbHandover;

delete from tbhandover
where "HOATT" = (select min("HOATT") from tbhandover);


-- 27
update tbcell S
set "PCI" = (
    select "PCI"
    from tbpciassignment
    where "SECTOR_ID" = S."SECTOR_ID")
where exists(
    select *
    from tbpciassignment
    where S."SECTOR_ID" = "SECTOR_ID"
    );

-- 28

create table tbATUC2I(
    "SECTOR_ID"	varchar(50),
    "NCELL_ID"  varchar(50),
    "RATIO_ALL"	float,
    "RANK"	    int,
    "COSITE"	smallint
);
drop table tbatuc2i;

update tbatuc2i
set "RANK" = case
    when "COSITE" = 1 and "RANK" > 0 then "RANK" - 1
    when "COSITE" = 0 then "RANK" + 1
    end
where "SECTOR_ID" = '238397-1';