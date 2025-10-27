drop table t_board;

create table t_board(
   board_idx NUMBER(11) PRIMARY KEY,
   title  VARCHAR2(300) NOT NULL,
   content VARCHAR2(4000) NOT NULL,
   hit_cnt NUMBER(10) DEFAULT 0 NOT NULL,
   created_datetime DATE  DEFAULT SYSDATE,
   creator_id VARCHAR2(50) NOT NULL,
   updated_datetime DATE  DEFAULT NULL,
   updator_id VARCHAR2(50) DEFAULT NULL,
   deleted_yn CHAR(1) DEFAULT 'N' NOT NULL
 );
 
drop sequence tboard_seq;
CREATE SEQUENCE tboard_seq
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;

insert into t_board( board_idx, title, content, created_datetime, creator_id)
values ( tboard_seq.nextval, '체크', '체크입니다.', sysdate, 'kim' );
commit;