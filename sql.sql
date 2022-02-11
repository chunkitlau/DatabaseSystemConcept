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

CREATE TABLE tbOptCell (
    "SECTOR_ID"         varchar(50),
    "EARFCN"            int,
    "CELL_TYPE"         varchar(50)
); 

CREATE TABLE tbPCIAssignment (
    "ASSIGN_ID"         int,
    "EARFCN"            int,
    "SECTOR_ID"         varchar(50),
    "SECTOR_NAME"       varchar(200),
    "ENODEB_ID"         int,
    "PCI"               int,
    "PSS"               int,
    "SSS"               int,
    "LONGITUDE"         float,
    "LATITUDE"          float,
    "STYLE"             varchar(50),
    "OPT_DATETIME"      date
); 

CREATE TABLE tbATUdata (
    "seq"               int,
    "FileName"          varchar(255),
    "Time"              varchar(255),
    "Longitude"         float,
    "Latitude"          float,
    "CellID"            varchar(50),
    "TAC"               int,
    "EARFCN"            int,
    "PCI"               int,
    "RSRP"              float,
    "RS SINR"           float,
    "NCell_ID_1"        varchar(50),
    "NCell_EARFCN_1"    int,
    "NCell_PCI_1"       int,
    "NCell_RSRP_1"      float,
    "NCell_ID_2"        varchar(50),
    "NCell_EARFCN_2"    int,
    "NCell_PCI_2"       int,
    "NCell_RSRP_2"      float,
    "NCell_ID_3"        varchar(50),
    "NCell_EARFCN_3"    int,
    "NCell_PCI_3"       int,
    "NCell_RSRP_3"      float,
    "NCell_ID_4"        varchar(50),
    "NCell_EARFCN_4"    int,
    "NCell_PCI_4"       int,
    "NCell_RSRP_4"      float,
    "NCell_ID_5"        varchar(50),
    "NCell_EARFCN_5"    int,
    "NCell_PCI_5"       int,
    "NCell_RSRP_5"      float,
    "NCell_ID_6"        varchar(50),
    "NCell_EARFCN_6"    int,
    "NCell_PCI_6"       int,
    "NCell_RSRP_6"      float
); 

CREATE TABLE tbHandOver (
    "CITY"          varchar(255),
    "SCELL"         varchar(50),
    "NCELL"         varchar(50),
    "HOATT"         int,
    "HOSUCC"        int,
    "HOSUCCRATE"    float
); 

CREATE TABLE tbCellKPI (
    "起始时间"                                              date,
    "网元/基站名称"                                         varchar(255),
    "小区"                                                  varchar(255),
    "小区名称"                                              varchar(255),
    "RRC连接建立完成次数 (无)"                              int,
    "RRC连接请求次数（包括重发） (无)"                      int,
    "RRC建立成功率qf (%)"                                   float,
    "E-RAB建立成功总次数 (无)"                              int,
    "E-RAB建立尝试总次数 (无)"                              int,
    "E-RAB建立成功率2 (%)"                                  float,
    "eNodeB触发的E-RAB异常释放总次数 (无)"                  int,
    "小区切换出E-RAB异常释放总次数 (无)"                    int,
    "E-RAB掉线率(新) (%)"                                   float,
    "无线接通率ay (%)"                                      float,
    "eNodeB发起的S1 RESET导致的UE Context释放次数 (无)"     int,
    "UE Context异常释放次数 (无)"                           int,
    "UE Context建立成功总次数 (无)"                         int,
    "无线掉线率 (%)"                                        float,
    "eNodeB内异频切换出成功次数 (无)"                       int,
    "eNodeB内异频切换出尝试次数 (无)"                       int,
    "eNodeB内同频切换出成功次数 (无)"                       int,
    "eNodeB内同频切换出尝试次数 (无)"                       int,
    "eNodeB间异频切换出成功次数 (无)"                       int,
    "eNodeB间异频切换出尝试次数 (无)"                       int,
    "eNodeB间同频切换出成功次数 (无)"                       int,
    "eNodeB间同频切换出尝试次数 (无)"                       int,
    "eNB内切换成功率 (%)"                                   float,
    "eNB间切换成功率 (%)"                                   float,
    "同频切换成功率zsp (%)"                                 float,
    "异频切换成功率zsp (%)"                                 float,
    "切换成功率 (%)"                                        float,
    "小区PDCP层所接收到的上行数据的总吞吐量 (比特)"           varchar(50),
    "小区PDCP层所发送的下行数据的总吞吐量 (比特)"             varchar(50),
    "RRC重建请求次数 (无)"                                  int,
    "RRC连接重建比率 (%)"                                   float,
    "通过重建回源小区的eNodeB间同频切换出执行成功次数 (无)"   int,
    "通过重建回源小区的eNodeB间异频切换出执行成功次数 (无)"   int,
    "通过重建回源小区的eNodeB内同频切换出执行成功次数 (无)"   int,
    "通过重建回源小区的eNodeB内异频切换出执行成功次数 (无)"   int,
    "eNB内切换出成功次数 (次)"                              int,
    "eNB内切换出请求次数 (次)"                              int
); 

