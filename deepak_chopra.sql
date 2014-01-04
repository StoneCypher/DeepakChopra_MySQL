
-- why yes, this is awful and wasteful dogmatic code
-- did you expect something like this to be efficient?
-- have some fun, damnit



-- \. c:\projects\DeepakChopra_SQL\deepak_chopra.my.sql

select "requires you to USE a database before running" as "!!! WARNING !!!";



select "cleaning up old state" as "process step";

drop table if exists terms;
drop table if exists kinds;

drop procedure if exists insertterm;
drop procedure if exists speak;



select "creating tables" as "process step";

create table kinds(id tinyint auto_increment primary key, label varchar(255));
create table terms(id tinyint auto_increment primary key, label varchar(255), kind tinyint, foreign key(kind) references kinds(id));




select "creating functions and procedures" as "process step";

delimiter //

create procedure insertterm(IN ulabel varchar(255), IN ukind varchar(255))
begin
  
  declare tid tinyint;
  set tid = (select id from kinds where label like ukind limit 1);
  insert into terms(label, kind) values(ulabel, tid);

end//

create procedure speak()
begin
  
  declare st varchar(255);
  declare mi varchar(255);
  declare qu varchar(255);
  declare fi varchar(255);

  set st = (select terms.label from terms join kinds on terms.kind = kinds.id where kinds.label like 'starts'     order by rand() limit 1);
  set mi = (select terms.label from terms join kinds on terms.kind = kinds.id where kinds.label like 'middles'    order by rand() limit 1);
  set qu = (select terms.label from terms join kinds on terms.kind = kinds.id where kinds.label like 'qualifiers' order by rand() limit 1);
  set fi = (select terms.label from terms join kinds on terms.kind = kinds.id where kinds.label like 'finishes'   order by rand() limit 1);

  select concat(st, mi, qu, fi) as "Deepak Chopra sez ...";

end//

delimiter ;



select "populating tables" as "process step";

insert into kinds(label) values('starts'),('middles'),('qualifiers'),('finishes');

call insertterm('Experiential truth ', 'starts');
call insertterm('The physical world ', 'starts');
call insertterm('Non-judgment ',       'starts');
call insertterm('Quantum physics ',    'starts');

call insertterm('nurtures an ',        'middles');
call insertterm('projects onto ',      'middles');
call insertterm('imparts reality to ', 'middles');
call insertterm('constructs with ',    'middles');

call insertterm('abundance of ',       'qualifiers');
call insertterm('the barrier of ',     'qualifiers');
call insertterm('self-righteous ',     'qualifiers');
call insertterm('potential ',          'qualifiers');

call insertterm('marvel.',             'finishes');
call insertterm('choices.',            'finishes');
call insertterm('creativity.',         'finishes');
call insertterm('actions.',            'finishes');