// 14
SELECT t1."SECTOR_ID",
    t1."SECTOR_NAME",
    t1."PCI",
    t2."PCI"
FROM "tbcell" AS t1 JOIN "tbpciassignment" AS t2 ON t1."SECTOR_ID" = t2."SECTOR_ID"
WHERE t1."SECTOR_ID" IN (SELECT "SECTOR_ID" FROM "tboptcell" WHERE "CELL_TYPE" = '优化区')
    AND t1."PCI" != t2."PCI";

SELECT t1."SECTOR_ID",
    t1."SECTOR_NAME",
    t1."PCI",
    t2."PCI"
FROM "tbcell" AS t1 JOIN "tbpciassignment" AS t2 ON t1."SECTOR_ID" = t2."SECTOR_ID"
    JOIN "tboptcell" AS t3 ON t1."SECTOR_ID" = t3."SECTOR_ID"
WHERE t3."CELL_TYPE" = '优化区'
    AND t1."PCI" != t2."PCI";

// 15-1
select "SECTOR_ID",
    "SECTOR_NAME",
    "HEIGHT"
from "tbcell"
where "HEIGHT" > some(
    select "HEIGHT"
    from "tbcell"
    where "LONGITUDE" between 110 and 120
        and "LATITUDE" between 30 and 40)

// 15-2
select distinct t1."SECTOR_ID",
  t1."SECTOR_NAME",
  t2."RSRP"
from "tbcell" as t1 join "tbatudata" as t2 on t1."SECTOR_ID" = t2."CellID"
where t2."RSRP" > some(
    select "RSRP" from "tbcell" join "tbatudata" on "SECTOR_ID" = "CellID" 
        and "ENODEBID" = 253903)

// 16-1
with T0("Sector_ID", "TrafficSum") as (
    select "Sector_ID",
        sum("Traffic") as "TrafficSum"
    from "tbcelltraffic"
    group by "Sector_ID") 
select "Sector_ID",
    "TrafficSum"
from T0
where "TrafficSum" >= all (select "TrafficSum" from T0)

// 16-2
select "SCELL",
    "NCELL",
    "HOATT"
from "tbhandover"
where "HOATT" >= all(
    select "HOATT"
    from "tbhandover"
    where "HOATT" is not null
)

// 17-1
select distinct "SCELL"
from "tbhandover" as t1
where not exists (
    select '15290-128'
    union
    select '259595-1'
    union
    select '124711-0'
    union
    select '47444-1'
    except
    select "NCELL"
    from "tbhandover" as t2
    where t1."SCELL" = t2."SCELL"
);

// 17-2
select distinct "S_SECTOR_ID"
from "tbadjcell" as t1
where not exists(
    select "N_SECTOR_ID"
    from "tbsecadjcell" as t3
    where t1."S_SECTOR_ID" = t3."S_SECTOR_ID"
    except
    select "N_SECTOR_ID"
    from "tbadjcell" as t2
    where t1."S_SECTOR_ID" = t2."S_SECTOR_ID"
)
or not exists(
    select "N_SECTOR_ID"
    from "tbadjcell" as t2
    where t1."S_SECTOR_ID" = t2."S_SECTOR_ID"
    except
    select "N_SECTOR_ID"
    from "tbsecadjcell" as t3
    where t1."S_SECTOR_ID" = t3."S_SECTOR_ID"
)

// 18
select "N_SECTOR_ID",
    count("S_SECTOR_ID") as cnt
from "tbadjcell"
where "S_SECTOR_ID" in (
    select "SECTOR_ID"
    from "tbcell"
    where "ENODEBID" = 15114
  )
group by "N_SECTOR_ID"
having "cnt" >= 2

// 19
select "小区", avg("RRC建立成功率qf (%)") as avg_rrc
from (select "小区", "RRC建立成功率qf (%)" from "tbcellkpi" 
    where "起始时间" between '2020-7-17' and '2020-7-19')
group by "小区"
having avg("RRC建立成功率qf (%)") > 0.992

// 3.1(1)
CREATE TABLE tbCellCopy(
	"CITY"          varchar(255),
    "SECTOR_ID"     varchar(50)     primary key not null,
    "SECTOR_NAME"   varchar(255)    unique not null,
    "ENODEBID"      int             not null,
    "ENODEB_NAME"   varchar(255),
    "EARFCN"        int,
    "PCI"           int,
    "PSS"           int,
    "SSS"           int,
    "TAC"           int,
    "VENDOR"        varchar(255),
    "LONGITUDE"     float           default 112.77068,
    "LATITUDE"      float           default 33.810396,
    "STYLE"         varchar(255),
    "AZIMUTH"       float           default 0,
    "HEIGHT"        float           default 20,
    "ELECTTILT"     float,
    "MECHTILT"      float,
    "TOTLETILT"     float,
    check ("EARFCN" in (37900,38098,38400,38950,39148)),
    check ("PCI" between 0 and 503),
    check ("PCI" = 3 * "SSS" + "PSS"),
    check ("PSS" in (0,1,2)),
    check ("SSS" between 0 and 167)
);

// 3.1(2)
alter table tbCell
add constraint "PK_SECTOR_ID"
primary key("SECTOR_ID")

alter table tbCell
add constraint "UQ_SECTOR_NAME"
unique ("SECTOR_NAME")

create table ENODEB(
    "CITY"          varchar(255),
    "ENODEBID"      int             primary key not null,
    "ENODEB_NAME"   varchar(255),
    "VENDOR"        varchar(255),
    "LONGITUDE"     float           default 112.77068,
    "LATITUDE"      float           default 33.810396,
    "STYLE"         varchar(255)
);

alter table tbCell
add constraint "FK_ENODEBID"
foreign key ("ENODEBID") references "enodeb"("ENODEBID")

alter table tbCell
add constraint "CK_PCI" 
check ("PCI" = 3 * "SSS" + "PSS")

alter table tbCell
alter "LONGITUDE"
set default 112.77068

// 3.2.1
select "SECTOR_ID", count(*)
from "tbcell"
group by "SECTOR_ID"
having count(*)>1

insert into "tbcell"("SECTOR_NAME","ENODEBID")
values('sector_name',0)

update "tbcell"
set "SECTOR_ID" = '124672-0'
where "SECTOR_ID" = '124672-1'

insert into "tbcell"("SECTOR_ID","SECTOR_NAME","ENODEBID")
values('124672-0','sector_name',0)

update "tbcell"
set "SECTOR_ID" = null
where "SECTOR_ID" = '124672-1'

// 3.2.2
select "SECTOR_NAME", count(*)
from "tbcell"
group by "SECTOR_NAME"
having count(*)>1

insert into "tbcell"("SECTOR_ID","ENODEBID")
values('sector_id',0)

update "tbcell"
set "SECTOR_NAME" = 'A池刘果-HLHF-1'
where "SECTOR_NAME" = 'A池刘果-HLHF-2'

insert into "tbcell"("SECTOR_ID","SECTOR_NAME","ENODEBID")
values('sector_id','A池刘果-HLHF-1',0)

update "tbcell"
set "SECTOR_NAME" = null
where "SECTOR_NAME" = 'A池刘果-HLHF-2'

// 3.2.3
insert into "tbcell"("SECTOR_NAME","SECTOR_ID")
values('sector_name','sector_id')

update "tbcell"
set "ENODEBID" = null
where "SECTOR_NAME" = 'A池刘果-HLHF-2'

// 3.2.4
insert into "tbcell"("SECTOR_NAME","SECTOR_ID","ENODEBID","PCI","SSS","PSS")
values('sector_name','sector_id',0,600,1,1)

update "tbcell"
set "PCI" = 600
where "SECTOR_NAME" = 'A池刘果-HLHF-2'

// 3.2.5
insert into "tbcell"("SECTOR_NAME","SECTOR_ID","ENODEBID")
values('sector_name','sector_id',0)

select * from "tbcell"
where "SECTOR_NAME" = 'sector_name'
    and "SECTOR_ID" = 'sector_id'
    and "ENODEBID" = 0

update "tbcell"
set "LONGITUDE" = null
where "SECTOR_NAME" = 'A池刘果-HLHF-1'

select * from "tbcell"
where "SECTOR_NAME" = 'A池刘果-HLHF-1'

// 3.3.1
select "N_SECTOR_ID"
from "tbadjcell"
where "N_SECTOR_ID" not in (select "SECTOR_ID" from "tbcell")

delete from "tbadjcell"
where "N_SECTOR_ID" not in (select "SECTOR_ID" from "tbcell")

Alter table "tbadjcell"
Add constraint "FK_N_SECTOR_ID"
foreign key("N_SECTOR_ID") references "tbcell"("SECTOR_ID")

// 3.3.2
insert into "tbadjcell"("S_SECTOR_ID","N_SECTOR_ID","S_EARFCN","N_EARFCN")
values('124673-1','15290-128',38400,38400)

select * 
from "tbadjcell"
where "S_SECTOR_ID" = '124673-1'
    and "N_SECTOR_ID" = '15290-128'

update "tbadjcell"
set "S_EARFCN" = 38500
where "S_SECTOR_ID" = '124673-1'
    and "N_SECTOR_ID" = '15290-128'

select * 
from "tbadjcell"
where "S_SECTOR_ID" = '124673-1'
    and "N_SECTOR_ID" = '15290-128'

delete from "tbadjcell"
where "S_SECTOR_ID" = '124673-1'
    and "N_SECTOR_ID" = '15290-128'

select * 
from "tbadjcell"
where "S_SECTOR_ID" = '124673-1'
    and "N_SECTOR_ID" = '15290-128'

insert into "tbadjcell"("S_SECTOR_ID","N_SECTOR_ID","S_EARFCN","N_EARFCN")
values('124673-1','15290-130',38400,38400)

update "tbadjcell"
set "N_SECTOR_ID" = '15290-230'
where "S_SECTOR_ID" = '124673-1'
    and "N_SECTOR_ID" = '15290-128'

// 3.3.3
alter table "tbadjcell"
drop constraint "FK_N_SECTOR_ID"

alter table "tbadjcell"
add constraint "FK_N_SECTOR_ID"
foreign key("N_SECTOR_ID") references "tbcell"("SECTOR_ID")
on delete cascade
on update cascade

insert into "tbadjcell"("S_SECTOR_ID","N_SECTOR_ID","S_EARFCN","N_EARFCN")
values('124673-1','15290-128',38400,38400)

select * 
from "tbadjcell"
where "S_SECTOR_ID" = '124673-1'
    and "N_SECTOR_ID" = '15290-128'

update "tbadjcell"
set "S_EARFCN" = 38500
where "S_SECTOR_ID" = '124673-1'
    and "N_SECTOR_ID" = '15290-128'

select * 
from "tbadjcell"
where "S_SECTOR_ID" = '124673-1'
    and "N_SECTOR_ID" = '15290-128'

delete from "tbadjcell"
where "S_SECTOR_ID" = '124673-1'
    and "N_SECTOR_ID" = '15290-128'

select * 
from "tbadjcell"
where "S_SECTOR_ID" = '124673-1'
    and "N_SECTOR_ID" = '15290-128'

insert into "tbadjcell"("S_SECTOR_ID","N_SECTOR_ID","S_EARFCN","N_EARFCN")
values('124673-1','15290-130',38400,38400)

update "tbadjcell"
set "N_SECTOR_ID" = '15290-230'
where "S_SECTOR_ID" = '124673-1'
    and "N_SECTOR_ID" = '15290-128'

// 3.4
select T1."ENODEBID", T1."LONGITUDE",
    T2."LONGITUDE", T1."LATITUDE", T2."LATITUDE"
from "tbcell" as T1, "tbcell" as T2
where T1."ENODEBID" = T2."ENODEBID"
    and (T1."LONGITUDE" <> T2."LONGITUDE" 
    OR T1."LATITUDE" <> T2."LATITUDE")

// 3.5
create trigger trigger_inserte before insert
on "tbcell" [
    delete from "tbcell"
    where "SECTOR_ID" = new."SECTOR_ID"
];

124672-0


create or replace function tri_insert_func() returns trigger as
$$ 
declare
begin
    delete from "tbcell"
    where "SECTOR_ID" = new."SECTOR_ID";
    return new;
end
$$ language plpgsql;
create trigger insert_trigger
before insert on "tbcell"
for each row
execute procedure tri_insert_func();


DECLARE 
BEGIN 
        INSERT INTO test_trigger_des_tbl VALUES(NEW.id1, NEW.id2, NEW.id3); 
        RETURN NEW; 
END 
$$ LANGUAGE PLPGSQL; 

CREATE OR REPLACE FUNCTION tri_insert_func() RETURNS TRIGGER AS 
           $$ 
           DECLARE 
           BEGIN 
                   INSERT INTO test_trigger_des_tbl VALUES(NEW.id1, NEW.id2, NEW.id3); 
                   RETURN NEW; 
           END 
           $$ LANGUAGE PLPGSQL; 


CREATE TRIGGER example_trigger AFTER INSERT ON COMPANY FOR EACH ROW EXECUTE PROCEDURE auditlogfunc();
CREATE OR REPLACE FUNCTION auditlogfunc() RETURNS TRIGGER AS $example_table$
   BEGIN
      INSERT INTO AUDIT(EMP_ID, ENTRY_DATE) VALUES (new.ID, current_timestamp);
      RETURN NEW;
   END;
$example_table$ LANGUAGE plpgsql;